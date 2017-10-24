using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class User
    {
        public int userId { get; set; }
        public string userName { get; set; }
        public string userPassword { get; set; }
        public int staffId { get; set; }

        //join staff here? public virtual Staff staff {get;set;} ??
    }
    public class UserContext : DbContext
    {
        public DbSet<User> users { get; set; }
    }
}