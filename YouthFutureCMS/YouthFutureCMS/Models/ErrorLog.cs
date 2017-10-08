using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class ErrorLog
    {
        public int errorId{ get; set; }
        public string errorDesc { get; set; }
        public DateTime errorDate { get; set; }
        public User user { get; set; }
    }
    public class ErrorLogContext : DbContext
    {
        public DbSet<ErrorLog> errors { get; set; }
    }

}