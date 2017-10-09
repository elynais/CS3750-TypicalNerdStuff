using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.ViewModel
{
    public class HomeIndexViewModel
    {
        public HomeIndexViewModel(List<Content> contents, List<Column> columns)
        {
            Contents = contents;
            Columns = columns;
        }

        public List<Content> Contents { get; set; }
        public List<Column> Columns { get; set; }

        public string GetContentInfo(string name)
        {
            return Contents.Find(c => c.ContentName == name).ContentInfo;
        }

        public List<Column> GetColumnList(int sectionNum)
        {
            var columns = Columns.Where(c => c.SectionNumber == sectionNum).ToList();
            return columns;
        }
    }
}