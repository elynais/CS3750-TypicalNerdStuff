using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace YouthFutureCMS.Models
{
    public class Staff
    {
        public int staffId { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string staffEmail { get; set; }
        public string staffTitle { get; set; }
        public string boardTitle { get; set; }
        public Image image { get; set; }
        public string staffStatus { get; set; }
    }

    public class StaffContext : DbContext
    {
        public DbSet<Staff> staff { get; set; }
    }
}