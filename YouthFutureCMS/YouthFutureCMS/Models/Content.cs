using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class Content
    {
        public int contentId  { get; set; }
        public Image image { get; set; }
        public string contentName { get; set; }
        public string contentInfo { get; set; }
        public File file { get; set; }
        public int pageNumber { get; set; }
    }
    public class ContentContext : DbContext
    {
        public DbSet<Content> content { get; set; }
    }
}