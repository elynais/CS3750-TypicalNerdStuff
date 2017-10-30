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
        [Display(Name = "Id")]
        public int staffId { get; set; }
        [Display(Name = "First Name")]
        public string firstName { get; set; }
        [Display(Name = "Last Name")]
        public string lastName { get; set; }
        [Display(Name = "Email")]
        public string staffEmail { get; set; }
        [Display(Name = "Title")]
        public string staffTitle { get; set; }
        [Display(Name = "Board Title")]
        public string boardTitle { get; set; }
        [Display(Name = "Status")]
        public string staffStatus { get; set; }
        [Display(Name = "Image Id")]
        public int imageId { get; set; }

        //join image here? public virtual Image image {get;set;} ??
    }

    public class StaffContext : DbContext
    {
        public DbSet<Staff> staff { get; set; }
    }
}