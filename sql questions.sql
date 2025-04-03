--Use database command--
use LearningSQL;
Go
--create employee table--
Create Table Employee
(
EmpID int Not null,
EmpName varchar,
Gender char,
Salary int,
City char(20)
);
--Alter column in employee table to change length size--
ALTER TABLE Employee ALTER COLUMN EmpName VARCHAR(50);

--insert values into employee table--
Insert into Employee(EmpID,EmpName,Gender,Salary,City)
Values
(1,'Arjun','M',75000,'Pune'),
(2,'Ekadanta','M',125000,'Bangalore'),
(3,'Lalitha','F',150000,'Mathura'),
(4,'Madhav','M',250000,'Delhi'),
(5,'Vishaka','F',120000,'Mathura');
--retrieve data table--
select * from employee;

--Create EmployeeDetail table--
Create table EmployeeDetail
(
EmpID int Not Null,
Project char,
EmpPosition char(20),
DOJ date
);
--Alter project column to change the length size --
Alter Table EmployeeDetail Alter Column Project varchar(10);
--Insert values into EmployeeDetail table--
Insert into EmployeeDetail(EmpID,Project,EmpPosition,DOJ)
Values
(1,'P1','Executive','2019-01-26'),
(2,'P2','Executive','2020-05-04'),
(3,'P1','Lead','2021-10-21'),
(4,'P3','Manager','2019-11-29'),
(5,'P2','Manager','2020-08-01');

--Retrieve data--
Select * from EmployeeDetail

--Find the list of employees whose salary ranges between 2L to 3L--
Select EmpName,Salary from Employee
Where Salary BETWEEN 200000 AND 300000;

--Write a query to retrieve the list of employees from the same city--
/*
The Employee table is used twice by assigning two different aliases: E1 and E2.
This creates a self-join, where the table is joined with itself.
*/
Select E1.EmpID,E1.EmpName,E1.City from Employee E1,Employee E2
Where E1.City = E2.City And E1.EmpID != E2.EmpID

--Query to find the null values in the Employee table--
Select * from Employee
Where EmpID is null

--Query to find the cumulative sum of employee's salary--
Select EmpID, EmpName, Sum( Salary) over (order by EmpID) as Cumulativesumofsalary
From employee;

--What is the male and female employee ratio--
SELECT 
    (COUNT(CASE WHEN Gender = 'M' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0)) AS Male_Percentage,
    (COUNT(CASE WHEN Gender = 'F' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0)) AS Female_Percentage
FROM Employee
WHERE Gender IN ('M', 'F');

--Write query to fetch 50% records from the Employee table--
SELECT TOP 50 PERCENT * 
FROM Employee;

--Query to fetch the employee's Salary but replace the last 2 digits with 'xx'--
SELECT EmpID, EmpName, Salary, 
   CONCAT(LEFT(Salary, LEN(Salary) - 2), 'xx') AS Masked_Salary
FROM Employee;

--Write a query to fetch even and odd rows from Employee table--
WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmpID) AS RowNum
    FROM Employee
)
SELECT * FROM CTE WHERE RowNum % 2 = 0; -- Even rows

With CTE as( 
    Select *, Row_number () over(order by EmpID) as Rownum
	From employee
)
Select * from CTE where rownum % 2 = 1; --Odd rows

--Write a query to find all the Employee names whose name begin with 'A'--
SELECT EmpName 
FROM Employee 
WHERE EmpName LIKE 'A%';

--Write a query to find all the Employee names whose name contains 'A' alphabet at second place--
Select EmpName
From Employee
Where EmpName like '_A%';

--Write a query to find all the Employee names whose name contains 'K' alphabet at second last place--
select EmpName
From Employee
Where EmpName like '%k_';

--Write a query to find all the Employee names whose name ends with 'n' and contains 5 alphabets--
select EmpName
From Employee
Where EmpName like '____n';



