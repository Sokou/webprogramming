using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;

namespace DACuoiKy.Controllers
{
    public class ArticleController : Controller
    {
        // GET: Article
        public ActionResult Index(string MaBaiViet)
        {
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            BaiViet x = db.BaiViets.Where(bv => bv.maBV.Equals(MaBaiViet)).First<BaiViet>();
            ViewData["BvCanXem"] = x;
            return View();
        }
    }
}