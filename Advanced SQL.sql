--Creates the table with the employee's demographics
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Creates the table with employee's salary
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

--Insert values into Table 1
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

--Insert values into Table 2
INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

--Add more employees
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

--Add more salaries
Insert into EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)

--Table 3 Query
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 3 Insert
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

--Query 1
WITH CTE_Employee AS 
(SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (PARTITION BY Gender) as TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM EmployeeDemographics AS dem
JOIN EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

--Query 2
SELECT *
FROM CTE_Employee --This will not work because the CTE is not stored anywhere so you have to run everything in the WITH statement in Query 1 along with this every time

--Query 3
CREATE TABLE #temp_Employee ( --temp tables need the # sign
EmployeeID int,
JobTitle varchar(100),
Salary int
)

--Query 4
SELECT *
FROM #temp_Employee

--Query 5
INSERT INTO #temp_Employee VALUES (
'1001', 'HR', '45000'
)


--Query 6
SELECT *
FROM #temp_Employee

--Query 7
INSERT INTO #temp_Employee
SELECT * --you can take all the data from a table and insert it into a temp table
FROM EmployeeSalary

--Query 8
SELECT *
FROM #temp_Employee

--Query 9
DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

--Query 10
INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics AS emp
JOIN EmployeeSalary AS sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

--Query 11
SELECT *
FROM #temp_Employee2 --temp tables often used in stored procedures

--Query 12
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

--Query 13
SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM--TRIM gets rid of blank spaces on both sides of a string
FROM EmployeeErrors

--Query 14
SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM--LTRIM gets rid of blank spaces on the left side of a string
FROM EmployeeErrors

--Query 15
SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM--RTRIM gets rid of blank spaces on the right side of a string
FROM EmployeeErrors

--Query 16
SELECT *
FROM EmployeeErrors

--Query 17
SELECT LastName, REPLACE(LastName, ' - Fired', '') AS LastNameFixed --REPLACE(columnName, whatToReplace, replacement)
FROM EmployeeErrors

--Query 18
SELECT SUBSTRING(FirstName, 1, 3) --going to start at the 1st character in the string and will end at character 3
FROM EmployeeErrors

--Query 19
SELECT SUBSTRING(FirstName, 3, 3) --going to start at the 1st character in the string and will end at character 3
FROM EmployeeErrors

--Query 20
SELECT err.FirstName, dem.FirstName --This query only returns Toby bc Jimbo <> Jim and Pamela <> Pam
FROM EmployeeErrors AS err
JOIN EmployeeDemographics AS dem
	ON err.FirstName = dem.FirstName

--Query 21
SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3) --this utilizes 'fuzzy matches'. This query returns all 3 because all first letters match in both tables
FROM EmployeeErrors AS err
JOIN EmployeeDemographics AS dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

--Query 22
SELECT FirstName, LOWER(FirstName) --Change text to lowercase
FROM EmployeeErrors

--Query 23
SELECT FirstName, UPPER(FirstName) --Change text to uppercase
FROM EmployeeErrors

--Query 24
CREATE PROCEDURE TEST --The stored procedure lives in the Programmability folder
AS
SELECT *
FROM EmployeeDemographics

--Query 25
EXEC TEST --EXEC means 'execute'

--Query 26
CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_Employee3
CREATE TABLE #temp_Employee3 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_Employee3
SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
FROM EmployeeDemographics AS emp
JOIN EmployeeSalary AS sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

Select * 
From #temp_Employee3
GO;

EXEC Temp_Employee --You can right-click and select 'Modify' on a stored procedure in the 'Programmability' foler to change it

--Modified the stored procedure as follows:
--USE [SQLTutorial]
--GO
--/****** Object:  StoredProcedure [dbo].[Temp_Employee]    Script Date: 3/10/2024 5:51:32 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE [dbo].[Temp_Employee]
--@JobTitle nvarchar(100) --Added this parameter when modified
--AS
--DROP TABLE IF EXISTS #temp_Employee3
--CREATE TABLE #temp_Employee3 (
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int
--)

--INSERT INTO #temp_Employee3
--SELECT JobTitle, COUNT(JobTitle), Avg(Age), Avg(Salary)
--FROM EmployeeDemographics AS emp
--JOIN EmployeeSalary AS sal
--	ON emp.EmployeeID = sal.EmployeeID
--WHERE JobTitle = @JobTitle --Added this parameter when modified
--GROUP BY JobTitle

--Query 27
EXEC Temp_Employee --When we execute the stored procedure it will now ask us for a JobTitle or will error out

--Query 28
EXEC Temp_Employee @JobTitle = 'Salesman'

--Query 29
SELECT *
FROM EmployeeSalary

--Query 30
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary --Subquery in the SELECT statement
FROM EmployeeSalary

--Query 31
SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary --Gives same result as Query 30 but uses PARTITION BY
FROM EmployeeSalary

--Query 32
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary --won't work using GROUP BY, only PARTITION BY. Using GROUP BY you get the avg salary after grouping
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY 1,2

--Query 33
SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary 
		FROM EmployeeSalary) AS a --subquery in FROM. Less efficient than using a temp table or CTE

--Query 34
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (--Subquery in a WHERE statement used instead of a JOIN
			SELECT EmployeeID --requres specifying a column, cannot choose *
			FROM EmployeeDemographics
			WHERE Age > 30) --If you wanted an Age column to show you'd do that in a JOIN instead of a subquery within the WHERE statement