using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class SystemDataContext
    {
        public DbSet<Column> columns { get; set; }

        public DbSet<Content> content { get; set; }

        public DbSet<Donor> donors { get; set; }

        public DbSet<ErrorLog> errors { get; set; }

        public DbSet<Board> board { get; set; }

        public DbSet<Image> images { get; set; }

        public DbSet<Staff> staff { get; set; }

        public DbSet<User> users { get; set; }
    }
}