using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class File
    {
        public int fileId { get; set; }
        public int filePath { get; set; }
    }
    public class FileContext : DbContext
    {
        public DbSet<File> files { get; set; }
    }

}