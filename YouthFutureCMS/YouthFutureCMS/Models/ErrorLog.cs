using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class ErrorLog
    {
        [Key]
        public int errorLog_Id { get; set; }
        public string errorDesc { get; set; }
        public DateTime errorDatetime { get; set; }
        public int user_Id { get; set; }

        //join user here? public virtual User user {get;set;} ??
    }
    public class ErrorLogContext : DbContext
    {
        public ErrorLogContext() : base("name=SystemDataContext") { }
        public DbSet<ErrorLog> errors { get; set; }
    }
}