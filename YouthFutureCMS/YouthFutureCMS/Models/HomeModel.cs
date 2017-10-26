using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class HomeModel
    {
        /* Declare all empty Lists of Info for use in view */
        public List<Column> columns { get; set; }

        public List<Content> content { get; set; }

        public List<Image> images { get; set; }

        /// <summary>
        /// Constructor for model used for Home page view content
        /// </summary>
        /// <param name="contentParam"></param>
        /// <param name="columnParam"></param>
        /// <param name="imageParam"></param>
        public HomeModel(List<Content> contentParam, List<Column> columnParam, List<Image> imageParam)
        {
            columns = columnParam;
            content = contentParam;
            images = imageParam;
        }

        /// <summary>
        /// Get for returning content that has the same id
        /// </summary>
        /// <param id="id">Id of the content you want</param>
        /// <returns></returns>
        public string getContent(int id)
        {
            return content.Find(c => c.contentId == id).contentInfo;
        }

        /// <summary>
        /// Get for returning a list of columns that have the same section
        /// </summary>
        /// <param name="section">Section for the columns you want</param>
        /// <returns></returns>
        public List<Column> getColumns(int section)
        {
            return columns.Where(c => c.sectionNum == section).ToList();
        }

        /// <summary>
        /// Get for returning image path for image that has the same id
        /// </summary>
        /// <param name="id">Id of the image you want</param>
        /// <returns></returns>
        public string getImage(int id)
        {
            return images.Find(c => c.imageId == id).imagePath;
        }
    }
}