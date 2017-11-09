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
        SystemDataContext data = new SystemDataContext();
        /// <summary>
        /// ActionResult for returning the Secondary Index View
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            //populate lists
            List<Content> content = data.content.ToList();
            List<Column> columns = data.columns.ToList();
            List<Staff> staff = data.staff.ToList();
            List<Board> board = data.board.ToList();
            List<Donor> donors = data.donors.ToList();
            List<Image> images = data.images.ToList();

            //construct secondary model
            SecondaryModel model = new SecondaryModel(columns,content,donors,board,images,staff);
            
            //pass model to view
            return View(model);
        }

         /// <summary>
         /// ActionResult for returning the Secondary Edit View
         /// </summary>
         /// <returns></returns>
         public ActionResult Edit()
         {
            //populate lists
            List<Content> content = data.content.ToList();
            List<Column> columns = data.columns.ToList();
            List<Staff> staff = data.staff.ToList();
            List<Board> board = data.board.ToList();
            List<Donor> donors = data.donors.ToList();
            List<Image> images = data.images.ToList();

            //construct secondary model
            SecondaryModel model = new SecondaryModel(columns, content, donors, board, images, staff);

            //pass model to view
            return View(model);
        }
    }
}