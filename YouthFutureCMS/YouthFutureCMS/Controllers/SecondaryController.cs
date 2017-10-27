using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.Controllers
{
    public class SecondaryController : Controller
    {

        public ActionResult Index()
        {
            return View();
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