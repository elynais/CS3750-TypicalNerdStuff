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
        [Display(Name = "Column Id")]
        public int column_Id { get; set; }
        [Display(Name = "Header")]
        public string columnHeader { get; set; }
        [Display(Name = "Description of Column")]
        public string columnDesc { get; set; }
        [Display(Name = "Column Content")]
        public string columnInfo { get; set; }
        [Display(Name = "Column Link")]
        public string columnLink { get; set; }
        [Display(Name = "Link Description")]
        public string columnLinkDesc { get; set; }
        [Display(Name = "Image")]
        public int image_Id { get; set; }
        [Display(Name = "Section Number")]
        public int sectionNumber { get; set; }

    }
    public class ColumnContext : DbContext
    {
        public ColumnContext() : base("name=SystemDataContext") { }
        public DbSet<Column> columns { get; set; }
    }
}