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
        SystemDataContext data = new SystemDataContext();

        /// <summary>
        /// ActionResult for the Home Index View
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            //populate lists with dataset info
            List<Column> columns = data.columns.ToList();
            List<Content> content = data.content.ToList();
            List<Image> images = data.images.ToList();
            //Changed to this to the above code. Couldn't get this to work. 
            //List<Column> columns = data.columns.Include(c => c.image_Id).ToList();
            //List<Content> content = data.content.Include(c => c.image_Id).Where(c => c.pageNum == 1).ToList();
            //List<Image> images = data.images.ToList();

            //construct the model based on the list info
            HomeModel model = new HomeModel(content, columns, images);
            
            //pass the specific model to the view
            return View(model);
        }

         /// <summary>
         /// ActionResult for the Home Edit View
         /// </summary>
         /// <returns></returns>
         public ActionResult Edit()
         {
            //populate lists with dataset info
            List<Column> columns = data.columns.Include(c => c.image_Id).ToList();
            List<Content> content = data.content.Include(c => c.image_Id).Where(c => c.pageNum == 1).ToList();
            List<Image> images = data.images.ToList();

            //construct the model based on the list info
            HomeModel model = new HomeModel(content, columns, images);

            //pass the specific model to the view
            return View(model);
        }
    }
}