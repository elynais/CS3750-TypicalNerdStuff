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
        [Display(Name = "Id")]
        public int imageId { get; set; }
        [Display(Name = "Path/URL")]
        public string imagePath { get; set; }
    }
    public class ImageContext : DbContext
    {
        public DbSet<Image> images { get; set; }
    }
}