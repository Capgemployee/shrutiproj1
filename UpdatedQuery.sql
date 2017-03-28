create database Training_18Jan2017_Talwade

--###################################################

USE [Training_18Jan2017_Talwade]
GO

--###################################################
CREATE SCHEMA [MySchemaEMS]
GO

--###################### TABLES #####################
CREATE TABLE [MySchemaEMS].EmployeeDetails
(
EmpID INT PRIMARY KEY IDENTITY(121100,1),
DeptID INT FOREIGN KEY REFERENCES  [MySchemaEMS].DeptDetails(DeptID),
EmpFName VARCHAR(20) NOT NULL,
EmpLName VARCHAR(20) NOT NULL,
EmpGender CHAR NOT NULL
CONSTRAINT CHK_Gender CHECK (EmpGender='M' OR EmpGender='F'),
EmpAge INT NOT NULL
CONSTRAINT CHK_Age CHECK(EmpAge>=18 AND EmpAge<=60),
EmpDesignation VARCHAR(20) NOT NULL,
EmpSkills VARCHAR(30) NOT NULL,
EmpSalary NUMERIC(10,2) NOT NULL,
EmpAddress VARCHAR(50) NOT NULL,
EmpDOB Date NOT NULL,
EmpDOJ Datetime NOT NULL,
EmpContactNo NUMERIC(10) NOT NULL,
EmpEmailId VARCHAR(30) NOT NULL
)

CREATE TABLE [MySchemaEMS].DeptDetails(
DeptID INT PRIMARY KEY,
DeptName VARCHAR(20) NOT NULL,
)

CREATE TABLE [MySchemaEMS].ClientDetails
(
ClientID INT PRIMARY KEY,
ProjectName VARCHAR(40) NOT NULL,
StartDate Date NOT NULL,
EndDate Date NOT NULL
)

CREATE TABLE [MySchemaEMS].LoginDetails(
UserID VARCHAR(30) PRIMARY KEY,
UserPswd VARCHAR(30) NOT NULL,
UserType VARCHAR(30) NOT NULL
)

CREATE TABLE [MySchemaEMS].ProjectDetails(
ProjectID INT PRIMARY KEY,
ProjectName VARCHAR(40) NOT NULL,
ProjectTechnology VARCHAR(50) NOT NULL
)

CREATE TABLE [MySchemaEMS].ProjectAllocationDetails(
ProjectID INT FOREIGN KEY REFERENCES  [MySchemaEMS].ProjectDetails(ProjectID),
ProjectName VARCHAR(40) NOT NULL,
ProjectManager VARCHAR(20) NOT NULL,
ProjectTL VARCHAR(20) NOT NULL
)      
--start date and end date will be taken from clientDetails table

--################# SELECT COMMAND ###########################

SELECT * FROM  [MySchemaEMS].EmployeeDetails

SELECT * FROM  [MySchemaEMS].DeptDetails

SELECT * FROM  [MySchemaEMS].ClientDetails

SELECT * FROM  [MySchemaEMS].LoginDetails

SELECT * FROM  [MySchemaEMS].ProjectDetails

SELECT * FROM  [MySchemaEMS].ProjectAllocationDetails

--################# DROP COMMAND ##############################

DROP TABLE [MySchemaEMS].EmployeeDetails

DROP TABLE [MySchemaEMS].DeptDetails

DROP TABLE [MySchemaEMS].ClientDetails

DROP TABLE [MySchemaEMS].LoginDetails

DROP TABLE [MySchemaEMS].ProjectDetails

DROP TABLE [MySchemaEMS].ProjectAllocationDetails

--################# INSERT COMMAND ##############################

INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(115,'Shruti','Hassan','F',22,'Developer','DOT.NET',200000,'Nagpur','03/24/2017','01/18/2017',9870657483,'shruti@gmail.com')
INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(115,'Shru','Hassan','F',22,'Developer','TESTING',200000,'Mumbai','03/24/2017','01/18/2017',9870657483,'shru@gmail.com')
INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(115,'Shrutiiii','Hassan','F',22,'Developer','JAVA',200000,'Pune','04/28/2017','01/18/2017',9870657483,'shrutiiii@gmail.com')
INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(114,'Karan','Johar','M',22,'Manager','JAVA',200000,'Pune','04/25/2017','01/18/2017',9870657483,'karan@gmail.com')

