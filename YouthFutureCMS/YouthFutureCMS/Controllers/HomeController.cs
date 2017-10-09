using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;
using YouthFutureCMS.ViewModel;

namespace YouthFutureCMS.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (var db = new YouthFutureDbEntities())
            {
                var contents = (from c in db.Contents
                               where c.PageNum == 1
                               orderby c.Content_id
                               select c)
                               .ToList();

                var columns = db.Columns.Include(c => c.Image).ToList();

                HomeIndexViewModel index = new HomeIndexViewModel(contents, columns);
                
                return View(index);
            }
        }

    }
}