﻿using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Donor
    {
        public int donorId { get; set; }
        public string donorName { get; set; }
        public string donorYear { get; set; }
        public string donorLevel { get; set; }
        public string donorStatus { get; set; }
    }
    public class DonorContext : DbContext
    {
        public DbSet<Donor> donors { get; set; }
    }
}