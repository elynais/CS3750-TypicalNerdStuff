using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.Controllers
{
    public class ErrorController : Controller
    {
        //
        // GET : /Error/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult NotFound()
        {
            return View();
        }
    }
}
