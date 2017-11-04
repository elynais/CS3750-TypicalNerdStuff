using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;


namespace YouthFutureCMS.Models
{
    public class Column
    {
        [Key]
        public int column_Id { get; set; }
        public string columnHeader { get; set; }
        public string columnDesc { get; set; }
        public string columnInfo { get; set; }
        public string columnLink { get; set; }
        public string columnLinkDesc { get; set; }
        public int image_Id { get; set; }
        public int sectionNumber { get; set; }

        //image join here? public virtual Image image {get;set;}
    }
    public class ColumnContext : DbContext
    {
        public ColumnContext() : base("name=SystemDataContext") { }
        public DbSet<Column> columns { get; set; }
    }
}