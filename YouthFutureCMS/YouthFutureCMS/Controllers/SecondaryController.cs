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
using System.Net.Mail;
using System.Threading.Tasks;

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
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Contact(SecondaryModel model)
        {
            if (ModelState.IsValid)
            {
                var body = "<p>Email From: {0} ({1})</p><p>Message:</p><p>{2}</p>";
                var message = new MailMessage();
                message.To.Add(model.FromEmail); 
                message.From = new MailAddress("youthfuturetest@gmail.com");
                message.Subject = "Your email subject";
                message.Body = string.Format(body, model.FromFirstName, model.FromLastName, model.FromPhoneNumber, model.FromEmail, model.Message);
                message.IsBodyHtml = true;

                using (var smtp = new SmtpClient())
                {
                    var credential = new NetworkCredential
                    {
                        UserName = "youthfuturetest@gmail.com", 
                        Password = "youthfutures" 
                    };
                    smtp.Credentials = credential;
                    smtp.Host = "smtp.gmail.com";
                    smtp.Port = 587;
                    smtp.EnableSsl = true;
                    await smtp.SendMailAsync(message);
                    return RedirectToAction("Sent");
                }
            }
            return View(model);
        }

        public ActionResult Sent()
        {
            return View();
        }
    }
}