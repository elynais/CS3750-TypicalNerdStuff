using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
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
            List<Column> columns = data.columns.ToList();
            List<Content> content = data.content.ToList();
            List<Image> images = data.images.ToList();

            //construct the model based on the list info
            HomeModel model = new HomeModel(content, columns, images);

            //pass the specific model to the view
            return View(model);
        }

        [HttpPost]
        public ActionResult updateContent(string contentName, string contentInfo)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SystemDataContext"].ConnectionString);
            try
            {
                //name = "Michael";
                //city = "Clinton";
                //country = "USA"; 
                conn.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Contents SET ContentInfo = @contentInfo WHERE contentName = @ContentName", conn);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@contentInfo", contentInfo);
                cmd.Parameters.AddWithValue("@contentName", contentName);
                cmd.ExecuteNonQuery();
                conn.Close();
                return Content("Success");
            }
            catch (Exception ex)
            {
                return Content("failure");
            }
        }
    }
}