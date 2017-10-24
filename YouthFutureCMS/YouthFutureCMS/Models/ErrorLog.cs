using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class ErrorLog
    {
        public int errorId { get; set; }
        public string errorDesc { get; set; }
        public DateTime errorDate { get; set; }
        public int userId { get; set; }

        //join user here? public virtual User user {get;set;} ??
    }
    public class ErrorLogContext : DbContext
    {
        public DbSet<ErrorLog> errors { get; set; }
    }
}