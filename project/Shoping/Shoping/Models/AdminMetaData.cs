using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Shoping.Models
{


    [MetadataType(typeof(AdminMetaData))]
    public partial class admin
    {

    }
    public class AdminMetaData
    {
        public int ad_id { get; set; }

        [Required(ErrorMessage = "username is required")]
        [StringLength(50, MinimumLength = 3,
        ErrorMessage = "user Name should be minimum 3 characters and a maximum of 50 characters")]
        [Display(Name = "Username")]
        public string ad_username { get; set; }

        [Required]
        [Display(Name = "Password")]
        [DataType(DataType.Password)]
        public string ad_password { get; set; }


    }
}