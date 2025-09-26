--Table Creation and Insert Values

Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)

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

Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

--Select Statements

Select *
From EmployeeDemographics         

Select TOP 5 *
From EmployeeDemographics

SELECT FirstName
From EmployeeDemographics

Select FirstName, LastName
From EmployeeDemographics

SELECT DISTINCT(Gender)
From EmployeeDemographics

SELECT COUNT(LastName) AS Number
From EmployeeDemographics

SELECT MAX(Salary)
From EmployeeSalary

SELECT Min(Salary)
From EmployeeSalary

SELECT AVG(Salary)
From EmployeeSalary

--RUNNING FROM DIFFERENT DATABASE

SELECT *
From SQLTutorial.dbo.EmployeeDemographics

-- 

-- WHERE 

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim' AND Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim' OR Gender = 'Male'

--<> means not equal to

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

--

SELECT *
FROM EmployeeDemographics
WHERE Age < 30

SELECT *
FROM EmployeeDemographics
WHERE Age >= 30

--Begins with s

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

--

--S anywhere

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'

--

--Containing S and O in order

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%O%'

--

--Containing letters S,c,ott in order

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%C%OTT%'

--

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL

--IN means Equal to Multiple things, FirstName equal to Jim or Michael

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('JIM', 'MICHAEL')

--

-- GROUP BY, ORDER BY

SELECT Gender, COUNT(Gender) AS Number
FROM EmployeeDemographics
GROUP BY Gender
ORDER BY Number DESC

--ASCENDING IS THE DEFAULT ORDER

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC

--

--We can order by column numbers too. 4 and 5 are the column numbers of Age and Gender Respectively. And It does Order by 4 first in desc, then 5 in ASC.

SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 

--

-- JOINS :FULL OUTER JOIN, Left Outer Join, Right Outer Join

SELECT *
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--

----SELECT EmployeeDemographics.EmployeeID,FirstName, Salary. Here, EmployeeID is an ambiguous column name. So,we have to select which table's EmployeeID are we referencing.

-- Union: Similar data selection

SELECT *
FROM EmployeeDemographics
UNION
SELECT *
FROM WareHouseEmployeeDemographics

-- Full Outer Join: Tables union. Even if column name matches with both tables, both columns will be different.
--Union: Data Union with Tables. When column name matches from two tables, two columns will be merged to one.
--Union All: Duplicate data will also be presented if data are duplicated.
--

-- Case Statement: Case 1 gets fulfilled first,then Case 2.

SELECT FirstName, LastName, Age,
CASE
WHEN Age>30 THEN 'OLD'
WHEN Age Between 27 and 30 THEN 'YOUNG'
ELSE 'BABY'
END
FROM EmployeeDemographics

--

SELECT FirstName, LastName, JobTitle, Salary,
CASE
WHEN JobTitle = 'Salesman' THEN SALARY + (SALARY * .10)
WHEN JobTitle = 'Accountant' THEN SALARY + (SALARY * .05)
ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--

-- Group By-HAVING-ORDER BY
SELECT JobTitle, COUNT(JobTitle) AS NUMBER
FROM EmployeeDemographics
JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

-- UPDATE AND DELETE

UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE EmployeeID = 1012

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1012

--

--Aliasing - Temporarily changing a column name or table name in a script. We can use AS or it even works without AS.

SELECT FirstName FName
FROM EmployeeDemographics

SELECT FirstName + ''+ LastName AS FullName
FROM EmployeeDemographics

SELECT DEMO.EmployeeID
FROM EmployeeDemographics AS Demo

--

-- PARTITION BY

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
OVER(Partition by Gender) as TotalGender
FROM EmployeeDemographics a
JOIN EmployeeSalary b
ON
a.EmployeeID = b.EmployeeID

--

--CTEs = Common Table Expression
--     = named temporary result set which is used to manipulate complex subqueries data

WITH CTE_Employee AS
(SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
OVER(Partition by Gender) as TotalGender
FROM EmployeeDemographics a
JOIN EmployeeSalary b
ON
a.EmployeeID = b.EmployeeID)
SELECT FirstName
From CTE_Employee

--

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)


Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

--Temp Tables = Temporary Tables

Create table #temp_employee2 (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select * From #temp_employee2

Insert into #temp_employee2 values (
'1001', 'HR', '45000'
)

Insert into #temp_employee2 
SELECT * From EmployeeSalary

Select * From #temp_employee2

DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee3

SELECT AvgAge * AvgSalary
from #temp_employee3

--

-- Stored Procedures: A group of SQL statements that has been created and stored in that database. A stored procedure can accept input parameters. 
-- A single stored procedure can be used over the network by several users and we can all be using different input data. It reduces network traffic and increase the performance.
-- Lastly, If we modify the stored procedure, Everyone who uses stored procedure in the future will also get that update. Stored procedures are stored in programmability.

CREATE PROCEDURE Temp_Employee
AS
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
group by JobTitle

Select * 
From #temp_employee
GO;




CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
DROP TABLE IF EXISTS #temp_employee3
Create table #temp_employee3 (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee3
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
where JobTitle = @JobTitle 
group by JobTitle

Select * 
From #temp_employee3
GO;


exec Temp_Employee2 @jobtitle = 'Salesman'
exec Temp_Employee2 @jobtitle = 'Accountant'

--

--String Functions

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

-- Using Trim, LTRIM, RTRIM

Select EmployeeID, TRIM(employeeID) AS IDTRIM
FROM EmployeeErrors 

Select EmployeeID, RTRIM(employeeID) as IDRTRIM
FROM EmployeeErrors 

Select EmployeeID, LTRIM(employeeID) as IDLTRIM
FROM EmployeeErrors 

-- Using Replace

Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
FROM EmployeeErrors


-- Using Substring #Fuzzy Matching

Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)



-- Using UPPER and lower

Select firstname, LOWER(firstname)
from EmployeeErrors

Select Firstname, UPPER(FirstName)
from EmployeeErrors

Select EmployeeID, JobTitle, Salary
From EmployeeSalary

--

-- Subqueries: inner queries/nestic queries
--           : query within a query.It is used to return data that will be used in the main query or the outer query as a condition to specify the data we want retrieved.We can use subqueries anywhere in the query.

-- Subquery in Select

Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary

-- Why Group By doesn't work
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID


-- Subquery in From

Select a.EmployeeID, AllAvgSalary
From 
	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
	 From EmployeeSalary) a
Order by a.EmployeeID


-- Subquery in Where


Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)

--

