USE [master]
GO
/****** Object:  Database [TOUR_CNN]    Script Date: 4/17/2025 11:33:46 PM ******/
CREATE DATABASE [TOUR_CNN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TOUR_CNN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TOUR_CNN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TOUR_CNN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TOUR_CNN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TOUR_CNN] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TOUR_CNN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TOUR_CNN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TOUR_CNN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TOUR_CNN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TOUR_CNN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TOUR_CNN] SET ARITHABORT OFF 
GO
ALTER DATABASE [TOUR_CNN] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TOUR_CNN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TOUR_CNN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TOUR_CNN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TOUR_CNN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TOUR_CNN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TOUR_CNN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TOUR_CNN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TOUR_CNN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TOUR_CNN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TOUR_CNN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TOUR_CNN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TOUR_CNN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TOUR_CNN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TOUR_CNN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TOUR_CNN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TOUR_CNN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TOUR_CNN] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TOUR_CNN] SET  MULTI_USER 
GO
ALTER DATABASE [TOUR_CNN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TOUR_CNN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TOUR_CNN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TOUR_CNN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TOUR_CNN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TOUR_CNN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TOUR_CNN] SET QUERY_STORE = ON
GO
ALTER DATABASE [TOUR_CNN] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TOUR_CNN]
GO
/****** Object:  UserDefinedFunction [dbo].[GenerateSoHD]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GenerateSoHD]()
RETURNS CHAR(5)
AS
BEGIN
    DECLARE @NextID INT;

    -- Tìm giá trị tự tăng tiếp theo
    SELECT @NextID = COALESCE(MAX(CAST(RIGHT(SoHD, 3) AS INT)), 0) + 1
    FROM HoaDon;

    -- Chuyển đổi giá trị tự tăng thành định dạng "HD01", "HD02", ...
    DECLARE @GeneratedID CHAR(5) = 'HD' + RIGHT('00' + CAST(@NextID AS VARCHAR(2)), 2);

    RETURN @GeneratedID;
END;
GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChucVu](
	[MaCV] [char](5) NOT NULL,
	[TenCV] [nvarchar](20) NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[MaCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[SoHD] [char](5) NOT NULL,
	[MaNV] [char](5) NOT NULL,
	[MaKH] [char](5) NOT NULL,
	[MaTour] [char](5) NOT NULL,
	[NgayLapHD] [date] NULL,
	[ThanhTien] [decimal](18, 0) NOT NULL,
	[SLVe] [int] NULL,
 CONSTRAINT [PK_HOADON] PRIMARY KEY CLUSTERED 
(
	[SoHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MaKH] [char](5) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[Sdt] [char](11) NOT NULL,
	[Email] [nvarchar](30) NULL,
	[GioiTinh] [nvarchar](3) NULL,
 CONSTRAINT [PK_KHACHHANG] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOAITOUR]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOAITOUR](
	[MaLoaiTour] [char](5) NOT NULL,
	[TenLoaiTour] [nvarchar](40) NULL,
 CONSTRAINT [PK_LOAITOUR] PRIMARY KEY CLUSTERED 
(
	[MaLoaiTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [char](5) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](3) NULL,
	[NgaySinh] [date] NULL,
	[Email] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[Sdt] [nvarchar](11) NULL,
	[MaCV] [char](5) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHUONGTIENTOUR]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHUONGTIENTOUR](
	[MaPhuongTien] [char](5) NOT NULL,
	[TenPhuongTien] [nvarchar](30) NULL,
 CONSTRAINT [PK_PHUONGTIENTOUR] PRIMARY KEY CLUSTERED 
(
	[MaPhuongTien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [varchar](30) NOT NULL,
	[MatKhau] [varchar](10) NULL,
	[MaNV] [char](5) NOT NULL,
 CONSTRAINT [PK_TK] PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THONGTINTOUR]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THONGTINTOUR](
	[MaTour] [char](5) NOT NULL,
	[TenTour] [nvarchar](40) NULL,
	[MoTaTour] [nvarchar](255) NULL,
	[AnhTour] [nvarchar](40) NULL,
	[GiaTour] [decimal](18, 2) NULL,
	[TGBatDau] [datetime] NULL,
	[TGKetThuc] [datetime] NULL,
	[MaLoaiTour] [char](5) NULL,
	[MaPhuongTien] [char](5) NULL,
	[MaXP] [char](5) NULL,
	[SLVeConLai] [int] NOT NULL,
 CONSTRAINT [PK_THONGTINTOUR] PRIMARY KEY CLUSTERED 
(
	[MaTour] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[XUATPHATTOUR]    Script Date: 4/17/2025 11:33:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[XUATPHATTOUR](
	[MaXP] [char](5) NOT NULL,
	[DiaDiemXP] [nvarchar](40) NULL,
 CONSTRAINT [PK_XUATPHATTOUR] PRIMARY KEY CLUSTERED 
(
	[MaXP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'NV   ', N'Nhân Viên')
INSERT [dbo].[ChucVu] ([MaCV], [TenCV]) VALUES (N'QL   ', N'Quản Lý')
GO
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD001', N'NV002', N'KH001', N'TO001', CAST(N'2025-01-10' AS Date), CAST(2000000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD002', N'NV003', N'KH005', N'TO003', CAST(N'2025-01-09' AS Date), CAST(7000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD003', N'NV004', N'KH002', N'TO002', CAST(N'2025-01-11' AS Date), CAST(1800000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD004', N'NV005', N'KH003', N'TO001', CAST(N'2025-02-10' AS Date), CAST(4000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD005', N'NV002', N'KH004', N'TO005', CAST(N'2025-02-05' AS Date), CAST(11000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD006', N'NV003', N'KH005', N'TO004', CAST(N'2025-03-04' AS Date), CAST(18000000 AS Decimal(18, 0)), 3)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD007', N'NV004', N'KH006', N'TO002', CAST(N'2025-02-01' AS Date), CAST(3600000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD008', N'NV005', N'KH009', N'TO007', CAST(N'2025-02-02' AS Date), CAST(26000000 AS Decimal(18, 0)), 4)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD009', N'NV003', N'KH008', N'TO008', CAST(N'2025-02-07' AS Date), CAST(40000000 AS Decimal(18, 0)), 5)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD010', N'NV001', N'KH010', N'TO006', CAST(N'2025-04-08' AS Date), CAST(4400000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD011', N'NV002', N'KH001', N'TO003', CAST(N'2025-04-10' AS Date), CAST(2000000 AS Decimal(18, 0)), 3)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD012', N'NV002', N'KH001', N'TO004', CAST(N'2025-02-10' AS Date), CAST(2000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD013', N'NV001', N'KH005', N'TO013', CAST(N'2025-02-01' AS Date), CAST(5500000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD014', N'NV002', N'KH002', N'TO014', CAST(N'2025-04-22' AS Date), CAST(7500000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD015', N'NV003', N'KH001', N'TO015', CAST(N'2025-01-18' AS Date), CAST(5000000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD016', N'NV001', N'KH006', N'TO016', CAST(N'2025-04-10' AS Date), CAST(6800000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD017', N'NV002', N'KH008', N'TO017', CAST(N'2025-04-05' AS Date), CAST(8500000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD018', N'NV003', N'KH007', N'TO018', CAST(N'2025-02-21' AS Date), CAST(7000000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD019', N'NV001', N'KH009', N'TO019', CAST(N'2025-03-30' AS Date), CAST(3000000 AS Decimal(18, 0)), 1)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD020', N'NV002', N'KH010', N'TO020', CAST(N'2025-04-10' AS Date), CAST(3500000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD022', N'NV001', N'KH002', N'TO002', CAST(N'2025-02-15' AS Date), CAST(3600000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD023', N'NV003', N'KH003', N'TO003', CAST(N'2025-02-20' AS Date), CAST(14000000 AS Decimal(18, 0)), 4)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD24 ', N'NV001', N'KH010', N'TO002', CAST(N'2025-03-06' AS Date), CAST(3600000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD25 ', N'NV001', N'KH010', N'TO003', CAST(N'2025-03-08' AS Date), CAST(7000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD26 ', N'NV004', N'KH010', N'TO002', CAST(N'2025-02-08' AS Date), CAST(3600000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD27 ', N'NV004', N'KH010', N'TO003', CAST(N'2024-01-07' AS Date), CAST(7000000 AS Decimal(18, 0)), 2)
INSERT [dbo].[HOADON] ([SoHD], [MaNV], [MaKH], [MaTour], [NgayLapHD], [ThanhTien], [SLVe]) VALUES (N'HD28 ', N'NV004', N'KH010', N'TO006', CAST(N'2025-04-11' AS Date), CAST(4400000 AS Decimal(18, 0)), 2)
GO
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH001', N'Nguyen Van Toan', N'0528151123 ', N'vana@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH002', N'Tran Thi Be', N'1234567899 ', N'thib@email.com', N'Nữ')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH003', N'Le Nhan', N'9876543211 ', N'vanc@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH004', N'Le Thi Minh', N'0912345678 ', N'minhle@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH005', N'Pham Van Hau', N'0987654321 ', N'hau.pham@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH006', N'Nguyen Anh Tuan', N'0365897412 ', N'tuanna@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH007', N'Tran Thi Nga', N'0777777777 ', N'ngatran@email.com', N'Nữ')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH008', N'Hoang Van Cuong', N'0123456789 ', N'cuonghoang@email.com', N'Nam')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH009', N'Doan Ngoc Thao', N'0933333333 ', N'thaongoc@email.com', N'Nữ')
INSERT [dbo].[KHACHHANG] ([MaKH], [HoTen], [Sdt], [Email], [GioiTinh]) VALUES (N'KH010', N'Vu Thi Thanh Hien', N'0888888888 ', N'hienvu@email.com', N'Nữ')
GO
INSERT [dbo].[LOAITOUR] ([MaLoaiTour], [TenLoaiTour]) VALUES (N'TNN  ', N'Ngoài Nước')
INSERT [dbo].[LOAITOUR] ([MaLoaiTour], [TenLoaiTour]) VALUES (N'TTN  ', N'Trong Nước')
GO
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [Email], [DiaChi], [Sdt], [MaCV]) VALUES (N'NV001', N'Trần Thái Sơn', N'Nam', CAST(N'2004-12-10' AS Date), N'tts1012@gmail.com', N'Bình Tân, TP.HCM', N'0567302010', N'QL   ')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [Email], [DiaChi], [Sdt], [MaCV]) VALUES (N'NV002', N'Thái Sơn', N'Nam', CAST(N'2001-02-01' AS Date), N'st1012@gmail.com', N'Cầu Giấy, Hà Nội', N'0831241393', N'NV   ')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [Email], [DiaChi], [Sdt], [MaCV]) VALUES (N'NV003', N'Hoàng Hạnh Nhân', N'Nam', CAST(N'2003-06-25' AS Date), N'long123@gmail.com', N'Tân Bình, TP.HCM', N'0951636578', N'NV   ')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [Email], [DiaChi], [Sdt], [MaCV]) VALUES (N'NV004', N'Đỗ Công Tôn Sách', N'Nữ', CAST(N'2001-08-11' AS Date), N'lamngoc123@gmail.com', N'Bàu Bàng, Bình Dương', N'0916724983', N'QL   ')
INSERT [dbo].[NhanVien] ([MaNV], [HoTen], [GioiTinh], [NgaySinh], [Email], [DiaChi], [Sdt], [MaCV]) VALUES (N'NV005', N'Toàn Đinh', N'Nam', CAST(N'2000-04-21' AS Date), N'dinhtoan111@gmail.com', N'Bình Thủy,Cần Thơ', N'0389911722', N'NV   ')
GO
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT001', N'Máy bay')
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT002', N'Xe khách')
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT003', N'Xe du lịch 16 chỗ')
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT004', N'Xe du lịch 45 chỗ')
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT005', N'Xe giường nằm')
INSERT [dbo].[PHUONGTIENTOUR] ([MaPhuongTien], [TenPhuongTien]) VALUES (N'PT006', N'Tàu hỏa')
GO
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV]) VALUES (N'1', N'1', N'NV004')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV]) VALUES (N'admin', N'admin', N'NV001')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV]) VALUES (N'thaison', N'son123', N'NV003')
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [MaNV]) VALUES (N'toandinh', N'dinh123', N'NV005')
GO
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO001', N'Tour Đà Lạt', N'Tham quan những danh lam thắng cảnh nổi tiếng của Đà Nẵng như Bà Nà Hills, Cầu Rồng và bãi biển Mỹ Khê.', N'danang1.jpg', CAST(2000000.00 AS Decimal(18, 2)), CAST(N'2023-12-25T10:00:00.000' AS DateTime), CAST(N'2023-12-30T19:00:00.000' AS DateTime), N'TTN  ', N'PT001', N'XP001', 44)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO002', N'Tour Sapa', N'Trải nghiệm cuộc sống vùng cao, khám phá thắng cảnh hùng vĩ và gặp gỡ người dân tộc thiểu số.', N'sapa1.jpg', CAST(1800000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TTN  ', N'PT001', N'XP002', 29)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO003', N'Tour Phú Quốc', N'Nghỉ dưỡng tại resort 5 sao, tham quan những bãi biển tuyệt đẹp và thử các món đặc sản đảo ngọc.', N'phuquoc1.jpg', CAST(3500000.00 AS Decimal(18, 2)), CAST(N'2024-01-10T19:00:00.000' AS DateTime), CAST(N'2024-01-14T08:00:00.000' AS DateTime), N'TTN  ', N'PT003', N'XP003', 24)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO004', N'Tour Singapore', N'Khám phá sự sôi động và hiện đại của Singapore, từ khu vực Merlion đến khu mua sắm Orchard Road.', N'sp1.jpg', CAST(6000000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP001', 48)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO005', N'Tour Malaysia', N'Trải nghiệm văn hóa đa dạng của Malaysia, từ tháp đôi Petronas đến các đền đài ấn tượng.', N'malaysia1.jpg', CAST(5500000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP001', 44)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO006', N'Tour Đà Lạt', N'Tham quan Đà Lạt ngàn hoa, thăm quan Dinh III, Hồ Xuân Hương và thưởng thức cà phê Đà Lạt.', N'dalat1.jpg', CAST(2200000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TTN  ', N'PT001', N'XP001', 44)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO007', N'Tour Hàn Quốc', N'Khám phá Seoul, thăm quan khu phố cổ Bukchon Hanok và thử trải nghiệm K-pop.', N'korea1.jpg', CAST(6500000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP001', 44)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO008', N'Tour Singapore2', N'Khám phá sự sôi động và hiện đại của Singapore, từ khu vực Merlion đến khu mua sắm Orchard Road.', N'sp1.jpg', CAST(6000000.00 AS Decimal(18, 2)), CAST(N'2024-01-01T16:00:00.000' AS DateTime), CAST(N'2024-01-06T17:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP001', 48)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO009', N'Tour Hội An', N'Thăm quan khu phố cổ Hội An với những ngôi nhà cổ truyền thống và đèn lồng lung linh.', N'hoian1.jpg', CAST(2500000.00 AS Decimal(18, 2)), CAST(N'2024-01-10T09:00:00.000' AS DateTime), CAST(N'2024-01-15T18:00:00.000' AS DateTime), N'TTN  ', N'PT002', N'XP001', 25)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO010', N'Tour Bali', N'Nghỉ dưỡng tại hòn đảo thiên đàng Bali, khám phá đền Hindu và thưởng thức ẩm thực độc đáo.', N'bali1.jpg', CAST(4500000.00 AS Decimal(18, 2)), CAST(N'2024-02-01T12:00:00.000' AS DateTime), CAST(N'2024-02-07T20:00:00.000' AS DateTime), N'TNN  ', N'PT003', N'XP002', 20)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO011', N'Tour Sydney', N'Khám phá thành phố biển Sydney với những điểm nhấn như Cầu cảng Sydney và Nhà hát Opera.', N'uc1.jpg', CAST(7000000.00 AS Decimal(18, 2)), CAST(N'2024-02-15T14:00:00.000' AS DateTime), CAST(N'2024-02-20T22:00:00.000' AS DateTime), N'TNN  ', N'PT002', N'XP004', 32)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO012', N'Tour Rome', N'Đặt chân đến thành phố lịch sử Rome, thăm Colosseum, Di tích La Mã và Thánh đường Vatican.', N'rome1.jpg', CAST(6000000.00 AS Decimal(18, 2)), CAST(N'2024-03-01T10:00:00.000' AS DateTime), CAST(N'2024-03-07T18:00:00.000' AS DateTime), N'TNN  ', N'PT002', N'XP003', 28)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO013', N'Tour Cairo', N'Khám phá vùng đất của những pharaoh cổ xưa với đặc sản văn hóa và lịch sử.', N'cairo1.jpg', CAST(5500000.00 AS Decimal(18, 2)), CAST(N'2024-03-15T11:00:00.000' AS DateTime), CAST(N'2024-03-20T19:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP001', 25)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO014', N'Tour Kyoto', N'Thăm quan Kyoto - thành phố của các đền đài lịch sử và văn hóa truyền thống.', N'kyoto1.jpg', CAST(7500000.00 AS Decimal(18, 2)), CAST(N'2024-04-01T13:00:00.000' AS DateTime), CAST(N'2024-04-07T21:00:00.000' AS DateTime), N'TNN  ', N'PT002', N'XP001', 30)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO015', N'Tour Bangkok', N'Khám phá sự huyền bí của thành phố Bangkok với đền Wat Arun và Khu phố đèn đỏ Patpong.', N'bangkok1.jpg', CAST(5000000.00 AS Decimal(18, 2)), CAST(N'2024-04-15T16:00:00.000' AS DateTime), CAST(N'2024-04-20T23:00:00.000' AS DateTime), N'TNN  ', N'PT003', N'XP002', 35)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO016', N'Tour Rio de Janeiro', N'Thưởng thức bãi biển Copacabana và định nghĩa hình ảnh đẹp của Thiên Chúa Kitô.', N'rio1.jpg', CAST(6800000.00 AS Decimal(18, 2)), CAST(N'2024-05-01T09:00:00.000' AS DateTime), CAST(N'2024-05-07T17:00:00.000' AS DateTime), N'TNN  ', N'PT002', N'XP002', 25)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO017', N'Tour Dubai', N'Khám phá sự xa hoa và hiện đại tại Dubai với Tháp Khalifa và khu mua sắm Dubai Mall.', N'dubai1.jpg', CAST(8500000.00 AS Decimal(18, 2)), CAST(N'2024-05-15T12:00:00.000' AS DateTime), CAST(N'2024-05-20T19:00:00.000' AS DateTime), N'TNN  ', N'PT001', N'XP002', 32)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO018', N'Tour Moscow', N'Đặt chân đến thủ đô Moscow nước Nga với Lâu đài Kremlin và Đại lộ Champs-Élysées.', N'moscow1.jpg', CAST(7000000.00 AS Decimal(18, 2)), CAST(N'2024-06-01T14:00:00.000' AS DateTime), CAST(N'2024-06-07T22:00:00.000' AS DateTime), N'TNN  ', N'PT002', N'XP003', 28)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO019', N'Tour Hạ Long', N'Khám phá vịnh Hạ Long kỳ vĩ với những đảo đá lạ mắt và hang động huyền bí.', N'halong1.jpg', CAST(3000000.00 AS Decimal(18, 2)), CAST(N'2024-06-15T10:00:00.000' AS DateTime), CAST(N'2024-06-20T18:00:00.000' AS DateTime), N'TTN  ', N'PT004', N'XP003', 25)
INSERT [dbo].[THONGTINTOUR] ([MaTour], [TenTour], [MoTaTour], [AnhTour], [GiaTour], [TGBatDau], [TGKetThuc], [MaLoaiTour], [MaPhuongTien], [MaXP], [SLVeConLai]) VALUES (N'TO020', N'Tour Huế - Hội An', N'Trải nghiệm lịch sử và văn hóa Việt Nam tại thành phố cổ Huế và khu phố cổ Hội An.', N'hoian1.jpg', CAST(3500000.00 AS Decimal(18, 2)), CAST(N'2024-07-01T12:00:00.000' AS DateTime), CAST(N'2024-07-07T20:00:00.000' AS DateTime), N'TTN  ', N'PT005', N'XP003', 30)
GO
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP001', N'TP HCM')
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP002', N'Hà Nội')
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP003', N'Hải Phòng')
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP004', N'Đà Lạt')
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP005', N'Cần Thơ')
INSERT [dbo].[XUATPHATTOUR] ([MaXP], [DiaDiemXP]) VALUES (N'XP006', N'Nha Trang')
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HD_KH] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KHACHHANG] ([MaKH])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HD_KH]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HD_NV] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HD_NV]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HD_TTT] FOREIGN KEY([MaTour])
REFERENCES [dbo].[THONGTINTOUR] ([MaTour])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HD_TTT]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK_NV_CV] FOREIGN KEY([MaCV])
REFERENCES [dbo].[ChucVu] ([MaCV])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK_NV_CV]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_NhanVien] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_NhanVien]
GO
ALTER TABLE [dbo].[THONGTINTOUR]  WITH CHECK ADD  CONSTRAINT [FK_THONGTINTOUR] FOREIGN KEY([MaPhuongTien])
REFERENCES [dbo].[PHUONGTIENTOUR] ([MaPhuongTien])
GO
ALTER TABLE [dbo].[THONGTINTOUR] CHECK CONSTRAINT [FK_THONGTINTOUR]
GO
ALTER TABLE [dbo].[THONGTINTOUR]  WITH CHECK ADD  CONSTRAINT [FK_TTT] FOREIGN KEY([MaLoaiTour])
REFERENCES [dbo].[LOAITOUR] ([MaLoaiTour])
GO
ALTER TABLE [dbo].[THONGTINTOUR] CHECK CONSTRAINT [FK_TTT]
GO
ALTER TABLE [dbo].[THONGTINTOUR]  WITH CHECK ADD  CONSTRAINT [FK_TTT_XP] FOREIGN KEY([MaXP])
REFERENCES [dbo].[XUATPHATTOUR] ([MaXP])
GO
ALTER TABLE [dbo].[THONGTINTOUR] CHECK CONSTRAINT [FK_TTT_XP]
GO
ALTER TABLE [dbo].[THONGTINTOUR]  WITH CHECK ADD  CONSTRAINT [CHK_CheckSLVe] CHECK  (([SLVeConLai]>=(0)))
GO
ALTER TABLE [dbo].[THONGTINTOUR] CHECK CONSTRAINT [CHK_CheckSLVe]
GO
ALTER TABLE [dbo].[THONGTINTOUR]  WITH CHECK ADD  CONSTRAINT [CHK_CheckTimeTour] CHECK  (([TGBatDau]<[TGKetThuc]))
GO
ALTER TABLE [dbo].[THONGTINTOUR] CHECK CONSTRAINT [CHK_CheckTimeTour]
GO
USE [master]
GO
ALTER DATABASE [TOUR_CNN] SET  READ_WRITE 
GO
