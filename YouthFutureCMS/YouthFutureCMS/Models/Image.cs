using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class Image
    {
        public int imageId  {get;set; }
        public string imagePath {get;set;}
    }
    public class ImageContext : DbContext
    {
        public DbSet<Image> images { get; set; }
    }

}