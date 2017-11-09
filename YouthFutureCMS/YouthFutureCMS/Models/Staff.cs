using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Staff
    {
        [Key]
        [Display(Name = "Id")]
        public int staff_Id { get; set; }
        [Display(Name = "First Name")]
        public string staffFirstName { get; set; }
        [Display(Name = "Last Name")]
        public string staffLastName { get; set; }
        [Display(Name = "Email")]
        public string staffEmail { get; set; }
        [Display(Name = "Title")]
        public string staffTitle { get; set; }
        [Display(Name = "Board Title")]
        public string boardTitle { get; set; }
        [Display(Name = "Status")]
        public string staffStatus { get; set; }
        [Display(Name = "Image Id")]
        public int image_Id { get; set; }

    }

    public class StaffContext : DbContext
    {
        public StaffContext() : base("name=SystemDataContext") { }
        public DbSet<Staff> staff { get; set; }
    }
}