INSERT INTO [MySchemaEMS].DeptDetails
VALUES(112,'HR')
INSERT INTO [MySchemaEMS].DeptDetails
VALUES(113,'ADMIN')
INSERT INTO [MySchemaEMS].DeptDetails
VALUES(114,'MANAGER')
INSERT INTO [MySchemaEMS].DeptDetails
VALUES(115,'DEVELOPER')

INSERT INTO [MySchemaEMS].ClientDetails
VALUES('1211','EMS','01/01/2015','03/03/2016')

INSERT INTO [MySchemaEMS].LoginDetails
VALUES('manager','manager123','MANAGER')
INSERT INTO [MySchemaEMS].LoginDetails
VALUES('admin','admin123','ADMIN')
INSERT INTO [MySchemaEMS].LoginDetails
VALUES('hr','hr123','HR')

INSERT INTO [MySchemaEMS].ProjectDetails
VALUES('1001','EMS','JAVA')

INSERT INTO [MySchemaEMS].ProjectAllocationDetails
VALUES('1001','EMS','Karan','Shruti')

--############# STORED PROCEDURE OF EMPLOYEE #############################
CREATE PROCEDURE [MySchemaEMS].DisplayAllEmployee
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails

CREATE PROCEDURE [MySchemaEMS].EmployeeInfo
(
@EmpID INT
)
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails
WHERE EmpID=@EmpID

ALTER PROCEDURE [MySchemaEMS].UpdateEmployeeInfo
(
	@EmpID INT,
	@DeptID INT OUT,
	@EmpFName VARCHAR(20),
	@EmpLName VARCHAR(20),
	@EmpGender CHAR,
	@EmpAge INT,
	@EmpSkills VARCHAR(30),
	@EmpDesignation VARCHAR(20) OUT,
	@EmpSalary NUMERIC(10,2) OUT,
	@EmpAddress VARCHAR(50),
	@EmpDOB Date,
	@EmpDOJ Datetime OUT,
	@EmpContactNo NUMERIC(10),
	@EmpEmailId VARCHAR(30)	
)
AS
UPDATE [MySchemaEMS].EmployeeDetails 
SET EmpFName=@EmpFName,EmpLName=@EmpLName,EmpGender=@EmpGender,EmpAge=@EmpAge,
@EmpSkills=EmpSkills,EmpAddress=@EmpAddress,EmpDOB=@EmpDOB,
EmpContactNo=@EmpContactNo,EmpEmailId=@EmpEmailId
WHERE EmpID=@EmpID

--############# STORED PROCEDURE OF HR #############################
CREATE PROCEDURE [MySchemaEMS].DisplayAllEmployeeDetails
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails

CREATE PROCEDURE [MySchemaEMS].RetrieveEmployeeDetails
(
	@DeptName VARCHAR(20),
	@DeptID INT
)
AS
SELECT  emp.EmpID,emp.EmpFName,emp.EmpLName,emp.EmpGender,emp.EmpAge,emp.EmpSkills,emp.EmpAddress,emp.EmpDOB,
emp.EmpDOJ,emp.EmpContactNo,emp.EmpEmailId,dept.DeptName
FROM [MySchemaEMS].EmployeeDetails emp
INNER JOIN [MySchemaEMS].DeptDetails dept
ON emp.DeptID=dept.DeptID
WHERE DeptName=@DeptName

ALTER PROCEDURE [MySchemaEMS].UpdateEmployee
(
	@EmpID INT,
	@DeptID INT,
	@EmpFName VARCHAR(20),
	@EmpLName VARCHAR(20),
	@EmpGender CHAR,
	@EmpAge INT,
	@EmpSkills VARCHAR(30),
	@EmpDesignation VARCHAR(20),
	@EmpSalary NUMERIC(10,2),
	@EmpAddress VARCHAR(50),
	@EmpDOB Date,
	@EmpDOJ Datetime,
	@EmpContactNo NUMERIC(10),
	@EmpEmailId VARCHAR(30)	
)
AS
UPDATE [MySchemaEMS].EmployeeDetails 
SET DeptID=@DeptID,EmpFName=@EmpFName,EmpLName=@EmpLName,EmpGender=@EmpGender,EmpAge=@EmpAge,
EmpSkills=@EmpSkills,EmpDesignation=@EmpDesignation,EmpSalary=@EmpSalary,EmpAddress=@EmpAddress,
EmpDOB=@EmpDOB,EmpDOJ=@EmpDOJ,EmpContactNo=@EmpContactNo,EmpEmailId=@EmpEmailId
WHERE EmpID=@EmpID

