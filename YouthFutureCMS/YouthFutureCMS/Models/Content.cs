using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Content
    {
        [Key]
        public int content_Id { get; set; }
        public int image_Id { get; set; }
        public string contentName { get; set; }
        public string contentInfo { get; set; }
        public int pageNum { get; set; }

    }
    public class ContentContext : DbContext
    {
        public ContentContext() : base("name=SystemDataContext") { }
        public DbSet<Content> content { get; set; }
    }
}