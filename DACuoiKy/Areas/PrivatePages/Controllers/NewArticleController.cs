using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using DACuoiKy.Models;
using DACuoiKy.Areas.PrivatePages.Models;
using System.IO;

namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class NewArticleController : Controller
    {
        // GET: PrivatePages/NewArticle
        [HttpGet]
        public ActionResult Index()
        {
            BaiViet x = new BaiViet();
            //---Thiết lập 1 số thông tin mặc định cần gán cho đối tượng bài viết khách quan
            x.ngayDang = DateTime.Now;
            x.soLanDoc = "0";
            x.taiKhoan = ThuongDung.GetTenTaiKhoan();
            ViewBag.ddHinh = "/images/news/2.png";
            return View(x);
        }
        [HttpPost]
        public ActionResult Index(BaiViet x, HttpPostedFileBase HinhDaiDien)
        {
            try
            {
                //--B1:xử lý thông tin nhận về từ view
                x.maBV = string.Format("{0:yyMMddhhmm}", DateTime.Now);
                x.daDuyet = false;
                x.ngayDang = DateTime.Now;
                x.taiKhoan = ThuongDung.GetTenTaiKhoan();
                x.soLanDoc = "0";
                x.loaiTin = "Q";
                if (HinhDaiDien != null)
                {
                    string virpath = "/images/BaiViet/";
                    string phypath = Server.MapPath("~/" + virpath);
                    string ext = Path.GetExtension(HinhDaiDien.FileName);
                    string tenF = "HDD" + x.maBV + ext;
                    HinhDaiDien.SaveAs(phypath + tenF);
                    x.hinhDD = virpath + tenF;
                    ViewBag.ddHinh = x.hinhDD;
                }
                else
                    x.hinhDD = "";

                //--B2:cập nhật đối tượng
                ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
                db.BaiViets.Add(x);
                //--B3:lưu thông tin xuống database
                db.SaveChanges();
                return RedirectToAction("Index", "ListArticle", new { IsActive = 0 });
            }
            catch
            {

            }
            return View(x);
        }
    }
}