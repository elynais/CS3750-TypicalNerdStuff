using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class User
    {
        public int userId { get; set; }
        public string userName { get; set; }
        public string userPassword { get; set; }
        public Staff staff { get; set; }
    }
    public class UserContext : DbContext
    {
        public DbSet<User> users { get; set; }
    }

}