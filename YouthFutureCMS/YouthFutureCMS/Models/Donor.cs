using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Donor
    {
        [Key]
        [Display(Name = "Id")]
        public int donor_Id { get; set; }
        [Display(Name = "Full Name")]
        public string donorName { get; set; }
        [Display(Name = "Year(s)")]
        public string donorYear { get; set; }
        [Display(Name = "Level")]
        public string donorLevel { get; set; }
        [Display(Name = "Status")]
        public string donorStatus { get; set; }
    }
    public class DonorContext : DbContext
    {
        public DonorContext() : base("name=SystemDataContext") { }
        public DbSet<Donor> donors { get; set; }
    }
}