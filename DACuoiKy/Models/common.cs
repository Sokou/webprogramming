using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace DACuoiKy.Models
{
    public class Common
    {
        static DbContext cn = new DbContext("name=ShopOnline_DemoEntities");
        public static List<SanPham> getProducts()
        {
            List<SanPham> l = new List<SanPham>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("name=ShopOnline_DemoEntities");
            //--Lấy dữ liệu...
            l = cn.Set<SanPham>().ToList<SanPham>();
            return l;
        }     
        public static List<DonHang> getDonHang()
        {
            List<DonHang> l = new List<DonHang>();
            //---Khai báo 1 đối tượng đại diện cho Database
            DbContext cn = new DbContext("name=ShopOnline_DemoEntities");
            //--Lấy dữ liệu...
            l = cn.Set<DonHang>().ToList<DonHang>();
            return l;
        }
        public static List<SanPham> getProductByLoaiSP(int maLoai)
        {
            List<SanPham> l = new List<SanPham>();
            DbContext cn = new DbContext("name=ShopOnline_DemoEntities");
            l = cn.Set<SanPham>().Where(x => x.maLoai == maLoai).OrderByDescending(z => z.ngayDang).ToList<SanPham>();
            return l;
        }
        /// <summary>
        /// Hàm cho lấy ra danh sách các chủng loại hàng hóa
        /// </summary>
        /// <returns></returns>
        public static List<LoaiSP> getCategories()
        {
            return new DbContext("name=ShopOnline_DemoEntities").Set<LoaiSP>().ToList<LoaiSP>();
        }
        public static List<BaiViet> getArticles(int n)
        {
            List<BaiViet> l = new List<BaiViet>();
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            l = db.BaiViets.Where(m=>m.daDuyet==true).OrderByDescending(bv => bv.ngayDang).Take(n).ToList<BaiViet>();
            return l;
        }
        public static List<KhachHang> GetKhachHangs(int n)
        {
            List<KhachHang> l = new List<KhachHang>();
            ShopOnline_DemoEntities db = new ShopOnline_DemoEntities();
            l = db.KhachHangs.OrderByDescending(kh => kh.maKH).ToList<KhachHang>();
            return l;
        }
        public static LoaiSP GetLoaiSPById(int maLoai)
        {
            return cn.Set<LoaiSP>().Find(maLoai);
        }
        /// <summary>
        /// Phương thức cho phép lấy thông tin của 1 sản phẩm dựa vào mã của sản phẩm đó
        /// </summary>
        /// <param name="maSP">Mã sản phẩm</param>
        /// <returns>Đối tượng sản phẩm lấy được từ Data model</returns>
        public static SanPham GetProductById(string maSP)
        {
            return cn.Set<SanPham>().Find(maSP);
        }
        /// <summary>
        /// Lấy tên của sản phẩm dựa vào mã
        /// </summary>
        /// <param name="maSP"></param>
        /// <returns></returns>
        public static string GetNameOfProductByID(string maSP)
        {
            return cn.Set<SanPham>().Find(maSP).tenSP;
        }
       
        /// <summary>
        /// Lấy đường dãn hình đại diện dựa vào mã sản phẩm 
        /// </summary>
        /// <param name="maSP"></param>
        /// <returns></returns>
        public static string GetImageOfProductByID(string maSP)
        {
            return cn.Set<SanPham>().Find(maSP).hinhDD;
        }

    }
}