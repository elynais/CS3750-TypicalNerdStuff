using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class User
    {
        [Key]
        public int user_Id { get; set; }
        public string userName { get; set; }
        public string Password { get; set; }
        public int staff_Id { get; set; }

        //join staff here? public virtual Staff staff {get;set;} ??
    }
    public class UserContext : DbContext
    {
        public UserContext() : base("name=SystemDataContext") { }
        public DbSet<User> users { get; set; }
    }
}