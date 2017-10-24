using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Image
    {
        public int imageId { get; set; }
        public string imagePath { get; set; }
    }
    public class ImageContext : DbContext
    {
        public DbSet<Image> images { get; set; }
    }
}