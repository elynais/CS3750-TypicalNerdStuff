//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace YouthFutureCMS.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Column
    {
        public int Column_id { get; set; }
        public string ColumnHeader { get; set; }
        public string ColumnInfo { get; set; }
        public string ColumnLink { get; set; }
        public string ColumnLinkDesc { get; set; }
        public int Image_id { get; set; }
        public int SectionNumber { get; set; }
    
        public virtual Image Image { get; set; }
    }
}