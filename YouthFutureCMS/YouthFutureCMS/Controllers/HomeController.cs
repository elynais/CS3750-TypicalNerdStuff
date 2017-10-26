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
        /// <summary>
        /// ActionResult for the Home Index View
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            
            //pass the data sets to the view and map from there??
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