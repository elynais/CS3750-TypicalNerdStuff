using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Content
    {
        public int contentId { get; set; }
        public int imageId { get; set; }
        public string contentName { get; set; }
        public string contentInfo { get; set; }
        public int fileId { get; set; }
        public int pageNumber { get; set; }

        //image join here? public virtual Image image {get;set;}??
        //file join here? public virtual File file {get;set;}??
    }
    public class ContentContext : DbContext
    {
        public DbSet<Content> content { get; set; }
    }
}