USE [master]
GO
/****** Object:  Database [marketing]    Script Date: 10/13/2020 12:10:40 AM ******/
CREATE DATABASE [marketing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'marketing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\marketing.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'marketing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\marketing_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [marketing] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [marketing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [marketing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [marketing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [marketing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [marketing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [marketing] SET ARITHABORT OFF 
GO
ALTER DATABASE [marketing] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [marketing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [marketing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [marketing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [marketing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [marketing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [marketing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [marketing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [marketing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [marketing] SET  ENABLE_BROKER 
GO
ALTER DATABASE [marketing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [marketing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [marketing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [marketing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [marketing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [marketing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [marketing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [marketing] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [marketing] SET  MULTI_USER 
GO
ALTER DATABASE [marketing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [marketing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [marketing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [marketing] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [marketing] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [marketing] SET QUERY_STORE = OFF
GO
USE [marketing]
GO
/****** Object:  Table [dbo].[admin]    Script Date: 10/13/2020 12:10:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin](
	[ad_id] [int] IDENTITY(1,1) NOT NULL,
	[ad_username] [nvarchar](50) NOT NULL,
	[ad_password] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ad_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 10/13/2020 12:10:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[cat_id] [int] IDENTITY(1,1) NOT NULL,
	[cat_name] [nvarchar](50) NOT NULL,
	[cat_image] [nvarchar](max) NOT NULL,
	[cat_fk_ad] [int] NULL,
	[cat_status] [bit] NOT NULL,
	[cat_fk_user] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 10/13/2020 12:10:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[pro_id] [int] IDENTITY(1,1) NOT NULL,
	[pro_name] [nvarchar](50) NOT NULL,
	[pro_image] [nvarchar](max) NOT NULL,
	[pro_price] [int] NOT NULL,
	[pro_description] [nvarchar](max) NOT NULL,
	[pro_fk_userr] [int] NULL,
	[pro_fk_cat] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[pro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 10/13/2020 12:10:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[reser_id] [int] IDENTITY(1,1) NOT NULL,
	[reser_date] [date] NOT NULL,
	[user_fk_id] [int] NOT NULL,
	[product_fk_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reser_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userr]    Script Date: 10/13/2020 12:10:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userr](
	[userr_id] [int] IDENTITY(1,1) NOT NULL,
	[userr_name] [nvarchar](50) NOT NULL,
	[userr_email] [nvarchar](50) NOT NULL,
	[userr_password] [nvarchar](50) NOT NULL,
	[userr_phone] [nvarchar](50) NOT NULL,
	[userr_image] [nvarchar](max) NOT NULL,
	[type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__userr__D29BF4B079622D90] PRIMARY KEY CLUSTERED 
(
	[userr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[admin] ON 

INSERT [dbo].[admin] ([ad_id], [ad_username], [ad_password]) VALUES (1, N'root', N'admin')
INSERT [dbo].[admin] ([ad_id], [ad_username], [ad_password]) VALUES (2, N'admin', N'admin')
SET IDENTITY_INSERT [dbo].[admin] OFF
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (2, N'TOYOTA', N'~/Content/upload/1638400961Toyota-Camry.jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (3, N'MERCEDES', N'~/Content/upload/949352download (1).jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (4, N'HYONDAI', N'~/Content/upload/798920685download (2).jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (5, N'BMW', N'~/Content/upload/1575332568images.jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (6, N'Other', N'~/Content/upload/655955623images (2).jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (8, N'NiSSAN', N'~/Content/upload/1552429999123.jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (9, N'MOTO', N'~/Content/upload/602708330download (4).jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (12, N'TOKTOK', N'~/Content/upload/298538671download (5).jpg', 2, 1, NULL)
INSERT [dbo].[category] ([cat_id], [cat_name], [cat_image], [cat_fk_ad], [cat_status], [cat_fk_user]) VALUES (13, N'wwww', N'~/Content/upload/693997607lionn.jpg', 2, 1, NULL)
SET IDENTITY_INSERT [dbo].[category] OFF
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (6, N'TOYTA Vellfire', N'~/Content/upload/1307549971TOYTA1.jpg', 550000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 2)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (7, N'TOYTA 4545', N'~/Content/upload/139009468TOYTA2.jpg', 1000000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 2)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (8, N'TOYTA Vell125', N'~/Content/upload/1254727882TOYTA3.jpg', 10100000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 2)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (9, N'TOYTA 2017', N'~/Content/upload/471263842TOYTA4.jpg', 450000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 2)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (10, N'TOYTA 2021', N'~/Content/upload/333865695TOYTA5.jpg', 1500000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 2)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (11, N'Nissan2018', N'~/Content/upload/12262664694545.jpg', 500000, N'Nissan MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 8)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (13, N'toktok2010', N'~/Content/upload/1185398836images (1).jpg', 15000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ,', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (14, N'toktok2011', N'~/Content/upload/261965379images (2).jpg', 15000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ,', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (15, N'toktok2012', N'~/Content/upload/1873831415images (3).jpg', 20000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ', NULL, NULL)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (16, N'toktok2015', N'~/Content/upload/146581446images (2).jpg', 20000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (17, N'toktok2017', N'~/Content/upload/1522211649images (3).jpg', 16000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ,', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (18, N'toktok2018', N'~/Content/upload/1937302787images (4).jpg', 17000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (19, N'toktok2019', N'~/Content/upload/1643063549images (5).jpg', 17000, N'An auto rickshaw is a motorized version of the pulled rickshaw or cycle rickshaw. Most have three wheels and do not tilt. They are known by many terms in various countries ,', NULL, 12)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (20, N'Moto2017 ccs', N'~/Content/upload/2032850843download (1).jpg', 10000, N'A motorcycle, often called a motorbike, bike, or cycle, is a two or three-wheeled motor vehicle.[1][2][3] Motorcycle design varies greatly to suit a range of different purposes: long-distance travel, commuting, cruising, sport including racing, and off-road riding. Motorcycling is riding a motorcycle and related social activity such as joining a motorcycle club and attending motorcycle rallies.  The 1885 Daimler Reitwagen made by Gottlieb Daimler and Wilhelm Maybach in Germany was the first internal combustion, petroleum fueled motorcycle. In 1894, Hildebrand & Wolfmüller became the first series production motorcycle.[4][5]', NULL, 9)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (21, N'Moto2017 cc54', N'~/Content/upload/323966177download (2).jpg', 9000, N'A motorcycle, often called a motorbike, bike, or cycle, is a two or three-wheeled motor vehicle.[1][2][3] Motorcycle design varies greatly to suit a range of different purposes: long-distance travel, commuting, cruising, sport including racing, and off-road riding. Motorcycling is riding a motorcycle and related social activity such as joining a motorcycle club and attending motorcycle rallies.  The 1885 Daimler Reitwagen made by Gottlieb Daimler and Wilhelm Maybach in Germany was the first internal combustion, petroleum fueled motorcycle. In 1894, Hildebrand & Wolfmüller became the first series production motorcycle.[4][5]', NULL, 9)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (22, N'Moto2011', N'~/Content/upload/1195903061download (3).jpg', 11000, N'A motorcycle, often called a motorbike, bike, or cycle, is a two or three-wheeled motor vehicle.[1][2][3] Motorcycle design varies greatly to suit a range of different purposes: long-distance travel, commuting, cruising, sport including racing, and off-road riding. Motorcycling is riding a motorcycle and related social activity such as joining a motorcycle club and attending motorcycle rallies.  The 1885 Daimler Reitwagen made by Gottlieb Daimler and Wilhelm Maybach in Germany was the first internal combustion, petroleum fueled motorcycle. In 1894, Hildebrand & Wolfmüller became the first series production motorcycle.[4][5]', NULL, 9)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (23, N'moto154cs', N'~/Content/upload/1805524999download.jpg', 8000, N'A motorcycle, often called a motorbike, bike, or cycle, is a two or three-wheeled motor vehicle.[1][2][3] Motorcycle design varies greatly to suit a range of different purposes: long-distance travel, commuting, cruising, sport including racing, and off-road riding. Motorcycling is riding a motorcycle and related social activity such as joining a motorcycle club and attending motorcycle rallies.  The 1885 Daimler Reitwagen made by Gottlieb Daimler and Wilhelm Maybach in Germany was the first internal combustion, petroleum fueled motorcycle. In 1894, Hildebrand & Wolfmüller became the first series production motorcycle.[4][5]', NULL, 9)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (24, N'mo2015', N'~/Content/upload/1777952257images (1).jpg', 12000, N'A motorcycle, often called a motorbike, bike, or cycle, is a two or three-wheeled motor vehicle.[1][2][3] Motorcycle design varies greatly to suit a range of different purposes: long-distance travel, commuting, cruising, sport including racing, and off-road riding. Motorcycling is riding a motorcycle and related social activity such as joining a motorcycle club and attending motorcycle rallies.  The 1885 Daimler Reitwagen made by Gottlieb Daimler and Wilhelm Maybach in Germany was the first internal combustion, petroleum fueled motorcycle. In 1894, Hildebrand & Wolfmüller became the first series production motorcycle.[4][5]', NULL, 9)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (25, N'nissan2010', N'~/Content/upload/224167178download (1).jpg', 120000, N'The Nissan Motor Company, Ltd. (日産自動車株式会社, Nissan Jidōsha kabushiki gaisha) trading as the Nissan Motor Corporation and usually shortened to Nissan (US: /ˈniːsɑːn/, /ˈnɪsæn/ or AU/NZ: /ˈnɪsən/; Japanese pronunciation: [ɲissaɴ]), is a Japanese multinational automobile manufacturer headquartered in Nishi-ku, Yokohama. The company sells its cars under the Nissan, Infiniti, and Datsun brands with in-house performance tuning products labelled Nismo. The company traces its name to the Nissan zaibatsu, now called Nissan Group.  Since 1999, Nissan has been part of the Renault–Nissan–Mitsubishi Alliance (Mitsubishi joining in 2016), a partnership between Nissan and Mitsubishi Motors of Japan, with Renault of France. As of 2013, Renault holds a 43.4% voting stake in Nissan, while Nissan holds a 15% non-voting stake in Renault. From October 2016 onwards, Nissan holds a 34% controlling stake in Mitsubishi Motors.[8]', NULL, 8)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (26, N'nissan2011', N'~/Content/upload/1199006647download.jpg', 50000, N'The Nissan Motor Company, Ltd. (日産自動車株式会社, Nissan Jidōsha kabushiki gaisha) trading as the Nissan Motor Corporation and usually shortened to Nissan (US: /ˈniːsɑːn/, /ˈnɪsæn/ or AU/NZ: /ˈnɪsən/; Japanese pronunciation: [ɲissaɴ]), is a Japanese multinational automobile manufacturer headquartered in Nishi-ku, Yokohama. The company sells its cars under the Nissan, Infiniti, and Datsun brands with in-house performance tuning products labelled Nismo. The company traces its name to the Nissan zaibatsu, now called Nissan Group.  Since 1999, Nissan has been part of the Renault–Nissan–Mitsubishi Alliance (Mitsubishi joining in 2016), a partnership between Nissan and Mitsubishi Motors of Japan, with Renault of France. As of 2013, Renault holds a 43.4% voting stake in Nissan, while Nissan holds a 15% non-voting stake in Renault. From October 2016 onwards, Nissan holds a 34% controlling stake in Mitsubishi Motors.[8]', NULL, 8)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (27, N'nissan2013', N'~/Content/upload/1222969254images (1).jpg', 112000, N'The Nissan Motor Company, Ltd. (日産自動車株式会社, Nissan Jidōsha kabushiki gaisha) trading as the Nissan Motor Corporation and usually shortened to Nissan (US: /ˈniːsɑːn/, /ˈnɪsæn/ or AU/NZ: /ˈnɪsən/; Japanese pronunciation: [ɲissaɴ]), is a Japanese multinational automobile manufacturer headquartered in Nishi-ku, Yokohama. The company sells its cars under the Nissan, Infiniti, and Datsun brands with in-house performance tuning products labelled Nismo. The company traces its name to the Nissan zaibatsu, now called Nissan Group.  Since 1999, Nissan has been part of the Renault–Nissan–Mitsubishi Alliance (Mitsubishi joining in 2016), a partnership between Nissan and Mitsubishi Motors of Japan, with Renault of France. As of 2013, Renault holds a 43.4% voting stake in Nissan, while Nissan holds a 15% non-voting stake in Renault. From October 2016 onwards, Nissan holds a 34% controlling stake in Mitsubishi Motors.[8]', NULL, 8)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (28, N'nissan2015', N'~/Content/upload/1103936410images.jpg', 400000, N'The Nissan Motor Company, Ltd. (日産自動車株式会社, Nissan Jidōsha kabushiki gaisha) trading as the Nissan Motor Corporation and usually shortened to Nissan (US: /ˈniːsɑːn/, /ˈnɪsæn/ or AU/NZ: /ˈnɪsən/; Japanese pronunciation: [ɲissaɴ]), is a Japanese multinational automobile manufacturer headquartered in Nishi-ku, Yokohama. The company sells its cars under the Nissan, Infiniti, and Datsun brands with in-house performance tuning products labelled Nismo. The company traces its name to the Nissan zaibatsu, now called Nissan Group.  Since 1999, Nissan has been part of the Renault–Nissan–Mitsubishi Alliance (Mitsubishi joining in 2016), a partnership between Nissan and Mitsubishi Motors of Japan, with Renault of France. As of 2013, Renault holds a 43.4% voting stake in Nissan, while Nissan holds a 15% non-voting stake in Renault. From October 2016 onwards, Nissan holds a 34% controlling stake in Mitsubishi Motors.[8]', NULL, 8)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (30, N'bmw2011', N'~/Content/upload/752226083download.jpg', 1500000, N'Automobiles are marketed under the brands BMW, Mini and Rolls-Royce, and motorcycles are marketed under the brand BMW Motorrad. In 2015, BMW was the world''s twelfth-largest producer of motor vehicles, with 2,279,503 vehicles produced.[2] The company has significant motorsport history, especially in touring cars, Formula 1, sports cars and the Isle of Man TT.  BMW is headquartered in Munich and produces motor vehicles in Germany, Brazil, China, India, South Africa, the United Kingdom, the United States and Mexico. The Quandt family are long-term shareholders of the company (with the remaining shares owned by public float), following brothers Herbert Quandt and Harald Quandt''s investments in 1959 which saved the company from bankruptcy.', NULL, 5)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (31, N'bmw2013', N'~/Content/upload/1047997726images (1).jpg', 2000000, N'Automobiles are marketed under the brands BMW, Mini and Rolls-Royce, and motorcycles are marketed under the brand BMW Motorrad. In 2015, BMW was the world''s twelfth-largest producer of motor vehicles, with 2,279,503 vehicles produced.[2] The company has significant motorsport history, especially in touring cars, Formula 1, sports cars and the Isle of Man TT.  BMW is headquartered in Munich and produces motor vehicles in Germany, Brazil, China, India, South Africa, the United Kingdom, the United States and Mexico. The Quandt family are long-term shareholders of the company (with the remaining shares owned by public float), following brothers Herbert Quandt and Harald Quandt''s investments in 1959 which saved the company from bankruptcy.', NULL, 5)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (32, N'BMW cs2012', N'~/Content/upload/1700996736images.jpg', 500000, N'TOYOTA MOTOR CORPORATION is a Japan-based company engaged in the automobile business, finance business and other businesses. The Automobile segment is engaged in the design, manufacture and sale of sedans, minivans, 2box, sports utility vehicles, trucks and related vehicles, as well as related parts and products.', NULL, 5)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (33, N'BMC2019', N'~/Content/upload/667008966images.jpg', 500000, N'asdsadasda', NULL, 5)
INSERT [dbo].[product] ([pro_id], [pro_name], [pro_image], [pro_price], [pro_description], [pro_fk_userr], [pro_fk_cat]) VALUES (34, N'asdfd', N'~/Content/upload/898932025download.jpg', 10000, N'Just a Lion', NULL, 13)
SET IDENTITY_INSERT [dbo].[product] OFF
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (9, CAST(N'2020-10-08' AS Date), 3, 9)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (12, CAST(N'2020-10-08' AS Date), 3, 11)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (13, CAST(N'2020-10-08' AS Date), 3, 7)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (14, CAST(N'2020-10-12' AS Date), 3, 14)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (15, CAST(N'2020-10-12' AS Date), 3, 25)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (16, CAST(N'2020-10-12' AS Date), 3, 31)
INSERT [dbo].[Reservation] ([reser_id], [reser_date], [user_fk_id], [product_fk_id]) VALUES (18, CAST(N'2020-10-12' AS Date), 3, 13)
SET IDENTITY_INSERT [dbo].[Reservation] OFF
SET IDENTITY_INSERT [dbo].[userr] ON 

INSERT [dbo].[userr] ([userr_id], [userr_name], [userr_email], [userr_password], [userr_phone], [userr_image], [type]) VALUES (1, N'mah', N'mah@gmail.com', N'123', N'01020795015', N'~/Content/upload/1738043605Toyota-Camry.jpg', N'user')
INSERT [dbo].[userr] ([userr_id], [userr_name], [userr_email], [userr_password], [userr_phone], [userr_image], [type]) VALUES (3, N'rrrr', N'rrrr@gmail.com', N'123', N'0454545', N'~/Content/upload/869833184images.jpg', N'user')
INSERT [dbo].[userr] ([userr_id], [userr_name], [userr_email], [userr_password], [userr_phone], [userr_image], [type]) VALUES (5, N'waleed', N'waleed@gmail.com', N'123', N'01545454', N'~/Content/upload/869833184images.jpg', N'admin')
INSERT [dbo].[userr] ([userr_id], [userr_name], [userr_email], [userr_password], [userr_phone], [userr_image], [type]) VALUES (7, N'werrwe', N'werrwer', N'101010101', N'01020795066', N'~/Content/upload/1585750276lionn.jpg', N'user')
SET IDENTITY_INSERT [dbo].[userr] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__admin__9CC2081704CFD399]    Script Date: 10/13/2020 12:10:41 AM ******/
ALTER TABLE [dbo].[admin] ADD UNIQUE NONCLUSTERED 
(
	[ad_username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__category__FA8C17908F517BB1]    Script Date: 10/13/2020 12:10:41 AM ******/
ALTER TABLE [dbo].[category] ADD UNIQUE NONCLUSTERED 
(
	[cat_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__userr__3E990BD546B3AA8E]    Script Date: 10/13/2020 12:10:41 AM ******/
ALTER TABLE [dbo].[userr] ADD  CONSTRAINT [UQ__userr__3E990BD546B3AA8E] UNIQUE NONCLUSTERED 
(
	[userr_email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__userr__82ADA470412D6727]    Script Date: 10/13/2020 12:10:41 AM ******/
ALTER TABLE [dbo].[userr] ADD  CONSTRAINT [UQ__userr__82ADA470412D6727] UNIQUE NONCLUSTERED 
(
	[userr_phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[category]  WITH CHECK ADD  CONSTRAINT [cat_fk_user] FOREIGN KEY([cat_fk_user])
REFERENCES [dbo].[userr] ([userr_id])
GO
ALTER TABLE [dbo].[category] CHECK CONSTRAINT [cat_fk_user]
GO
ALTER TABLE [dbo].[category]  WITH CHECK ADD FOREIGN KEY([cat_fk_ad])
REFERENCES [dbo].[admin] ([ad_id])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK__product__pro_fk___412EB0B6] FOREIGN KEY([pro_fk_userr])
REFERENCES [dbo].[userr] ([userr_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK__product__pro_fk___412EB0B6]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([pro_fk_cat])
REFERENCES [dbo].[category] ([cat_id])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [pro_f_id] FOREIGN KEY([product_fk_id])
REFERENCES [dbo].[product] ([pro_id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [pro_f_id]
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [u_f_id] FOREIGN KEY([user_fk_id])
REFERENCES [dbo].[userr] ([userr_id])
GO
ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [u_f_id]
GO
USE [master]
GO
ALTER DATABASE [marketing] SET  READ_WRITE 
GO
