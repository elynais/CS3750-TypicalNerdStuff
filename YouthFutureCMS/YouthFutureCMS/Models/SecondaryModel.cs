using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class SecondaryModel
    {
        /* Declare all Lists of Info for use in Model below*/
        public List<Column> columns { get; set; }

        public List<Content> content { get; set; }

        public List<Donor> donors { get; set; }

        public List<Board> board { get; set; }

        public List<Image> images { get; set; }

        public List<Staff> staff { get; set; }

        /// <summary>
        /// Contructor
        /// </summary>
        /// <param name="columnParam"></param>
        /// <param name="contentParam"></param>
        /// <param name="donorParam"></param>
        /// <param name="boardParam"></param>
        /// <param name="imageParam"></param>
        /// <param name="staffParam"></param>
        public SecondaryModel(List<Column> columnParam, List<Content> contentParam, List<Donor> donorParam, List<Board> boardParam, List<Image> imageParam, List<Staff> staffParam)
        {
            columns = columnParam;
            content = contentParam;
            donors = donorParam;
            board = boardParam;
            images = imageParam;
            staff = staffParam;
        }

        public string getContent(string name)
        {
            return content.Find(c => c.contentName == name).contentInfo;
        }
        public List<Column> getColumns(int section)
        {
            return columns.Where(c => c.sectionNum == section).ToList();
        }
        /// <summary>
        /// Gets the image path/url from the given id
        /// </summary>
        /// <param name="id">Id you want the image path for</param>
        /// <returns></returns>
        public string getImagePath(int id)
        {
            return images.Find(c => c.imageId == id).imagePath;
        }
        /// <summary>
        /// Gets the email for the board member through the staff table
        /// </summary>
        /// <param name="id">Staff id of the board member whose email you want</param>
        /// <returns></returns>
        public string getBoardEmail(int id)
        {
            return staff.Find(c => c.staffId == id).staffEmail;
        }
    }
}