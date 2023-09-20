
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DACuoiKy.Models;

namespace DACuoiKy.Areas.PrivatePages.Controllers
{
    public class ListArticleController : Controller
    {
        private static ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
        private static bool daDuyet;
        // GET: PrivatePages/Articles
        [HttpGet]
        public ActionResult Index(string IsActive)
        {
            daDuyet = IsActive != null && IsActive.Equals("1");
            CapNhatDuLieuChoGiaoDien();
            return View();
        }
        [HttpPost]
        public ActionResult Delete(string maBaiViet)
        {
            //--B1:Dùng Lệnh để xóa bài viết dựa vào mã bài viết
            BaiViet x = db.BaiViets.Find(maBaiViet);
            db.BaiViets.Remove(x);
            //--B2:Cập Nhật database
            db.SaveChanges();
            //--B3:Hiển thị danh sách sau khi xóa
            CapNhatDuLieuChoGiaoDien();
            return View("Index");
        }
        [HttpPost]
        public ActionResult Active(string maBaiViet)
        {
            //--B1:Dùng Lệnh để cấm bài viết dựa vào mã bài viết
            BaiViet x = db.BaiViets.Find(maBaiViet);
            x.daDuyet = !daDuyet;
            //--B2:Cập Nhật database
            db.SaveChanges();
            //--B3:Hiển thị danh sách sau khi xóa
            CapNhatDuLieuChoGiaoDien();
            return View("Index");
        }
        /// <summary>
        /// Hàm phục vụ cho mục tiêu cập nhật dữ liệu cho View của Controller này thông qua ViewData object
        /// </summary>
        private void CapNhatDuLieuChoGiaoDien()
        {
            List<BaiViet> l = db.BaiViets.Where(x => x.daDuyet == daDuyet).ToList<BaiViet>();
            ViewData["DanhSachBV"] = l;
            ViewBag.tdCuaNut = daDuyet ? "Cấm Hiển Thị" : "Kiểm Duyệt Bài";
        }
    }
}