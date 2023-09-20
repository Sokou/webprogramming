using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;
namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class ListCustomersController : Controller
    {
        // GET: PrivatePages/ListCustomers
        public ActionResult Index()
        {
            List<KhachHang> l = new ShopOnline_DemoEntities().KhachHangs.OrderBy(x => x.STT).ToList<KhachHang>();
            ViewData["DsKhach"] = l;
            return View();
        }
    }
}