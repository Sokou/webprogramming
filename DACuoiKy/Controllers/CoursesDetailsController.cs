using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;

namespace DACuoiKy.Controllers
{
    public class CoursesDetailsController : Controller
    {
        // GET: CoursesDetails
        public ActionResult Index(string MaSanPham)
        {
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            SanPham x = db.SanPhams.Where(sp => sp.maSP.Equals(MaSanPham)).First<SanPham>();
            ViewData["SpCanXem"] = x;
            return View();
        }
    }
}