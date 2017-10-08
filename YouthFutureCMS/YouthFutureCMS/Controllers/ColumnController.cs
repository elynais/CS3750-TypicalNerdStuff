using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using YouthFutureCMS.Models;

namespace YouthFutureCMS.Controllers
{
    public class ColumnController : Controller
    {
        private ColumnContext db = new ColumnContext();

        // GET: Column
        public ActionResult Index()
        {
            return View(db.columns.ToList());
        }

        // GET: Column/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Column column = db.columns.Find(id);
            if (column == null)
            {
                return HttpNotFound();
            }
            return View(column);
        }

        // GET: Column/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Column/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "columnId,columnHeader,columnDesc,columnLink,sectionNum")] Column column)
        {
            if (ModelState.IsValid)
            {
                db.columns.Add(column);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(column);
        }

        // GET: Column/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Column column = db.columns.Find(id);
            if (column == null)
            {
                return HttpNotFound();
            }
            return View(column);
        }

        // POST: Column/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "columnId,columnHeader,columnDesc,columnLink,sectionNum")] Column column)
        {
            if (ModelState.IsValid)
            {
                db.Entry(column).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(column);
        }

        // GET: Column/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Column column = db.columns.Find(id);
            if (column == null)
            {
                return HttpNotFound();
            }
            return View(column);
        }

        // POST: Column/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Column column = db.columns.Find(id);
            db.columns.Remove(column);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
