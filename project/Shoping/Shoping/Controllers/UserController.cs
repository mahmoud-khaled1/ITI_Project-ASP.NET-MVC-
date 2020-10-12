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
    public class UserController : Controller
    {
        
        marketingEntities1 context = new marketingEntities1();

        //View All Category 
        public ActionResult Index(int?page)
        {

            int pagesize = 7, pageindex = 1;
            pageindex = page.HasValue ? Convert.ToInt32(page) : 1;
            var listt = context.categories.Where(x => x.cat_status == true).OrderByDescending(x => x.cat_id).ToList();
            IPagedList<category> s = listt.ToPagedList(pageindex, pagesize);
            return View(s);
           
        }

        public ActionResult login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login(userr us)
        {
            userr a = context.userrs.Where(u => u.userr_name == us.userr_name && u.userr_password == us.userr_password).FirstOrDefault();
            admin a2 = context.admins.Where(u2 => u2.ad_username == us.userr_name && u2.ad_password == us.userr_password).FirstOrDefault();
            if (a != null)
            {
                Session["u_name"] = a.userr_name.ToString();
                Session["u_id"] = a.userr_id.ToString();
                return RedirectToAction("Index");
            }
            
            else if (a2!=null)
            {
                Session["name"] = a2.ad_username.ToString();
                Session["ad_id"] = a2.ad_id.ToString();
                return RedirectToAction("ViewCategory","admin");
            }
            else
            {
                ViewBag.error = "invalid username or password";
                return View();
            }


            //return View();
        }
        [HttpGet]
        public ActionResult SignUp()
        {
            return View(new userr());
        }
        [HttpPost]
        public ActionResult SignUp(userr us, HttpPostedFileBase file)
        {

            if (context.userrs.Any(c => c.userr_name.Equals(us.userr_name)))
            {

                ModelState.AddModelError("", "Name Already Found");
                return View(us);

            }
            if (ModelState.IsValid == false)
            {
                return View(us);
            }


            string path = uploadimgfile(file);
            if (path.Equals("-1"))
            {
                ViewBag.error = "Image could not be uploaded......";
            }
            else
            {
                userr user1 = new userr();
                user1.userr_name = us.userr_name;
                user1.userr_email = us.userr_email;
                user1.userr_password = us.userr_password;
                user1.userr_phone = us.userr_phone;
                user1.userr_image= path;
                user1.type = "user";

                context.userrs.Add(user1);
                context.SaveChanges();
                return RedirectToAction("login");

            }

            return View();
            
        }

        //Update image and save it 
        public string uploadimgfile(HttpPostedFileBase file)
        {
            Random r = new Random();
            string path = "-1";
            int random = r.Next();
            if (file != null && file.ContentLength > 0)
            {
                string extension = Path.GetExtension(file.FileName);
                if (extension.ToLower().Equals(".jpg") || extension.ToLower().Equals(".jpeg") || extension.ToLower().Equals(".png"))
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

        //show all product in specific category
        public ActionResult Ads(int? id, int? page)
        {
            int pagesize = 9, pageindex = 1;
            pageindex = page.HasValue ? Convert.ToInt32(page) : 1;
            var listt = context.products.Where(x => x.pro_fk_cat == id).OrderByDescending(x => x.pro_id).ToList();
            IPagedList<product> s = listt.ToPagedList(pageindex, pagesize);
            return View(s);

        }
        [HttpPost]
        public ActionResult Ads(int?id,int?page,string search)
        {

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
            //userr u = context.userrs.Where(x => x.userr_id == p.pro_fk_userr).SingleOrDefault();
            //ad.u_name = u.userr_name;
            //ad.u_image = u.userr_image;
            //ad.u_contact = u.userr_phone;
            //ad.pro_fk_user = u.userr_id;

            return View(ad);
        }

        //Signout
        public ActionResult Signout()
        {
            Session.RemoveAll();
            Session.Abandon();
            return RedirectToAction("Index");

        }

        //show all item in my cart 
        [HttpGet]
        public ActionResult cart(int?id)
        {
            int idd = Convert.ToInt32(Session["u_id"].ToString());

            List<Reservation> proList = context.Reservations.Where(x => x.user_fk_id == idd).ToList();

            return View(proList);
        }

        
        //Save Reservation and go to cart
        public ActionResult to_cart()
        {
            int id_pr = Convert.ToInt32(TempData["product"].ToString());
            int idd = Convert.ToInt32(Session["u_id"].ToString());
            product p = context.products.Where(x => x.pro_id ==id_pr).FirstOrDefault();

            Reservation r = new Reservation();
            r.product_fk_id = p.pro_id;
            r.reser_date = DateTime.Now;
            r.user_fk_id = idd;
            context.Reservations.Add(r);
            context.SaveChanges();

             return RedirectToAction("cart",idd);

        }

        //Delete item from cart
        public ActionResult Delete_from_cart(int?id)
        {
             Reservation res= context.Reservations.Where(x => x.reser_id == id).FirstOrDefault();

            context.Reservations.Remove(res);
            context.SaveChanges();

            return RedirectToAction("cart");
        }







    }
}