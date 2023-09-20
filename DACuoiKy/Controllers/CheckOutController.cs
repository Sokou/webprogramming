using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;

using DACuoiKy.Models;

namespace DACuoiKy.Controllers
{
    public class CheckOutController : Controller
    {
        // GET: CheckOut
        [HttpGet]
        public ActionResult Index()
        {
            KhachHang x = new KhachHang();
            CartShop gh = Session["GioHang"] as CartShop;
            ViewData["Cart"] = gh;
            return View();
        }
        [HttpPost]
        public ActionResult SaveToDataBase(KhachHang x)
        {
            using(var context = new ShopOnline_DemoEntities())
            {
                using(DbContextTransaction trans = context.Database.BeginTransaction())
                {
                    try
                    {
                        x.maKH = x.soDT;
                        context.KhachHangs.Add(x);
                        context.SaveChanges();
                        DonHang d = new DonHang();
                        d.soDH = string.Format("{0:yyMMddhhmm}", DateTime.Now);
                        d.maKH = x.maKH;
                        d.ngayGH = DateTime.Now; d.ngayGH = DateTime.Now.AddDays(2);
                        d.taiKhoan = "admin"; d.diaChiGH = x.diaChi;
                        context.DonHangs.Add(d);
                        context.SaveChanges();
                        CartShop gh = Session["GioHang"] as CartShop;
                        foreach (CtDonHang i in gh.SanPhamDC.Values)
                        {
                            i.soDH = d.soDH;
                            context.CtDonHangs.Add(i);
                        }
                        context.SaveChanges();
                        trans.Commit();
                        return RedirectToAction("Index", "Home");
                    }
                    catch(Exception e)
                    {
                        trans.Rollback();
                        string s = e.Message;
                    }
                }
            }
            return RedirectToAction("Index", "CheckOut");
        }
    }
}