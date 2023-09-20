using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;

namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class Orders1Controller : Controller
    {
        // GET: PrivatePages/Orders1
        public ActionResult Index()
        {
            List<DonHang> l = new ShopOnline_DemoEntities().DonHangs.OrderBy(x => x.soDH).ToList<DonHang>();
            ViewData["DsDon"] = l;
            return View();
        }
    }
}