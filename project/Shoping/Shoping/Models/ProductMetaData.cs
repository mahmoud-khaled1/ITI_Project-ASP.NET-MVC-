using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Shoping.Models
{

    [MetadataType(typeof(ProductMetaData))]
    public partial class product
    {

    }
    public class ProductMetaData
    {
        public int pro_id { get; set; }

        [Required(ErrorMessage = "product name is required")]
        [Display(Name = "Product Name")]
        public string pro_name { get; set; }

        [Required(ErrorMessage = "photo is required")]
        [Display(Name = "Image")]
        public string pro_image { get; set; }

        [Required(ErrorMessage = "Price is required")]
        [DataType(DataType.Currency)]
        [Display(Name = "Price")]
        public int pro_price { get; set; }

        [Required(ErrorMessage = "Description is required")]
        [Display(Name = "Description")]
        public string pro_description { get; set; }
        


    }
}