using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using DACuoiKy.Models;
namespace DACuoiKy.Areas.PrivatePages.Models
{
    public class ThuongDung
    {
        public static TaiKhoan GetTaiKhoanHH()
        {
            TaiKhoan kq = new TaiKhoan();
            kq = HttpContext.Current.Session["TtDangNhap"] as TaiKhoan;
            return kq;
        }
        public static string GetTenTaiKhoan()
        {
            return GetTaiKhoanHH().taiKhoan1;
        }
        
    }
}