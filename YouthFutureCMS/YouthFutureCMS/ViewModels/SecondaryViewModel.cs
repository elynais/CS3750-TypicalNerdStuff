using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.ViewModels
{
    public class SecondaryIndexViewModel
    {
        public List<Content> Contents { get; set; }
        public List<Column> Columns { get; set; }
        public List<Staff> Staffs { get; set; }
        public List<Staff> BoardDirectors { get; set; }
        public List<Donor> Donors { get; set; }

        public SecondaryIndexViewModel(List<Content> contents, List<Column> columns, List<Staff> staffs, List<Staff> boardDirectors, List<Donor> donors)
        {
            Contents = contents;
            Columns = columns;
            Staffs = staffs;
            BoardDirectors = boardDirectors;
            Donors = donors;
        }

        public string GetContentInfo(string name)
        {
            return Contents.Find(c => c.ContentName == name).ContentInfo;
        }

        public List<Column> GetColumnList(int sectionNum)
        {
            return Columns.Where(c => c.SectionNumber == sectionNum).ToList();
        }
    }
}