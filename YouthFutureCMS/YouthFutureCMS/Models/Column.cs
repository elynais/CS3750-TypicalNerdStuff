﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class Column
    {
        public int columnId { get; set; }
        public string columnHeader { get; set; }
        public string columnDesc { get; set; }
        public string columnLink { get; set; }
        public Image image { get; set; }
        public int sectionNum { get; set; }
    }
    public class ColumnContext : DbContext
    {
        public DbSet<Column> columns { get; set; }
    }
}