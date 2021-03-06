CREATE TABLE [dbo].[Schedule](
	[Name] [varchar](120) COLLATE Latin1_General_CI_AI NOT NULL,
	[InboxWorkQueueUri] [varchar](65) NOT NULL,
	[CronExpression] [varchar](25) COLLATE Latin1_General_CI_AI NOT NULL,
	[NextNotification] [datetime] NOT NULL,
 CONSTRAINT [PK_Schedule] PRIMARY KEY CLUSTERED 
(
	[Name] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

