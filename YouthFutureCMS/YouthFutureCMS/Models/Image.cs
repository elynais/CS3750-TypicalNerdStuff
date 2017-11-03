using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Image
    {
        [Key]
        [Display(Name = "Id")]
        public int image_Id { get; set; }
        [Display(Name = "Path/URL")]
        public string imagePath { get; set; }
    }
    public class ImageContext : DbContext
    {
        public ImageContext() : base("name=SystemDataContext") { }
        public DbSet<Image> images { get; set; }
    }
}