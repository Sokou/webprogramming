using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using DACuoiKy.Models;

namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class SpeciesController : Controller
    {
        private static bool isUpdate = false;
        // GET: PrivatePages/Species
        [HttpGet]
        public ActionResult Index()
        {
            List<LoaiSP> l = new ShopOnline_DemoEntities().LoaiSPs.OrderBy(x => x.tenLoai).ToList<LoaiSP>();
            ViewData["DsLoai"] = l;
            return View();
        }
        [HttpPost]
        public ActionResult Index(LoaiSP x)
        {
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            // 
            if (!isUpdate)
                db.LoaiSPs.Add(x);
            else
            {
                LoaiSP y = db.LoaiSPs.Find(x.maLoai);
                y.tenLoai = x.tenLoai;
                y.ghiChu = x.ghiChu;
                isUpdate = false;
            }
            db.LoaiSPs.Add(x);
            db.SaveChanges();
            if (ModelState.IsValid)
                ModelState.Clear();
            ViewData["DsLoai"] = db.LoaiSPs.OrderBy(z => z.tenLoai).ToList<LoaiSP>();
            return View();
        }
        [HttpPost]
        public ActionResult Delete(string ml)
        {
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            int ma = int.Parse(ml);
            LoaiSP x = db.LoaiSPs.Find(ma);
            db.LoaiSPs.Remove(x);
            db.SaveChanges();
            ViewData["DsLoai"] = db.LoaiSPs.OrderBy(z => z.tenLoai).ToList<LoaiSP>();
            return View("Index");
        }
        public ActionResult Update(string mlcs)
        {
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            int ma = int.Parse(mlcs);
            LoaiSP x = db.LoaiSPs.Find(ma);
            isUpdate = true;
            ViewData["DsLoai"] = db.LoaiSPs.OrderBy(z => z.tenLoai).ToList<LoaiSP>();
            return View("Index", x);
        }
    }
}