using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;


namespace YouthFutureCMS.Models
{
    public class Event
    {
        public int eventId { get; set; }
        public string eventName { get; set; }
        public string eventDate { get; set; }
        public string eventDesc { get; set; }
        public string eventLocation { get; set; }
    }
    public class EventContext : DbContext
    {
        public DbSet<Event> events { get; set; }
    }
}