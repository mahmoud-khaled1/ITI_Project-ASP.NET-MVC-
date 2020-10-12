using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Shoping.Models;
using System.IO;
using PagedList;
namespace Shoping.Controllers
{
    
    public class AdminController : Controller
    {
        marketingEntities1 context = new marketingEntities1();
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult login(admin ad)
        {
            admin a = context.admins.Where(adm => adm.ad_username == ad.ad_username && adm.ad_password == ad.ad_password).FirstOrDefault();

            if (a != null)
            {
                Session["name"] = a.ad_username.ToString();
                Session["ad_id"] = a.ad_id.ToString();
                 return RedirectToAction("ViewCategory");
            }
            else
            {
                ViewBag.error = "invalid username or password";
                return View(ad);
            }

        }

        //Add new Category
        [HttpGet]
        public ActionResult create()
        {
            if (Session["ad_id"]==null)
            {
                return RedirectToAction("login");
            }
            return View();
        }
       [HttpPost]
        public ActionResult create(category c,HttpPostedFileBase imgfile)
        {

            if (context.categories.Any(ca => ca.cat_name.Equals(c.cat_name)))
            {

                ModelState.AddModelError("", "Category Already Found");
                return View(c);

            }
           
            string path = uploadimgfile(imgfile);
            if(path.Equals("-1"))
            {
                ViewBag.error = "Image could not be uploaded......";

            }
            else
            {
                category cat = new category();
                cat.cat_name = c.cat_name;
                cat.cat_image = path;
                cat.cat_status = true;
                cat.cat_fk_ad = Convert.ToInt32(Session["ad_id"].ToString());
                context.categories.Add(cat);
                context.SaveChanges();
                return RedirectToAction("ViewCategory");
                  
            }
                
            return View();
        }


        public string uploadimgfile(HttpPostedFileBase file)
        {
            Random r = new Random();
            string path = "-1";
            int random = r.Next();
            if(file!=null&&file.ContentLength>0)
            {
                string extension = Path.GetExtension(file.FileName);
                if(extension.ToLower().Equals(".jpg")||extension.ToLower().Equals(".jpeg")||extension.ToLower().Equals(".png"))
                {
                    try
                    {
                        path = Path.Combine(Server.MapPath("~/Content/upload"), random + Path.GetFileName(file.FileName));
                        file.SaveAs(path);
                        path = "~/Content/upload/" + random + Path.GetFileName(file.FileName);

                    }
                    catch (Exception ex)
                    {
                        path = "-1";

                    }
                }
                else
                {
                    Response.Write("<script>alert('only jpg , jpeg , png format are accepted');</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('please select a file');</script>");
                path = "-1";
            }
            return path;
        }

        //view all category
        public ActionResult ViewCategory(int?page)
        {
            int pagesize = 7, pageindex = 1;
            pageindex = page.HasValue ? Convert.ToInt32(page) : 1;
            var listt = context.categories.Where(x => x.cat_status == true).OrderByDescending(x=>x.cat_id).ToList();
            IPagedList<category> s = listt.ToPagedList(pageindex, pagesize);
            return View(s);
        }


        //--------------------------------------------------


        [HttpGet]
        public ActionResult CreatedAd()
        {
            List<category> li = context.categories.ToList();
            ViewBag.categorylist = new SelectList(li, "cat_id", "cat_name");
            return View();
        }

        [HttpPost]
        public ActionResult CreatedAd(product pro, HttpPostedFileBase file)
        {
            List<category> li = context.categories.ToList();
            ViewBag.categorylist = new SelectList(li, "cat_id", "cat_name");


            string path = uploadimgfile(file);
            if (path.Equals("-1"))
            {
                ViewBag.error = "Image could not be uploaded....";
            }
            else
            {
                product p = new product();
                p.pro_name = pro.pro_name;
                p.pro_price = pro.pro_price;
                p.pro_image = path;
                p.pro_fk_cat = pro.pro_fk_cat;
                p.pro_description = pro.pro_description;
                //p.pro_fk_userr = Convert.ToInt32(Session["ad_id"].ToString());
                context.products.Add(p);
                context.SaveChanges();
                Response.Redirect("ViewCategory");
            }

            return View();

        }
        [HttpGet]
        public ActionResult SignUp()
        {
            return View();
        }
        [HttpPost]
        public ActionResult SignUp(admin ad)
        {

            if (context.admins.Any(c => c.ad_username.Equals(ad.ad_username)))
            {

                ModelState.AddModelError("", "Admin Already Found");
                return View(ad);

            }
            if (ModelState.IsValid == false)
            {
                return View(ad);
            }

            admin a = new admin();
                a.ad_username = ad.ad_username;
                a.ad_password = a.ad_password;
                context.admins.Add(a);
                context.SaveChanges();
                return RedirectToAction("login","User");
        }

        public ActionResult Signout()
        {
            Session.RemoveAll();
            Session.Abandon();

            return RedirectToAction("login","User");

        }


        //show all product in specific category
        public ActionResult Ads(int? id, int? page)
        {
            int pagesize = 9, pageindex = 1;
            pageindex = page.HasValue ? Convert.ToInt32(page) : 1;
            var listt = context.products.Where(x => x.pro_fk_cat == id).OrderByDescending(x => x.pro_id).ToList();
            //TempData["id_cat"] = id.ToString();
            IPagedList<product> s = listt.ToPagedList(pageindex, pagesize);
            return View(s);

        }
        [HttpPost]
        public ActionResult Ads(int? id, int? page, string search)
        {

            //int id_catt = Convert.ToInt32(TempData["id_cat"]);
            int pagesize = 7, pageindex = 1;
            pageindex = page.HasValue ? Convert.ToInt32(page) : 1;
            var listt = context.products.Where(x => x.pro_name.Contains(search)).OrderByDescending(x => x.pro_id).ToList();
            IPagedList<product> s = listt.ToPagedList(pageindex, pagesize);
            return View(s);


        }

        //show specific product details
        public ActionResult ViewAd(int? id)
        {
            Adviewmodel ad = new Adviewmodel();
            product p = context.products.Where(x => x.pro_id == id).SingleOrDefault();
            ad.pro_id = p.pro_id;
            ad.pro_name = p.pro_name;
            ad.pro_image = p.pro_image;
            ad.pro_price = p.pro_price;
            ad.pro_des = p.pro_description;
            category cat = context.categories.Where(x => x.cat_id == p.pro_fk_cat).SingleOrDefault();
            ad.cat_name = cat.cat_name;

            return View(ad);
        }

        //Delete specific product 
        public ActionResult DeleteAd(int? id)
        {
           
            product p = context.products.Where(x => x.pro_id == id).SingleOrDefault();
            int id_catt = p.category.cat_id;
            context.products.Remove(p);
            context.SaveChanges();

            return RedirectToAction("Ads",id_catt);

        }

        public ActionResult DeleteCat(int? id)
        {


            category ca = context.categories.Where(x => x.cat_id == id).FirstOrDefault();

            List<product> p = context.products.Where(x => x.pro_fk_cat == id).ToList();
            
            foreach(var item in p)
            {
                context.products.Remove(item);
                context.SaveChanges();
            }
            context.categories.Remove(ca);
            context.SaveChanges();

            return RedirectToAction("ViewCategory");

        }


    }
}