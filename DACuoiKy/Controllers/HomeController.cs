using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;

namespace DACuoiKy.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        [HttpGet]
        public ActionResult Index()
        {
            string testMk = mahoa.encryptSHA256("123");
            List<SanPham> l = Common.getProductByLoaiSP(4);
            return View();
        }
        public ActionResult AddToCart(string maSP)
        {
            CartShop gh = Session["GioHang"] as CartShop;
            gh.addItem(maSP);
            Session["GioHang"] = gh;
            return View("Index");
        }
    }
}