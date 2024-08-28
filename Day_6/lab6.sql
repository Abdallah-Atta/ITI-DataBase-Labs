USE DB_For_Lec6

--Create DataType

sp_addtype LocDT , 'nchar(2)';
GO
CREATE RULE r1 AS @x IN ('NY','DS','KW');
SP_BINDRULE r1,LocDT;
GO
CREATE DEFAULT d1 AS 'NY';
sp_bindefault d1,LocDT;

--1 Department

Create Table Department (
	DeptNo nchar(5) primary KEY,
	DeptName NVARCHAR(50) ,
	Location locDT
);

--2 Employee

CREATE TABLE Employee(
	EmpNo	INT,
	Fname	nchar(20),
	Lname	nchar(20),
	DeptNo	nchar(5),
	Salary	int,

	CONSTRAINT c1 PRIMARY KEY(EmpNo),
	CONSTRAINT c2 FOREIGN KEY(DeptNo) REFERENCES Department(DeptNo),
	CONSTRAINT c3 UNIQUE(Salary),
	CONSTRAINT c4 CHECK(Fname IS NOT NULL AND Lname IS NOT NULL),

);

CREATE RULE r2Salary AS @s < 6000;
GO
SP_BINDRULE r2Salary , 'Employee.Salary';

--3 project And Works_On Using Wizard


----------------------------------------------------
-- add data


insert into Department values
('d1', 'Research', 'NY'),
('d2', 'Accounting', 'DS'),
('d3', 'Markiting', 'KW');


insert into Employee values
(25348, 'Mathew', 'Smith', 'd3', 2500),
(10102, 'Ann', 'Jones', 'd3', 3000),
(18316,'John' ,'Barrimore','d1',2400),
(29346, 'James', 'James', 'd2' ,2800),
(2581,'Elisa' ,'Hansel', 'd2',3600),
(28559,'Sybl' ,'Moser' ,'d1' ,2900);


insert into Project values
('p1' ,'Apollo', 120000),
('p2' ,'Gemini', 95000),
('p3', 'Mercury', 185600);



insert into works_on values
(10102, 'p1' ,'Analyst' ,'2006.10.1'),
(10102, 'p3' ,'Manager' ,'2012.1.1'),
(25348 ,'p2' ,'Clerk' ,'2007.2.15');


--- Testing Referential Integrity

insert into works_on values
(11111, 'p1', 'name', '2004.10.5'); 


UPDATE Works_on
	SET EmpNO = 11111
	where EmpNo = 10102;


update Employee
	set EmpNo = 11111
	where EmpNo = 10102;


DELETE FROM Employee
WHERE EmpNo = 10102;



--- Table modification

ALTER TABLE Employee
ADD TelephoneNumber INT ;

ALTER TABLE Employee
DROP COLUMN TelephoneNumber ;


------------------------------------------- Create Schema

CREATE SCHEMA Company;

ALTER SCHEMA Company TRANSFER Department;

CREATE SCHEMA HR;

ALTER SCHEMA HR TRANSFER Employee;


------------------------------------------------

SELECT CONSTRAINT_SCHEMA,CONSTRAINT_TYPE 
FROM  information_schema.table_constraints
WHERE TABLE_NAME = 'Employee';


CREATE SYNONYM emp FOR Employee
CREATE SYNONYM emp2 FOR HR.Employee

Select * from Employee
Select * from HR.Employee
Select * from Emp
Select * from HR.Emp


Select * from Emp2


------------------------------------------------------
SELECT * FROM Company.Project p
SELECT * FROM Works_on wo

UPDATE Company.Project
SET Budget = Budget * 1.10
WHERE ProjectNo IN (
	SELECT ProjectNo 
	FROM Works_on
	WHERE EmpNo = 10102 AND Job LIKE 'M%r'
	)

SELECT * FROM Company.Project p

---------------------------------------------
SELECT * FROM HR.Employee e
SELECT * FROM Company.Department d


update Company.Department
set DeptName = 'Sales'
where DeptNo in (
select DeptNo
from HR.Employee e
where concat(e.Fname, ' ', e.Lname) = 'James works'
);
 
--------------------------------------------------------

update works_on
set Enter_Date = '12.12.2007'
where EmpNo in (
select EmpNo 
from Human_Resource.Employee e inner join Company.Department d
on e.DeptNo = d.DeptNo
where d.DeptNo = 'p1' and d.DeptName = 'Sales'
);

--------------------------------------------------------

delete works_on
where EmpNo in (
select EmpNo 
from Human_Resource.Employee e inner join Company.Department d
on e.DeptNo = d.DeptNo
where d.Location = 'KW' 
);