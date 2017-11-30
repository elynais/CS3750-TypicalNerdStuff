using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace YouthFutureCMS.Models
{
    public class Event
    {
        [Key]
        [Display(Name = "Id")]
        public int eventId { get; set; }
        [Display(Name = "Event Name")]
        public string eventName {get;set;}
        [Display(Name = "Event Description")]
        public string eventDesc {get;set;}
        [Display(Name = "Event Date")]
        public DateTime eventDate{get;set;}
        [Display(Name = "Location")]
        public string eventLocation {get;set;}

}

public class EventContext : DbContext
    {
        public EventContext() : base("name=SystemDataContext") { }
        public DbSet<Event> events { get; set; }
    }

}