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
SELECT *
FROM EmployeeDemographics

SELECT * 
FROM EmployeeSalary

--Query 2
SELECT *
FROM EmployeeDemographics
Inner Join EmployeeSalary --Default on join is inner, so you don't have to specify that. Options are Inner, Left Outer, Right Outer, Full Outer
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 3
--Query 2
SELECT *
FROM EmployeeDemographics
Full Outer Join EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 4
SELECT *
FROM EmployeeDemographics
Left Outer Join EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 5
SELECT *
FROM EmployeeDemographics
Right Outer Join EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 6
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary --Have to specify which table you want EmployeeID to come from
FROM EmployeeDemographics
Join EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


--Query 7
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary --Have to specify which table you want EmployeeID to come from
FROM EmployeeDemographics
Full Outer Join EmployeeSalary 
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 8
SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC

--Query 9
SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

--Query 10
--Unions do not require a common column
SELECT *
FROM EmployeeDemographics
Full Outer Join WareHouseEmployeeDemographics  --Join is not best for this case bc it duplicates a lot of columns. Instead, UNION works well when all columns are the same
	ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

--Query 11
SELECT *
FROM EmployeeDemographics
UNION --This combines the tables w/o duplicating columns. UNION will remove duplicates.
SELECT *
FROM WareHouseEmployeeDemographics

--Query 12
SELECT *
FROM EmployeeDemographics
UNION ALL--UNION ALL keeps duplicates
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY EmployeeID

--Query 13
SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics
UNION --This union does not work well bc the columns are not the same across both tables. It will show a column titled FirstName that contains both FirstNames + JobTitles and a column titled Age that will contain both Age + Salary
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary

--Query 14
SELECT FirstName, LastName, Age,
CASE --A Case Statement is like a python If statement
	WHEN Age > 30 THEN 'Old'
	ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--Query 15
SELECT FirstName, LastName, Age,
CASE 
	WHEN Age > 30 THEN 'Old' -- You can do as many when/then statements as you like. If multiple conditions meet the criteria, only the first statement is returned
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--Query 16
SELECT FirstName, LastName, Age,
CASE 
	WHEN Age > 30 THEN 'Old' 
	WHEN Age = 38 THEN 'Stanley' --If multiple conditions meet the criteria, only the first statement is returned. So this returns 'Old' instead of 'Stanley'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--Query 17
SELECT FirstName, LastName, Age,
CASE 
	WHEN Age = 38 THEN 'Stanley' --Now that this is the first statement, 'Stanley' is returned instead of 'Old'
	WHEN Age > 30 THEN 'Old' 
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--Query 18
SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary *0.10) --Salesmen get 10% raise
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary *0.05) --Accountants get 5% raise
	WHEN JobTitle = 'HR' THEN Salary + (Salary *0.000001)
	ELSE Salary + (Salary * 0.03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Query 19
SELECT JobTitle, COUNT(Jobtitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE COUNT(JobTitle) >1 --Cannot use aggregate function in a WHERE clause. 'ERROR: An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.'
GROUP BY JobTitle

--Query 20
SELECT JobTitle, COUNT(Jobtitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1 --You can use aggregate functions in a WHERE clause but it needs to happen after grouping

--Query 21
SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

--Query 22
UPDATE EmployeeDemographics --Update will replace values
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

SELECT *
FROM EmployeeDemographics

--Query 23
UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female' --You can update several things at a time
WHERE FirstName = 'Holly' AND LastName = 'Flax'

SELECT *
FROM EmployeeDemographics

--Query 24
DELETE FROM EmployeeDemographics --Deletes an entire row, you cannot reverse this
WHERE EmployeeID = 1005

SELECT *
FROM EmployeeDemographics

--Query 25
SELECT FirstName AS Fname --Aliasing using AS
FROM EmployeeDemographics

--Query 26
SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

--Query 27
SELECT AVG(Age) AS AvgAve
FROM EmployeeDemographics

--Query 28
SELECT Demo.EmployeeID, Sal.Salary
FROM EmployeeDemographics AS Demo --You can also alias table names
JOIN EmployeeSalary as Sal
	ON Demo.EmployeeID = Sal.EmployeeID

--Query 29
SELECT Demo.EmployeeID, Demo.FirstName, Sal.JobTitle, Ware.Age
FROM EmployeeDemographics AS Demo
LEFT JOIN EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics AS Ware
	ON Demo.EmployeeID = Ware.EmployeeID

--Query 30
--GROUP BY reduces the amt of rows returned by performing aggregate funtions. PARTITION BY does not
SELECT *
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary


--Query 31
SELECT FirstName, LastName, Gender, Salary,
COUNT(GENDER) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics AS dem
JOIN EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID

--Query 32
SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics AS dem
JOIN EmployeeSalary AS sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender