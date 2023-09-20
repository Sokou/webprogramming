using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;
using System.Data.Entity;
namespace DACuoiKy.Controllers
{
    public class LoginController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(string Acc, string Pass)
        {
            try
            {
                string mk = mahoa.encryptSHA256(Pass);
                // doc thong tin tai khoan tu database thong qua model de xet co dung tai khoan va mat khau khong--------------\
                bool checkTk = new DbContext("name=ShopOnline_DemoEntities").Set<TaiKhoan>().ToList<TaiKhoan>().Where(x => x.taiKhoan1 == Acc && x.matKhau == mk).ToList().Count > 0;

                if (checkTk)
                {
                    Session["TtDangNhap"] = new DbContext("name=ShopOnline_DemoEntities").Set<TaiKhoan>().ToList<TaiKhoan>().Where(x => x.taiKhoan1 == Acc && x.matKhau == mk).ToList().First<TaiKhoan>();
                    return RedirectToAction("Index", "dashboard", new { area = "PrivatePages" });
                }
            }
            catch
            {
                //  ---    redirect to error page
            }
            return View();
        }
    }
}