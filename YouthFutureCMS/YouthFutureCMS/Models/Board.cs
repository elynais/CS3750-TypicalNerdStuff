using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Board
    {
        public int boardId { get; set; }
        public string boardMemberName { get; set; }
        public string boardMemberTitle { get; set; }
        public int staffId { get; set; }
        public int imageId { get; set; }

        //join to staff table here??
        //join to image table here??
    }
    public class BoardContext : DbContext
    {
        public DbSet<Board> board { get; set; }
    }

}