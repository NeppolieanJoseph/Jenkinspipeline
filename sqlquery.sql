
CREATE TABLE [dbo].[Table]([Id] [int] IDENTITY(1,1) NOT NULL,[Name] [varchar](50) NULL,[Country] [varchar](50) NULL,CONSTRAINT [PK__Table__3214EC07FF09CDFE] PRIMARY KEY CLUSTERED ([Id] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

INSERT INTO [dbo].[Table]([Name],[Country]) VALUES ('Test Name','Test Country') 
INSERT INTO [dbo].[Table]([Name],[Country]) VALUES ('Neppoliean J','Canada') 
INSERT INTO [dbo].[Table]([Name],[Country]) VALUES ('JerwinJoe J','America') 
GO 
