using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;
using YouthFutureCMS.ViewModels;

namespace YouthFutureCMS.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (var dbContext = new YouthFutureDbEntities())
            {
                var contents = dbContext.Contents.Include(c => c.Image).Include(c => c.File).Where(c => c.PageNum == 1).ToList();

                var columns = dbContext.Columns.Include(c => c.Image).ToList();

                HomeIndexViewModel indexViewModel = new HomeIndexViewModel(contents, columns);
                
                return View(indexViewModel);
            }
        }

    }
}