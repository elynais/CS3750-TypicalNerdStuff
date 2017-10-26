using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Board
    {
        [Display(Name = "Id")]
        public int boardId { get; set; }
        [Display(Name = "First Name")]
        public string boardMemberFirstName { get; set; }
        [Display(Name = "Last Name")]
        public string boardMemberLastName { get; set; }
        [Display(Name = "Title")]
        public string boardMemberTitle { get; set; }
        [Display(Name = "Staff Id")]
        public int staffId { get; set; }
        [Display(Name = "Image Id")]
        public int imageId { get; set; }

        //join to staff table here??
        //join to image table here??
    }
    public class BoardContext : DbContext
    {
        public DbSet<Board> board { get; set; }
    }

}