using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.Controllers
{
	public class CustomErrorUseController : Controller
    {
		//
		// GET : /CustomErrorUse/

		[HandleError]
		public ActionResult Index()
        {
            return View();
        }
    }
}
