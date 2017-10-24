using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.Controllers
{
    public class HomeController : Controller
    {
        private SystemDataContext data = new SystemDataContext();

        public ActionResult Index()
        {
            //pass the data sets to the view and map from there??
            return View(data);
        }

        //editing view here?
        /*
         public ActionResult Edit()
         {
             return View(data);
         }
         */

    }
}