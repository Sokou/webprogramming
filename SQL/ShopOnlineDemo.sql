use master
go

drop database ShopOnline_Demo
go
-- Tạo database ShopOnline_Demo
create database ShopOnline_Demo
go
use ShopOnline_Demo
go
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	ghiChu ntext
)
go

-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	maKH varchar(10) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email varchar(50),
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go

-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	maBV varchar(10) primary key not null,
	tenBV nvarchar(250) not null,
	hinhDD varchar(max),
	ndTomTat nvarchar(2000),
	ngayDang datetime ,
	loaiTin nvarchar(30),
	noiDung nvarchar(4000),
	taiKhoan varchar(20) not null ,
	daDuyet bit default 0,
	foreign key (taiKhoan) references taiKhoan(taiKhoan) on update cascade 
)
go
-- 4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	maLoai int primary key not null identity,
	tenLoai nvarchar(88) not null,
	ghiChu ntext default ''
)
go
-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	maSP varchar(10) primary key not null,
	tenSP nvarchar(500) not NULL,
	hinhDD varchar(max) DEFAULT '',
	ndTomTat nvarchar(2000) DEFAULT '',
	ngayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	maLoai int not null references LoaiSP(maLoai),
	noiDung nvarchar(4000) DEFAULT '',
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade,
	dvt nvarchar(32) default N'Cái',
	daDuyet bit default 0,
	giaBan INTEGER DEFAULT 0,
	giamGia INTEGER DEFAULT 0 CHECK (giamGia>=0 AND giamGia<=100),
	nhaSanXuat nvarchar(168) default ''
)
go

-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	soDH varchar(10) primary key not null ,
	maKH varchar(10) not null foreign key references khachHang(maKH),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ngayGH datetime,
	diaChiGH nvarchar(250),
	ghiChu ntext
)
go	

-- 6: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	soDH varchar(10) not null foreign key references donHang(soDH),
	maSP varchar(10) not null foreign key references sanPham(maSP),
	soLuong int,
	giaBan bigint,
	giamGia BIGINT,
	PRIMARY KEY (soDH, maSP)
)
go


/*========================== Nhập dữ liệu mẫu ==============================*/

