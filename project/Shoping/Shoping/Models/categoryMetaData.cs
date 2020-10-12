using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Shoping.Models
{
    [MetadataType(typeof(categoryMetaData))]
    public partial class category
    {

    }
    public class categoryMetaData
    {
        public int cat_id { get; set; }

        [Required(ErrorMessage = "Category is required")]
        [Display(Name = "Category Name")]
        public string cat_name { get; set; }

        [Required(ErrorMessage = "Photo of Category is required")]
        [Display(Name = "Category image")]
        public string cat_image { get; set; }

        public Nullable<int> cat_fk_ad { get; set; }
        public bool cat_status { get; set; }
    }
}