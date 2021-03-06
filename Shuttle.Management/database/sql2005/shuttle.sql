USE [Shuttle]
GO
/****** Object:  Table [dbo].[Queue]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Queue](
	[Id] [uniqueidentifier] NOT NULL,
	[Uri] [varchar](512) NOT NULL,
 CONSTRAINT [PK_Queue] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Queue] ON [dbo].[Queue] 
(
	[Uri] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionStore]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubscriptionStore](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](64) NOT NULL,
	[ConnectionString] [varchar](1024) NOT NULL,
	[ProviderName] [varchar](512) NOT NULL,
 CONSTRAINT [PK_SubscriptionStore] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SubscriptionStore] ON [dbo].[SubscriptionStore] 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriberMessageTypeRequest]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubscriberMessageTypeRequest](
	[InboxWorkQueueUri] [varchar](65) NOT NULL,
	[MessageType] [varchar](250) NOT NULL,
	[Declined] [int] NOT NULL,
	[DeclinedBy] [varchar](250) NULL,
	[DeclinedReason] [varchar](1500) NULL,
	[DeclinedDate] [datetime] NULL,
 CONSTRAINT [PK_SubscriberMessageTypeRequest] PRIMARY KEY CLUSTERED 
(
	[InboxWorkQueueUri] ASC,
	[MessageType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubscriberMessageType]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubscriberMessageType](
	[InboxWorkQueueUri] [varchar](65) NOT NULL,
	[MessageType] [varchar](250) NOT NULL,
	[AcceptedBy] [varchar](250) NULL,
	[AcceptedDate] [datetime] NULL,
 CONSTRAINT [PK_SubscriberMessageType] PRIMARY KEY CLUSTERED 
(
	[InboxWorkQueueUri] ASC,
	[MessageType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemUser]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUser](
	[Id] [uniqueidentifier] NOT NULL,
	[LoginName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_SystemUser] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemUserPermission]    Script Date: 01/22/2011 11:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemUserPermission](
	[SystemUserId] [uniqueidentifier] NOT NULL,
	[Permission] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[usp_GrantSystemUserAccessToAll]    Script Date: 01/22/2011 11:32:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GrantSystemUserAccessToAll]
AS
BEGIN
	SET NOCOUNT ON;

	insert into dbo.SystemUserPermission
		(
			SystemUserId,
			Permission
		)
	select
		Id,
		'permission://shuttle/systemuser'
	from
		SystemUser
END
GO
/****** Object:  Default [DF_SubscriberMessageTypeRequest_Declined]    Script Date: 01/22/2011 11:32:09 ******/
ALTER TABLE [dbo].[SubscriberMessageTypeRequest] ADD  CONSTRAINT [DF_SubscriberMessageTypeRequest_Declined]  DEFAULT ((0)) FOR [Declined]
GO
/****** Object:  ForeignKey [FK_SystemUserPermission_SystemUser]    Script Date: 01/22/2011 11:32:09 ******/
ALTER TABLE [dbo].[SystemUserPermission]  WITH CHECK ADD  CONSTRAINT [FK_SystemUserPermission_SystemUser] FOREIGN KEY([SystemUserId])
REFERENCES [dbo].[SystemUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SystemUserPermission] CHECK CONSTRAINT [FK_SystemUserPermission_SystemUser]
GO