CREATE PROCEDURE [MySchemaEMS].AddEmployeeRecord
(
	@EmpID INT OUT,
	@DeptID INT,
	@EmpFName VARCHAR(20),
	@EmpLName VARCHAR(20),
	@EmpGender CHAR,
	@EmpAge INT,
	@EmpSkills VARCHAR(30),
	@EmpDesignation VARCHAR(20),
	@EmpSalary NUMERIC(10,2),
	@EmpAddress VARCHAR(50),
	@EmpDOB Date,
	@EmpDOJ Datetime,
	@EmpContactNo NUMERIC(10),
	@EmpEmailId VARCHAR(30)	
)
AS
INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(@DeptID,@EmpFName,@EmpLName,@EmpGender,@EmpAge,@EmpSkills,@EmpDesignation,@EmpSalary,
@EmpAddress,@EmpDOB,@EmpDOJ,@EmpContactNo,@EmpEmailId)

CREATE PROCEDURE [MySchemaEMS].DeleteEmployeeRecord
(
	@EmpID INT
)
AS
DELETE FROM [MySchemaEMS].EmployeeDetails
WHERE  EmpID=@EmpID

CREATE PROCEDURE [MySchemaEMS].HRInfo
(
@EmpID INT
)
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails
WHERE EmpID=@EmpID


--############# STORED PROCEDURE OF ADMIN #############################
CREATE PROCEDURE [MySchemaEMS].AddHRRecord
(
	@EmpID INT OUT,
	@DeptID INT,
	@EmpFName VARCHAR(20),
	@EmpLName VARCHAR(20),
	@EmpGender CHAR,
	@EmpAge INT,
	@EmpSkills VARCHAR(30),
	@EmpDesignation VARCHAR(20),
	@EmpSalary NUMERIC(10,2),
	@EmpAddress VARCHAR(50),
	@EmpDOB Date,
	@EmpDOJ Datetime,
	@EmpContactNo NUMERIC(10),
	@EmpEmailId VARCHAR(30)	
)
AS
INSERT INTO [MySchemaEMS].EmployeeDetails
VALUES(@DeptID,@EmpFName,@EmpLName,@EmpGender,@EmpAge,@EmpSkills,@EmpDesignation,@EmpSalary,
@EmpAddress,@EmpDOB,@EmpDOJ,@EmpContactNo,@EmpEmailId)

CREATE PROCEDURE [MySchemaEMS].DeleteHRRecord
(
	@EmpID INT
)
AS
DELETE FROM [MySchemaEMS].EmployeeDetails
WHERE  EmpID=@EmpID

CREATE PROCEDURE [MySchemaEMS].UpdateHRRecord
(
	@EmpID INT,
	@DeptID INT,
	@EmpFName VARCHAR(20),
	@EmpLName VARCHAR(20),
	@EmpGender CHAR,
	@EmpAge INT,
	@EmpSkills VARCHAR(30),
	@EmpDesignation VARCHAR(20),
	@EmpSalary NUMERIC(10,2),
	@EmpAddress VARCHAR(50),
	@EmpDOB Date,
	@EmpDOJ Datetime,
	@EmpContactNo NUMERIC(10),
	@EmpEmailId VARCHAR(30)	
)
AS
UPDATE [MySchemaEMS].EmployeeDetails 
SET DeptID=@DeptID,EmpFName=@EmpFName,EmpLName=@EmpLName,EmpGender=@EmpGender,EmpAge=@EmpAge,
EmpSkills=@EmpSkills,EmpDesignation=@EmpDesignation,EmpSalary=@EmpSalary,EmpAddress=@EmpAddress,
EmpDOB=@EmpDOB,EmpDOJ=@EmpDOJ,EmpContactNo=@EmpContactNo,EmpEmailId=@EmpEmailId
WHERE EmpID=@EmpID

CREATE PROCEDURE [MySchemaEMS].AdminInfo
(
@EmpID INT
)
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails
WHERE EmpID=@EmpID

CREATE PROCEDURE [MySchemaEMS].DisplayAllEmployeeRecord
AS
SELECT * FROM [MySchemaEMS].EmployeeDetails