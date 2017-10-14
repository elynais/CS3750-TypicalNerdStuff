using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using YouthFutureCMS.Models;
using YouthFutureCMS.ViewModels;

namespace YouthFutureCMS.Controllers
{
    public class SecondaryController : Controller
    {
        // GET: Secondary
        public ActionResult Index()
        {
            using (var dbContext = new YouthFutureDbEntities())
            {
                var contents = dbContext.Contents.Include(c => c.Image).Include(c => c.File).Where(c => c.PageNum == 2).ToList();

                var columns = dbContext.Columns.Include(c => c.Image).ToList();

                var staffs = dbContext.Staffs.Include(s => s.Image).Where(s => s.StaffStatus == "A" && s.BoardTitle == null).ToList();

                var boardDirectors = dbContext.Staffs.Include(bd => bd.Image).Where(bd => bd.StaffStatus == "A" && bd.BoardTitle != null).ToList();

                var donors = dbContext.Donors.Where(d => d.DonorStatus == "A").ToList();

                SecondaryIndexViewModel indexViewModel = new SecondaryIndexViewModel(contents, columns, staffs, boardDirectors, donors);

                return View(indexViewModel);             
            }
        }
    }
}