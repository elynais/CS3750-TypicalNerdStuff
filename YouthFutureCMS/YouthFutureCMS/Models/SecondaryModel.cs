using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class SecondaryModel
    {
        /* Declare all DbSets of Info for use in Models below*/
        public DbSet<Column> columns { get; set; }

        public DbSet<Content> content { get; set; }

        public DbSet<Donor> donors { get; set; }

        public DbSet<Board> board { get; set; }

        public DbSet<Image> images { get; set; }

        public DbSet<Staff> staff { get; set; }

        /* Model used for Secondary page View content */
    }
}