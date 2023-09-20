using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class dashboardController : Controller
    {
        // GET: PrivatePages/dashboard
        public ActionResult Index()
        {
            return View();
        }
    }
}