-- YC 1: Nhập thông tin tài khoản, tối thiểu 5 thành viên sẽ dùng để làm việc với các trang: Administrative pages
insert into taiKhoan
values('minh','123',N'Nguyễn Minh','Quang',06/12/1996,1,0935694223,'minhminh@gmail.com','472 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoan
values('admin','abc',N'Nguyễn Quang',N'Hưng',06/12/1996,1,0935694223,'nqhung@gmail.com','472 CMT8, P.11,Q3, TP.HCM',1,'')
GO

insert into LoaiSP(tenLoai) values(N'PC-Personal Computer')
insert into LoaiSP(tenLoai) values(N'VGA-Card màn hình')
insert into LoaiSP(tenLoai) values(N'RAM-Cáin nhớ trong')
insert into LoaiSP(tenLoai) values(N'PSU - Nguồn máy tính')
insert into LoaiSP(tenLoai) values(N'Mainboard - Bo mạch chủ')
insert into LoaiSP(tenLoai) values(N'CPU-Cái vi xử lí')
go
-- YC3: Nhập thông tin bài viết, Tối thiểu 10 bài viết thuộc loại: giới thiệu sản phẩm, khuyến mãi, quảng cáo, ... 
--      liên quan đến sản phẩm mà bạn dự định kinh doanh trong đồ án sẽ thực hiện
-- Dụng cụ nhà bếp -------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('01', N'PC-GVN AORUS X', '/images/sanPham/GVN AORUS X - Copy.jpg',
			          N'Với hiệu suất mạnh mẽ đến từ VGA, bạn có thể chiến hầu như tất cả các tựa game đình đám nhất từ online
					  cho đến các tựa game offline yêu cầu phần cứng khủng ở mức thiết lập từ High - Ultra, hiện tượng giật
					  lag hay drog FPS hầu như không xuất hiện nếu setting ở mức phù hợp.', 'admin',99450000,0,1,N'GEARVN',
					  N'bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('02', N'PC-GVN AORUS X', '/images/sanPham/GVN AORUS X.jpg',
			          N'Với hiệu suất mạnh mẽ đến từ VGA, bạn có thể chiến hầu như tất cả các tựa game đình đám 
					  nhất từ online cho đến các tựa game offline yêu cầu phần cứng khủng ở mức thiết lập từ High - Ultra,
					  hiện tượng giật lag hay drog FPS hầu như không xuất hiện nếu setting ở mức phù hợp.', 'admin',86500000,0,1,N'GEARVN',
					  N'bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('03', N'PC-GVN Avengers Z', '/images/sanPham/GVN Avengers Z.jpg',
			          N'Nằm trong dòng Gaming Afford bộ máy tính chơi game GVN Avengers Z luôn biết cách tỏa sáng với cấu hình mạnh mẽ,
					  vượt trội giúp người dùng có thể vừa gaming, vừa đồ họa một cách mượt mà.', 'admin',69850000,0,1,N'GEARVN',
					  N'bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('04', N'PC-GVN Dragon X', '/images/sanPham/GVN Dragon X.jpg',
			          N'Với hiệu suất mạnh mẽ đến từ VGA, bạn có thể chiến hầu như tất cả các tựa game đình đám nhất từ online
					  cho đến các tựa game offline yêu cầu phần cứng khủng ở mức thiết lập từ High - Ultra, hiện tượng giật
					  lag hay drog FPS hầu như không xuất hiện nếu setting ở mức phù hợp', 'admin',79450000,0,1,N'GEARVN',
					  N'bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('05', N'PC-GVN Garen S', '/images/sanPham/GVN Garen S.jpg',
			          N'Nằm trong dòng Gaming Afford bộ máy tính chơi game GVN Avengers Z luôn biết cách tỏa sáng với cấu hình mạnh mẽ,
					  vượt trội giúp người dùng có thể vừa gaming, vừa đồ họa một cách mượt mà.', 'admin',112450000,0,1,N'GEARVN',
					  N'bộ');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('06', N'PC-GVN HERA S', '/images/sanPham/GVN HERA S.jpg',
			          N'Với hiệu suất mạnh mẽ đến từ VGA, bạn có thể chiến hầu như tất cả các tựa game đình đám 
					  nhất từ online cho đến các tựa game offline yêu cầu phần cứng khủng ở mức thiết lập từ High - Ultra,
					  hiện tượng giật lag hay drog FPS hầu như không xuất hiện nếu setting ở mức phù hợp.', 'admin',97820000,0,1,N'GEARVN',
					  N'bộ');
go
-- VGA-Card màn hình --------------------------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('07', N'VGA-PALIT GeForce 1050 Ti StormX 4GB', '/images/sanPham/ALIT GeForce 1050 Ti StormX 4GB.jpg',
			          N'PALIT GTX 1050Ti được trang bị tụ điện thể rắn, cuộn cảm lõi ferit, thiết kế PWM và cả khả năng
					  làm mát đã được cải tiến. GTX 1050Ti nhanh và mạnh mẽ sẽ biến PC của bạn thành một PC gaming đỉnh
					  của chóp.', 'admin',18900000,0,2,N'PALTI',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('08', N'VGA-ASUS Cerberus GeForce GTX 1050 Ti OC 4GB', '/images/sanPham/ASUS Cerberus GeForce GTX 1050 Ti OC 4GB.jpg',
			          N'ASUS Cerberus GeForce® GTX 1050 Ti là card đồ hoạ hiệu năng cao được thiết kế với độ ổn định và hiệu năng chơi game 
					  cải thiện hơn nhiều để mang lại một trải nghiệm chơi game say mê không ngừng nghỉ. Chúng tôi thử nghiệm card đồ họa 
					  này với mức thiết lập tối đa cho các game mới nhất và thực hiện rất nhiều bài thử nghiệm về độ ổn định và đo điểm hệ 
					  thống (benchmarking) với thời gian lâu hơn 15 lần so với các tiêu chuẩn ngành.', 'admin',25450000,0,2,N'ASUS',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('09', N'VGA-ASUS Phoenix GeForce GTX 1660 SUPER OC edition 6GB GDDR6', '/images/sanPham/ASUS Phoenix GeForce GTX 1660 SUPER OC edition 6GB GDDR6.jpg',
			          N'Đây là chiếc card đồ họa tầm trung mới nhất đến từ GIGABYTE, sử dụng bộ xử lý đồ họa GTX 1660 mạnh
					  mẽ, với hiệu năng vượt trội hơn thế hệ đàn anh GTX 1060 ',
						'admin',30050000,0,2,N'ASUS',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('10', N'VGA-Gigabyte GeForce GT 730 2GB (GV-N730D3-2GI)', '/images/sanPham/Gigabyte GeForce GT 730 2GB (GV-N730D3-2GI).jpg',
			          N'Siêu làm mát – Thiết kế MOSFET RDS (bật) thấp.
						Mức điện thấp – Thiết kế cuộn cảm lõi Ferrite.
						Tuổi thọ cao hơn – Thiết kế tụ điện hoàn toàn.', 'admin',43900000,0,2,N'GIGABYTE',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('11', N'VGA-GIGABYTE GeForce GTX 1650 D6 4G', '/images/sanPham/GIGABYTE GeForce GTX 1650 D6 4G.jpg',
			          N'GIGABYTE GeForce GTX 1650 D6 4G Là chiếc VGA thuộc phân khúc bình dân của Gigabyte, được thiết kế nhỏ,
					  tối giản để phù hợp với các hệ thống máy vi tính nhỏ gọn, Mini, SFF, ITX. với hiệu năng chơi game được
					  cải thiện rất nhiều so với thế hệ trước là GTX 1050Ti đem lại trải nghiệm chơi game mượt mà trên độ 
					  phân giải full HD.', 'admin',29569000,0,2,N'GIGABYTE',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('12', N'VGA-GIGABYTE GeForce GTX 1650 D6 OC 4G', '/images/sanPham/GIGABYTE GeForce GTX 1650 D6 OC 4G.jpg',
			          N'Đây là chiếc card đồ họa tầm trung mới nhất đến từ GIGABYTE, sử dụng bộ xử lý đồ họa GTX 1660 mạnh
					  mẽ, với hiệu năng vượt trội hơn thế hệ đàn anh GTX 1060', 
						'admin',3350000,0,2,N'GIGABYTE',
					  N'Cái');
go
-- N'RAM-Cáin nhớ trong [3] -------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('13 ', N'RAM-G.SKILL Trident Z RGB CL16-18-18-38', '/images/sanPham/AM G.SKILL Trident Z RGB CL16-18-18-38.jpg',
			          N'Với thanh ánh sáng đèn Led RGB sống động, được kết hợp với bộ tản nhiệt Trident Z từng đoạt giải thưởng được 
					  thiết kế và chế tạo bằng các thành phần chất lượng cao nhất.Ram Trident Z RGB DDR4 kết hợp ánh sáng RGB sống
					  động nhất với hiệu suất vượt trội dành cho bạn.', 
						'admin',2940000,0,3,N'GSKILL',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('14', N'RAM-Corsair Dominator Platinum RGB CL16-20-20-38', '/images/sanPham/Corsair Dominator Platinum RGB CL16-20-20-38.jpg',
			          N'Để có thể mang lại hiệu năng vượt trội và cho khả năng đa nhiệm cao chắc chắn bạn phải cần một dung lượng ram khá lớn để trang bị 
					  cho bộ PC của mình. Bộ nhớ RAM Corsair Dominator Platinum RGB 32GB (2x16GB) 3200MHz DIMN White sẽ là lựa chọn phù hợp nhất
					  về hiệu quả mang lại khi sử dụng và trang trí cho bộ PC của bạn trở nên bắt mắt hơn.', 'admin',1390000,0,3,N'CORSAIR',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('15', N'RAM-Corsair Vengeance RGB PRO CL16-18-18-38', '/images/sanPham/Corsair Vengeance RGB PRO CL16-18-18-38.jpg',
			          N'Ram PC Corsair Vengeance RGB PRO DDR4 với hệ thống chiếu sáng máy tính của bạn với ánh sáng RGB cực kỳ hầm hố, đồng
					  thời mang lại hiệu suất cao nhất của DDR4. Phần mềm CORSAIR iCUE mạnh mẽ giúp hệ thống của bạn trở nên sống động với
					  khả năng tinh chỉnh RGB năng động, phần mềm này cũng có thể đồng bộ trên tất cả các sản phẩm tương thích iCUE bao gồm 
					  bộ nhớ, quạt, dải đèn LED RGB, bàn phím, chuột và nhiều hơn nữa. Bạn cũng có thể lưu nhiều Profile cùng một lúc để thay
					  đổi nhanh chóng và dễ dàng hơn.','admin',2290000,0,3,N'CORSAIR ',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('16', N'RAM-Corsair Vengeance RGB PRO CL16-20-20-38', '/images/sanPham/Corsair Vengeance RGB PRO CL16-20-20-38.jpg',
			          N'Corsair Vengeance RGB Pro Series là một trong những kit ram DDR4 cho hiệu năng khá tốt không những vậy Corsair
					  Vengeance RGB Pro được trang bị thêm dãi LED RBG cực kỳ đẹp mắt.', 
						'admin',1990000,0,3,N'CORSAIR',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('17', N'RAM-G.SKILL Trident Z Neo DDR4 CL16-16-16-36 ', '/images/sanPham/G.SKILL Trident Z Neo DDR4 CL16-16-16-36.jpg',
			          N'Để có thể mang lại hiệu năng vượt trội và cho khả năng đa nhiệm cao chắc chắn bạn phải cần một dung lượng ram khá lớn để trang bị 
					  cho bộ PC của mình. Bộ nhớ RAM Corsair Dominator Platinum RGB 32GB (2x16GB) 3200MHz DIMN White sẽ là lựa chọn phù hợp nhất
					  về hiệu quả mang lại khi sử dụng và trang trí cho bộ PC của bạn trở nên bắt mắt hơn.', 
						'admin',2590000,0,3,N'GSKILL',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('18', N'RAM-G.SKILL Trident Z Royal RGB GOLD CL16-18-18-38', '/images/sanPham/tuLanhToshiba.jpg',
			          N'Với thiết kế như một loại đá quý đính vương miện và được chế tác tỉ mỉ để tản sáng cho ánh sáng mềm mại,
					  thanh tản sáng chất liệu nhựa acrylic cho các dải ánh sáng RGB như được kết tinh và tán xạ một cách rực rỡ rất
					  "quý tộc". Phản chiếu với thiết kế thanh ánh sáng đó, bộ áo tản nhiệt bằng nhôm ở phiên bản này có lớp mạ màu bạc
					  (và ở một phiên bản Royal khác có màu vàng gold) trong thiết kế 3 trục truyền thống của Trident Z.', 
						'admin',2249000,0,3,N'GSKILL ',
					  N'Cái');
go
-- PSU - Nguồn máy tính [4] -----------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('19', N'PSU-CoolerMaster V750 SFX', '/images/sanPham/CoolerMaster V750 SFX.jpg',
			          N'Nguồn Cooler Master V750 SFX GOLD là dòng nguồn SFX tiên phong của Cooler Master,
					  nhằm phục vụ lượng lớn người dùng case có kích thước mini-ITX.', 
						'admin',2315000,0,4,N'COOLER MASTER',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('20', N'PSU-Corsair RM750X White', '/images/sanPham/Corsair RM750X White.pnj',
			          N'Hoạt động hiệu quả cao đồng thời tiêu thụ điện năng thấp hơn, ít tiếng ồn và nhiệt độ mát hơn, 
					  Đường cong quạt được thiết lập đặc biệt đảm bảo rằng, ngay cả khi full-load, tiếng ồn của quạt 
					  vẫn được giữ ở mức tối thiểu. Ở mức tải thấp và trung bình, quạt làm mát sẽ tắt hoàn toàn cho 
					  hoạt động gần như im lặng.', 
						'admin',2152000,0,4,N'CORSAIR',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('21', N'PSU-Corsair RM850X White', '/images/sanPham/Corsair RM850X White.jpg',
			          N'Hoạt động hiệu quả cao đồng thời tiêu thụ điện năng thấp hơn, ít tiếng ồn và nhiệt độ mát hơn, 
					  Đường cong quạt được thiết lập đặc biệt đảm bảo rằng, ngay cả khi full-load, tiếng ồn của quạt 
					  vẫn được giữ ở mức tối thiểu. Ở mức tải thấp và trung bình, quạt làm mát sẽ tắt hoàn toàn cho 
					  hoạt động gần như im lặng.', 
						'admin',2119000,0,4,N'CORSAIR',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('22', N'PSU-Corsair SF600', '/images/sanPham/Corsair SF600.jpg',
			          N'Nguồn Gigabyte Aorus GP-AP850GM - 80 Plus Gold - Full Modular đến từ thương hiệu
					  GIGABYTE, tất cả đều được làm từ vật liệu chất lượng cao của Nhật Bản, tạo ra hiệu suất hiệu quả
					  và đảm bảo độ tin cậy lâu dài.', 
						'admin',1900000,0,4,N'CORSAIR',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('23', N'PSU-Gigabyte Aorus GP', '/images/sanPham/Gigabyte Aorus GP.jpg',
			          N'Nguồn Gigabyte Aorus GP-AP850GM - 80 Plus Gold - Full Modular đến từ thương hiệu
					  GIGABYTE, tất cả đều được làm từ vật liệu chất lượng cao của Nhật Bản, tạo ra hiệu suất hiệu quả
					  và đảm bảo độ tin cậy lâu dài.', 
						'admin',3082000,0,4,N'GIGABYTE',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('24', N'PSU-CoolerMaster V850 SFX', '/images/sanPham/CoolerMaster V850 SFX.jpg',
			          N'Đáp ứng nhu cầu về nguồn máy tính nhỏ gọn của người dùng case máy tính kích cỡ mini-ITX, 
					  nguồn CoolerMaster V850 SFX - 80 Plus Gold - Full Modular đã được Cooler Master cho ra mắt
					  như vị cứu tinh cho những người dùng đang có ý định build một chiếc PC. Mặc dù nhỏ nhưng
					  sản phẩm từ Cooler Master vẫn giữ được dòng nguồn và chất lượng thuộc dòng V SFX GOLD.', 
						'admin',1020000,0,4,N'COOLER MASTER',
					  N'Cái');
go
-- Mainboard - Bo mạch chủ [5] ---------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('25', N'Mainboard-ASROCK B460M Steel Legend', '/images/sanPham/ASROCK B460M Steel Legend.jpg',
			          N'ASROCK B460M Steel Legend là một trong những dòng bo mạch chủ mới nhất đến từ Asus. 
					  Lấy cảm hứng từ dòng siêu người máy nổi tiếng Gundam. Đây được xem là một trong những 
					  dòng mainboard mang đến nhiều cảm hứng sáng tạo cho người dùng để build hệ thống pc tinh tế,
					  sắc nét mang đậm dấu ấn riêng.', 
						'admin',2500000,0,5,N'ASROCK',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('26', N'Mainboard-ASUS Z490 GUNDAM', '/images/sanPham/ASUS Z490 GUNDAM.jpg',
			          N'ASUS Z490-GUNDAM (WI-FI) là một trong những dòng bo mạch chủ mới nhất đến từ Asus. 
					  Lấy cảm hứng từ dòng siêu người máy nổi tiếng Gundam. Đây được xem là một trong những 
					  dòng mainboard mang đến nhiều cảm hứng sáng tạo cho người dùng để build hệ thống pc tinh tế,
					  sắc nét mang đậm dấu ấn riêng.', 
						'admin',2450000,0,5,N'ASUS',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('27', N'Mainboard-MSI MAG B460M BAZOOKA', '/images/sanPham/MSI MAG B460M BAZOOKA.jpg',
			          N'Mainboard MSI MAG B460M BAZOOKA là  một trong những dòng mainboard giải phóng và duy trì hiệu 
					  suất tối đa với thiết kế VRM cùng hệ thống năng lượng CPU kỹ thuật số. Với công nghệ Core Boost độc quyền,
					  bo mạch chủ dòng MAG đã sẵn sàng để duy trì tải game nặng.', 
						'admin',3750000,0,5,N'MSI',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('28', N'Mainboard-MSI MAG Z590 TORPEDO', '/images/sanPham/MSI MAG Z590 TORPEDO.jpg',
			          N'MSI MAG Z590 TORPEDO là một trong những dòng mainboard Z590 mới nhất đến từ MSI với hiệu suất vô cùng cao sở 
					  hữu thiết kế toàn diện, nâng cao hiệu quả công việc, chơi game giải trí và nhu cầu custom hệ thống pc theo sở thích.', 
						'admin',5299000,0,5,N'MSI',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('29', N'Mainboard-MSI MEG Z490 UNIFY', '/images/sanPham/MSI MEG Z490 UNIFY.jpg',
			          N'Mainboard ASUS PRIME Z490-P LGA1200 tự hào với thiết kế năng lượng mạnh mẽ. Đây là giải pháp làm mát toàn diện cùng 
					  các tùy chỉnh thông minh. Dòng bo mạch chủ này cung cấp một loạt điều chỉnh hiệu suất thông qua các tính năng phần mềm
					  trực quan đến người dùng và các nhà chế tạo PC DIY.', 
						'admin',1387000,0,5,N'ASUS',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('30', N'Mainboard-MSI MEG Z590i UNIFY', '/images/sanPham/MSI MEG Z590i UNIFY.jpg',
			          N'Mainboard MSI MEG Z590I UNIFY nổi bật khi hỗ trợ bộ vi xử lý Intel ® Core ™ / Pentium ® Celeron ® thế hệ thứ 11 và thứ 
					  10 cho socket LGA 1200, bộ nhớ DDR4, lên đến 5600 (OC) MHz, 4 cổng Thunderbolt kép, thiết kế cực mạnh, giải pháp làm mát
					  nổi bật, mạng LAN 2,5G với Wi-Fi 6E mới nhất, ....', 
						'admin',4490000,0,5,N'MSI',
					  N'Cái');
go
-- CPU-Cái vi xử lí [6] --------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('31', N'CPU-AMD Ryzen 5 5600X', '/images/sanPham/AMD Ryzen 5 5600X.jpg',
			          N'CPU AMD Ryzen 5 5600X (3.7GHz Boost 4.6GHz | 6 Nhân / 12 Luồng | 32MB Cache | PCIe 4.0) là bộ vi xử lý tiên 
					  tiến nhất thế giới dành cho người chơi game và sáng tạo nội dung, nó đem đến khả năng vô tận cho những ai đang
					  khao khát có được một con chip mãnh mẽ để sử lý trôi chảy mọi việc.', 
						'admin',12109000,0,6,N'AMD',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('32', N'CPU-AMD Ryzen 7 3700x', '/images/sanPham/AMD Ryzen 7 3700x.jpg',
			          N'CPU Ryzen 7 3700X chạy trên nền tảng socket AM4 - là một trong những mã CPU được nhiều người mong đợi
					  nhất trong list cpu Ryezn 3000 Series. Cùng có 8 nhân/16 luồng như Ryzen 7 3800X, nhưng được AMD xem là
					  “viên kẹo ngọt” trong loạt Ryzen 3000 Series mới được giới thiệu lần này. Sự khác biệt của chiếc CPU này
					  so với 7 3800X là mức TDP của sản phẩm chỉ có 65W và có bộ nhớ đệm 36Mb, xung nhịp cơ bản 3.6Ghz và có thể 
					  đạt max Turbo ở 4.4Ghz.', 
						'admin',13499000,0,6,N'AMD',
					  N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('33', N'CPU-AMD Ryzen 7 5800X', '/images/sanPham/AMD Ryzen 7 5800X.jpg',
			          N'Các vi xử lý - CPU AMD Ryzen 7 5800X được trang bị 20 lane PCIe 4.0 cho người dùng và hỗ trợ bộ nhớ
					  có mức xung nhịp DDR4-3200 theo tiêu chuẩn ngành. Khả năng ép xung bộ nhớ vẫn rất ấn tượng giống như chúng
					  ta thấy với các mẫu Ryzen XT.', 
						'admin',10105000,0,6,N'AMD',
					  N'Cái');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('34', N'CPU-AMD Ryzen 9 3900x', '/images/sanPham/AMD Ryzen 9 3900x.jpg',
			          N'CPU AMD Ryzen 3000 series là CPU đầu tiên được AMD thiết kế với kiến trúc Zen2 trên dây chuyền TSMC
					  7nm FinFET với rất nhiều những cải tiến so với thế hệ đầu tiên. Dễ nhận thấy nhất chính là AMD đã tách phần
					  giao tiếp bộ nhớ, thiết bị ngoại vi ra thành một chip riêng gọi là chip cIOD. Phần nhân xử lý được AMD thiết
					  kế nằm trên 1 chip riêng được gọi là chiplet với 8 nhân xử lý được chia làm 2 cụm CCX – mỗi cụm CCX gồm có 4
					  nhân, và bộ nhớ đệm L3 16MB riêng (được AMD gọi là AMD Game Cache). Mỗi chiplet được gọi là CCD sẽ được liên
					  kết với nhân cIOD bằng kết nối tốc độ cao, độ trễ thấp AMD InfinityFabric. Chúng ta sẽ có 2 thiết kế chip dành
					  cho máy tính để bàn, gồm thiết kế 1 chiplet CCD và 1 chip cIOD với CPU lên đến 8 nhân 16 luồng với lên đến 36MB 
					  bộ nhớ đệm L2 + L3, thiết kế thứ 2 gồm 2 chiplet CCD và 2 chip cIOD với CPU lên đến 16 nhân 32 luồng với lên đến
					  72MB bộ nhớ đệm L2 + L3. CPU được mình sử dụng để test dùng thiết kế thứ 2.', 
						'admin',25455000,0,6,N'AMD',
					  N'Chiếc');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('35', N'CPU-AMD Ryzen 9 5900X', '/images/sanPham/AMD Ryzen 9 5900X.jpg',
			          N'CPU AMD Ryzen 9 5900X tập trung tối ưu những thứ game thủ thường phàn nàn trước đây, AMD không ngần ngại 
					  show hiệu năng gaming của Ryzen 9 5900X ở 1080p, nơi Intel trước giờ là bá chủ. Cũng như đưa vào nhiều game online
					  esport vốn trước giờ mang tiếng tối ưu tốt cho Intel và AMD kém tương thích như CS:GO, LOL (thực ra là do engine
					  game cũ) và kết quả là CSGO, LOL cho FPS cao hơn đến 50% so với 3900XT, và cao hơn đến 21% so với i9-10900K. Chip 
					  AMD Ryzen 9 5900X cung cấp sức mạnh đỉnh cao cho các trò chơi đòi hỏi khắt khe nhất, mang đến một trải nghiệm nhập 
					  vai có một không hai và thống trị mọi tác vụ đa luồng như 3D và kết xuất video cũng như biên dịch phần mềm. Tất cả 
					  các bộ xử lý Ryzen 5900X đều đi kèm với những công nghệ được thiết kế đặc biệt để nâng cao sức mạnh xử lý bao gồm
					  Ryzen Master Utility, AMD StoreMI Technology và VR-Ready Premium v.v...', 
						'admin',15463000,0,6,N'AMD',
					  N'Đôi');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('36', N'CPU-AMD Ryzen 9 5950X', '/images/sanPham/AMD Ryzen 9 5950X.jpg',
			          N'CPU AMD Ryzen 9 5950X dẫn đầu về hiệu suất chơi game và làm việc đa nhiệm. Ryzen 9 5950X được AMD giới thiệu với mức
					  hiệu suất vượt trội khi so sánh với Ryzen 9 3950X đã được ra mắt cách đây khá lâu và CPU Core i9-10900K đầu bảng của
					  Intel trong thời điểm hiện tại. ', 
						'admin',8189000,0,6,N'	',
					  N'Đôi');
go

