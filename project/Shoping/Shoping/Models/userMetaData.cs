using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Shoping.Models
{


    [MetadataType(typeof(userMetaData))]
    public partial class userr
    {

    }
    public class userMetaData
    {

        public int userr_id { get; set; }

        [Required(ErrorMessage = "name is required")]
        [Display(Name = "Name")]
        public string userr_name { get; set; }

        [Required(ErrorMessage = "Email is required")]
        [Display(Name = "Email")]
        public string userr_email { get; set; }

        [Required(ErrorMessage = "Password is required")]
        [Display(Name = "password")]
        [DataType(DataType.Password)]
        public string userr_password { get; set; }

        [Required(ErrorMessage = "Phone is required")]
        [Display(Name = "Phone")]
        public string userr_phone { get; set; }


        [Required(ErrorMessage = "photo is required")]
        [Display(Name = "Image")]
        public string userr_image { get; set; }

    }
}