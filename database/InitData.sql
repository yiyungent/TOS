USE [ttos]
GO
/****** Object:  StoredProcedure [dbo].[proc_bookTicket]    Script Date: 12/22/2018 11:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[proc_bookTicket] 
	@TrainNumber nvarchar(10), 
	@StartStation nvarchar(50), 
	@EndStation nvarchar(50),
	@BookDate datetime,
	@StudentId int,
	@Phone nvarchar(50),
	@Remark text,
	@LastOperatorId int
as
begin
	declare @Id int
	begin try
		begin transaction
		insert into dbo.BookTicketInfo values(@TrainNumber,@StartStation,@EndStation,@BookDate,@StudentId,@Phone,@Remark);
		select top 1 @Id=Id from dbo.BookTicketInfo order by Id desc
		--print @Id
		insert into dbo.BookTicketState(TicketSate, BookTicketInfoId, LastOperatorId) values(1, @Id, @LastOperatorId);
		commit transaction
	end try
	begin catch
		rollback transaction
		print '失败，已经回滚'
	end catch
end

GO
/****** Object:  Table [dbo].[BookTicketInfo]    Script Date: 12/22/2018 11:46:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTicketInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrainNumber] [nvarchar](10) NULL,
	[StartStation] [nvarchar](50) NULL,
	[EndStation] [nvarchar](50) NULL,
	[BookDate] [datetime] NULL,
	[StudentId] [int] NULL,
	[Phone] [nvarchar](50) NULL,
	[Remark] [nvarchar](800) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookTicketPay]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTicketPay](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PrePay] [decimal](5, 2) NULL,
	[PayMoney] [decimal](5, 2) NULL,
	[TicketPrice] [decimal](5, 2) NULL,
	[BookTicketInfoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookTicketState]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTicketState](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TicketSate] [int] NULL,
	[BookTicketInfoId] [int] NULL,
	[SureDate] [datetime] NULL,
	[ArriveDate] [datetime] NULL,
	[GotDate] [datetime] NULL,
	[LastOperatorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentNumber] [nvarchar](50) NOT NULL,
	[StudentName] [nvarchar](50) NULL,
	[Password] [nvarchar](32) NULL,
	[Gender] [bit] NULL,
	[Identification] [nvarchar](20) NULL,
	[Telephone] [nvarchar](15) NULL,
	[ClassName] [nvarchar](20) NULL,
	[RoleId] [int] NULL,
	[IsStop] [int] NULL,
 CONSTRAINT [PK_Student_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysFunction]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SysFunction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](100) NULL,
	[Url] [varchar](100) NULL,
	[IsStop] [int] NULL,
	[SortNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SysRole]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysRole](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[IsStop] [int] NULL,
	[Types] [int] NULL,
 CONSTRAINT [pk_roleId] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysRoleFunction]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysRoleFunction](
	[RoleId] [int] NULL,
	[FuncId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teacher]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teacher](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherNumber] [nvarchar](50) NULL,
	[TeacherName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[Identification] [nvarchar](100) NULL,
	[Telephone] [nvarchar](100) NULL,
	[Department] [nvarchar](100) NULL,
	[RoleId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[vw_userInfo]    Script Date: 12/22/2018 11:46:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_userInfo]
as
SELECT Id
      ,StudentNumber as UserCode
      ,StudentName as UserName
      ,Password
      ,Gender
      ,Identification as IDCard
      ,Telephone
      ,ClassName as dept
      ,RoleId
  FROM Student
  -- 注意：是union all 而不是 单 union
  -- union 对两个结果集进行并集操作，不包括重复行，同时进行默认规则的排序
  -- union all 对两个结果集进行并集操作，包括重复行，不进行排序
  -- 这里应当包括重复行，存在老师工号与学生学号相同的情况，
  -- 这里将 学生表中所有记录 与 老师表中所有记录 都并起来,包括重复行  vw总行数=student总行数+teacher总行数
  union all
SELECT Id
    ,TeacherNumber
    ,TeacherName
    ,Password
    ,Gender
    ,Identification
    ,Telephone
    ,Department
    ,RoleId
FROM Teacher

GO
SET IDENTITY_INSERT [dbo].[BookTicketInfo] ON 

INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (3, N'T56', N'重庆', N'北京', CAST(0x0000A9AA00000000 AS DateTime), 393, N'13775243407', N'??7')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (4, N'T20', N'重庆', N'南京', CAST(0x0000A9AA00000000 AS DateTime), 393, N'13775243402', N'??45')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (9, N'测试', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (10, N'T20', N'重庆', N'上海', CAST(0x0000A9B500000000 AS DateTime), 393, N'13775243402', N'???')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (15, N'T56', N'重庆', N'南京', CAST(0x0000A9AA00000000 AS DateTime), 393, N'13775243402', N'??13432????·12')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (16, N'T50', N'南京', N'北京', CAST(0x0000A9B900000000 AS DateTime), 393, N'13775243402', N'?his???')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (17, N'T55', N'韩国', N'Beijing', CAST(0x0000A9B900000000 AS DateTime), 397, N'13775243402', N'????
2018?12?17?11:53:04')
INSERT [dbo].[BookTicketInfo] ([Id], [TrainNumber], [StartStation], [EndStation], [BookDate], [StudentId], [Phone], [Remark]) VALUES (18, N'T55666', N'韩国', N'额鹅鹅鹅', CAST(0x0000A9BA00000000 AS DateTime), 397, N'13775243402', N'???????')
SET IDENTITY_INSERT [dbo].[BookTicketInfo] OFF
SET IDENTITY_INSERT [dbo].[BookTicketState] ON 

INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (2, 0, 3, CAST(0x0000A9A900000000 AS DateTime), CAST(0x00009E4A00000000 AS DateTime), CAST(0x0000A9AC00000000 AS DateTime), 1)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (3, 3, 4, CAST(0x0000A9A900000000 AS DateTime), CAST(0x00009E4A00000000 AS DateTime), CAST(0x0000A9AC00000000 AS DateTime), 1)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (8, 0, 10, NULL, NULL, NULL, 1)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (9, 0, 15, NULL, NULL, NULL, 1)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (10, 0, 16, NULL, NULL, NULL, 1)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (11, 0, 17, NULL, NULL, NULL, 397)
INSERT [dbo].[BookTicketState] ([Id], [TicketSate], [BookTicketInfoId], [SureDate], [ArriveDate], [GotDate], [LastOperatorId]) VALUES (12, 1, 18, NULL, NULL, NULL, 397)
SET IDENTITY_INSERT [dbo].[BookTicketState] OFF
SET IDENTITY_INSERT [dbo].[Student] ON 

INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (347, N'17001051', N'新人1', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234811', N'1377524341', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (348, N'17001052', N'新人2', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234812', N'1377524342', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (349, N'17001053', N'新人3', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234813', N'1377524343', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (350, N'17001054', N'新人4', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234814', N'1377524344', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (351, N'17001055', N'新人5', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234815', N'1377524345', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (352, N'17001056', N'新人6', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234816', N'1377524346', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (353, N'17001057', N'新人7', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234817', N'1377524347', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (354, N'17001058', N'新人8', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234818', N'1377524348', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (355, N'17001059', N'新人9', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50033312881234819', N'1377524349', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (356, N'170010510', N'新人10', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348110', N'13775243410', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (357, N'170010511', N'新人11', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348111', N'13775243411', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (358, N'170010512', N'新人12', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348112', N'13775243412', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (359, N'170010513', N'新人13', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348113', N'13775243413', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (360, N'170010514', N'新人14', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348114', N'13775243414', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (361, N'170010515', N'新人15', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348115', N'13775243415', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (362, N'170010516', N'新人16', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348116', N'13775243416', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (363, N'170010517', N'新人17', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348117', N'13775243417', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (364, N'170010518', N'新人18', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348118', N'13775243418', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (365, N'170010519', N'新人19', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348119', N'13775243419', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (366, N'170010520', N'新人20', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348120', N'13775243420', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (367, N'170010521', N'新人21', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348121', N'13775243421', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (368, N'170010522', N'新人22', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348122', N'13775243422', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (369, N'170010523', N'新人23', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348123', N'13775243423', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (370, N'170010524', N'新人24', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348124', N'13775243424', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (371, N'170010525', N'新人25', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348125', N'13775243425', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (372, N'170010526', N'新人26', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348126', N'13775243426', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (373, N'170010527', N'新人27', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348127', N'13775243427', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (374, N'170010528', N'新人28', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348128', N'13775243428', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (375, N'170010529', N'新人29', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348129', N'13775243429', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (376, N'170010530', N'新人30', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348130', N'13775243430', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (377, N'170010531', N'新人31', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348131', N'13775243431', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (378, N'170010532', N'新人32', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348132', N'13775243432', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (379, N'170010533', N'新人33', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348133', N'13775243433', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (380, N'170010534', N'新人34', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348134', N'13775243434', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (381, N'170010535', N'新人35', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348135', N'13775243435', N'1', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (382, N'170010536', N'新人36', N'21232f297a57a5a743894a0e4a801fc3', 0, N'500333128812348136', N'13775243436', N'1700105', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (383, N'170010537', N'新人37', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348137', N'13775243437', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (384, N'170010538', N'新人38', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348138', N'13775243438', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (385, N'170010539', N'新人39', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348139', N'13775243439', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (386, N'170010540', N'新人40', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348140', N'13775243440', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (387, N'170010541', N'新人41', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348141', N'13775243441', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (388, N'170010542', N'新人42', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348142', N'13775243442', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (389, N'170010543', N'新人43', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348143', N'13775243443', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (390, N'170010544', N'新人44', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348144', N'13775243444', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (391, N'170010545', N'新人45', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348145', N'13775243445', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (392, N'170010546', N'新人46', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348146', N'13775243446', N'1', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (393, N'170010547', N'新人47', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333128812348147', N'13775243447', N'1', 4, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (394, N'170010550', N'摩天新人2二惹人1', N'0e6f55801fa6a193fc155cd6cdeb6576', 1, N'500333199812156130', N'13775243402', N'1700105', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (395, N'170010556', N'新人提三语', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333199812156130', N'13775243402', N'1700105', 1, 1)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (396, N'170010548', N'新人鹅鹅鹅', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333199812156130', N'13775243402', N'1700105', 4, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (397, N'170010578', N'魔噩11', N'21232f297a57a5a743894a0e4a801fc3', 1, N'500333199812156130', N'13775243402', N'1700105', 4, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (398, N'170010567', N'二次验证测试', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50022211981215811', N'13775243402', N'1700105', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (399, N'170010598', N'二次验证03', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50022211981215811', N'13775243402', N'1700105', 1, 0)
INSERT [dbo].[Student] ([Id], [StudentNumber], [StudentName], [Password], [Gender], [Identification], [Telephone], [ClassName], [RoleId], [IsStop]) VALUES (400, N'170010579', N'二次验证会话', N'21232f297a57a5a743894a0e4a801fc3', 1, N'50022211981215811', N'13775243402', N'1700105', 1, 0)
SET IDENTITY_INSERT [dbo].[Student] OFF
SET IDENTITY_INSERT [dbo].[SysFunction] ON 

INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (1, N'学生信息', N'/Admin/StudentList.aspx', 0, 10)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (2, N'教师信息', N'http://chuangzaoshi.com/code', 0, 20)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (3, N'修改密码', N'https://tympanus.net/codrops/', 0, 30)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (4, N'申请订票', N'a', 0, 40)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (5, N'到票登记', N'a', 0, 50)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (6, N'领票', N'a', 0, 60)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (7, N'确认订票', N'a', 0, 45)
INSERT [dbo].[SysFunction] ([Id], [MenuName], [Url], [IsStop], [SortNo]) VALUES (8, N'订票统计', N'a', 0, 80)
SET IDENTITY_INSERT [dbo].[SysFunction] OFF
SET IDENTITY_INSERT [dbo].[SysRole] ON 

INSERT [dbo].[SysRole] ([RoleId], [RoleName], [IsStop], [Types]) VALUES (1, N'普通学生', 0, 1)
INSERT [dbo].[SysRole] ([RoleId], [RoleName], [IsStop], [Types]) VALUES (2, N'普通教师', 0, 2)
INSERT [dbo].[SysRole] ([RoleId], [RoleName], [IsStop], [Types]) VALUES (3, N'教师管理员', 0, 2)
INSERT [dbo].[SysRole] ([RoleId], [RoleName], [IsStop], [Types]) VALUES (4, N'学生管理员', 0, 1)
SET IDENTITY_INSERT [dbo].[SysRole] OFF
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (1, 1)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (1, 3)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (1, 4)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (1, 5)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 2)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 3)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 4)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 5)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 3)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 5)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 2)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 7)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 8)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (3, 1)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 6)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 7)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (2, 8)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (4, 1)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (4, 3)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (4, 4)
INSERT [dbo].[SysRoleFunction] ([RoleId], [FuncId]) VALUES (4, 5)
SET IDENTITY_INSERT [dbo].[Teacher] ON 

INSERT [dbo].[Teacher] ([Id], [TeacherNumber], [TeacherName], [Password], [Gender], [Identification], [Telephone], [Department], [RoleId]) VALUES (1, N'9876', N'测试老师', N'21232f297a57a5a743894a0e4a801fc3', 1, NULL, NULL, NULL, 3)
SET IDENTITY_INSERT [dbo].[Teacher] OFF
ALTER TABLE [dbo].[BookTicketInfo]  WITH CHECK ADD  CONSTRAINT [fk_studentId] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Student] ([Id])
GO
ALTER TABLE [dbo].[BookTicketInfo] CHECK CONSTRAINT [fk_studentId]
GO
ALTER TABLE [dbo].[BookTicketPay]  WITH CHECK ADD  CONSTRAINT [pk_pay_bookTicketInfoId] FOREIGN KEY([BookTicketInfoId])
REFERENCES [dbo].[BookTicketInfo] ([Id])
GO
ALTER TABLE [dbo].[BookTicketPay] CHECK CONSTRAINT [pk_pay_bookTicketInfoId]
GO
ALTER TABLE [dbo].[BookTicketState]  WITH CHECK ADD  CONSTRAINT [pk_bookTicketInfoId] FOREIGN KEY([BookTicketInfoId])
REFERENCES [dbo].[BookTicketInfo] ([Id])
GO
ALTER TABLE [dbo].[BookTicketState] CHECK CONSTRAINT [pk_bookTicketInfoId]
GO
ALTER TABLE [dbo].[SysRoleFunction]  WITH CHECK ADD FOREIGN KEY([FuncId])
REFERENCES [dbo].[SysFunction] ([Id])
GO
ALTER TABLE [dbo].[SysRoleFunction]  WITH CHECK ADD FOREIGN KEY([FuncId])
REFERENCES [dbo].[SysFunction] ([Id])
GO
ALTER TABLE [dbo].[SysRoleFunction]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[SysRole] ([RoleId])
GO
ALTER TABLE [dbo].[SysRoleFunction]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[SysRole] ([RoleId])
GO
