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

--Query 1
SELECT *
FROM EmployeeDemographics

--Query 2
SELECT FirstName
FROM EmployeeDemographics

--Query 3
SELECT FirstName, LastName
FROM EmployeeDemographics

--Query 4
SELECT TOP 5 * --TOP # returns that many results only
FROM EmployeeDemographics

--Query 5
SELECT DISTINCT(Gender) --DISTINCT returns unique values only
FROM EmployeeDemographics

--Query 6
SELECT COUNT(Gender) --COUNT gives count of all non-null values
FROM EmployeeDemographics

--Query 7
SELECT COUNT(Gender) AS GenderCount --AS gives the resulting column a name
FROM EmployeeDemographics

--Query 8
SELECT *
FROM EmployeeSalary

--Query 9
SELECT MAX(Salary)
FROM EmployeeSalary

--Query 10
SELECT MIN(Salary)
FROM EmployeeSalary

--Query 11
SELECT AVG(Salary)
FROM EmployeeSalary

--Query 11
SELECT *
FROM SQLTutorial.dbo.EmployeeSalary --FROM statement needs to start w/ the database name if you aren't already in the database

--Query 12
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim' --WHERE can be =, <> (not equal), <, >, <=, >=, And, Or, Like, Null, Not Null, In

--Query 13
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

--Query 14
SELECT *
FROM EmployeeDemographics
WHERE Age >= 30

--Query 15
SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender ='Male'

--Query 16
SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender ='Male'

--Query 17
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%' --LIKE is usually used for text info. This queries all last names that start with 'S'

--Query 18
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%' --Gives results with an S anywhere in the last name

--Query 19
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%c%t%' --Gives results with last name starting with S and has a c and t anywere in the last name

--Query 20
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%ch%' --Gives results with last name starting with S and has a ch anywere in the last name

--Query 21
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%ott%c%' --No results because it needs to be in order

--Query 22
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%c%ott%' --Now ordered, it gives results

--Query 22
SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL --Returns everything bc there are not any null values in the table

--Query 23
SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael') --IN allows you to say = for multiple things

--Query 24
SELECT DISTINCT(Gender)
FROM EmployeeDemographics

--Query 25
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender

--Query 26
SELECT Gender, Age, COUNT(Gender) --will count +1 if gender and age are the same. Will give same result regardless of if it is COUNT(Gender) or COUNT(Age)
FROM EmployeeDemographics
GROUP BY Gender, Age

--Query 27
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender

--Query 28
SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender --default is ascending

--Query 29
SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC --can change to descending

--Query 30
SELECT *
FROM EmployeeDemographics
ORDER BY Age

--Query 31
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC

--Query 32
SELECT *
FROM EmployeeDemographics
ORDER BY Age, Gender --Female first bc it is ascending 

--Query 33
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender --Oldest first bc Age is descending. Female first bc it is ascending 

--Query 34
SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 --instead of column name you can number the columns and use that

