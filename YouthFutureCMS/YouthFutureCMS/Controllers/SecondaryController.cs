using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using YouthFutureCMS.Models;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net;
using Newtonsoft.Json.Linq;

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
            List<Event> events = data.events.ToList();

            //construct secondary model
            SecondaryModel model = new SecondaryModel(columns,content,donors,board,images,staff,events);
            
            //pass model to view
            return View(model);
        }

        /// <summary>
        /// ActionResult for returning the Secondary Edit View
        /// </summary>
        /// <returns></returns>
        [Authorize]
        public ActionResult Edit()
         {
            //populate lists
            List<Content> content = data.content.ToList();
            List<Column> columns = data.columns.ToList();
            List<Staff> staff = data.staff.ToList();
            List<Board> board = data.board.ToList();
            List<Donor> donors = data.donors.ToList();
            List<Image> images = data.images.ToList();
            List<Event> events = data.events.ToList();

            //construct secondary model
            SecondaryModel model = new SecondaryModel(columns, content, donors, board, images, staff, events);

            //pass model to view
            return View(model);
        }

        [HttpPost]
        public ActionResult updateContent(string contentName, string contentInfo)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["SystemDataContext"].ConnectionString);
            try
            {
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

        [HttpPost]
        public ActionResult SubmitForm()
        {
            //To Validate Google recaptcha
            var response = Request["g-recaptcha-response"];
            string secretKey = "6LcpxzwUAAAAAJWEgyEzFDGSwvwqvJdRUeNNwBkN";
            var client = new WebClient();
            var result = client.DownloadString(string.Format("https://www.google.com/recaptcha/api/siteverify?secret={0}&response={1}", secretKey, response));
            var obj = JObject.Parse(result);
            var status = (bool)obj.SelectToken("success");

            //check the status is true or not
            if (status == true)
            {
                ViewBag.Message = "Your Google reCaptcha validation success";
            }
            else
            {
                ViewBag.Message = "Your Google reCaptcha validation failed";
            }
            return View();
        }
    }
}