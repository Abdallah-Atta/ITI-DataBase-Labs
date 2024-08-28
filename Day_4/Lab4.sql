-- 1)

Select d.Dependent_name , d.Sex
From Dependent d , Employee e
Where e.SSN = d.ESSN  And d.Sex like 'F' And e.Sex like 'F' 
UNION
Select d.Dependent_name , d.Sex
From Dependent d , Employee e
Where e.SSN = d.ESSN And d.Sex like 'M' And e.Sex like 'M' ;

-- 2)
Select p.Pnumber ,P.Pname ,SUM(W.Hours) As Total_hour
From Project P ,Works_for W
Where P.Pnumber = w.Pno 
Group by p.Pnumber,P.Pname


-- 3

Select d.*
From Departments d ,Employee e
Where d.Dnum = e.Dno And e.SSN in (Select MIN(SSN) From Employee )

SELECT d.*
FROM departments AS d
JOIN employee AS e ON d.dnum = e.dno
WHERE e.SSN = (SELECT MIN(SSN) FROM employee);



-- 4

Select e.Dno , MAX(e.Salary) As Max_Salary ,MIN(e.Salary) As Min_Salary ,AVG(e.Salary) As Avg_Salary
From Departments d , Employee e
Group By e.Dno 

Select e.Dno ,d.Dname , MAX(e.Salary) As Max_Salary ,MIN(e.Salary) As Min_Salary ,AVG(e.Salary) As Avg_Salary
From Departments d , Employee e
Where d.Dnum = e.Dno
Group By e.Dno , d.Dname 

Select e.Dno ,d.Dname , MAX(e.Salary) As Max_Salary ,MIN(e.Salary) As Min_Salary ,AVG(e.Salary) As Avg_Salary
From Departments d , Employee e
Where d.MGRSSN = e.SSN
Group By e.Dno , d.Dname

-- 5

Select Fname,Lname
From Employee e , Departments d
Where e.SSN = d.MGRSSN And SSN Not In  (select ESSN  from dependent)

-- 6)
Select d.Dnum,d.Dname , AVG(e.salary) As Avg_Salary ,Count(e.ssn) As No_Employees
From Departments d ,Employee e
Where d.Dnum = e.Dno
Group by d.Dnum,d.Dname 
Having AVG(e.salary) < (Select AVG(Salary) From Employee e)

-- 7)

SELECT 
    D.Dname AS DepartmentName,
    E.Fname + ' ' + E.Lname AS EmployeeName,
    P.Pname AS ProjectName
FROM 
    dbo.Employee E
JOIN 
    dbo.Departments D ON E.Dno = D.Dnum
JOIN 
    dbo.Works_for WF ON E.SSN = WF.ESSn
JOIN 
    dbo.Project P ON WF.Pno = P.Pnumber
ORDER BY 
    D.Dname, 
    E.Lname, 
    E.Fname;

-- 8)

SELECT 
    Salary
FROM 
    dbo.Employee
WHERE 
    Salary IN (
        SELECT DISTINCT TOP 2 Salary
        FROM dbo.Employee
        ORDER BY Salary DESC
    )
ORDER BY 
    Salary DESC;


-- 9)

SELECT 
    E.Fname + ' ' + E.Lname AS EmployeeName
FROM 
    dbo.Employee E
WHERE 
    EXISTS (
        SELECT 1
        FROM dbo.Dependent D
        WHERE E.Fname + ' ' + E.Lname = D.Dependent_name
    );

-- 10)

UPDATE 
    E
SET 
    E.Salary = E.Salary * 1.3
FROM 
    dbo.Employee E
JOIN 
    dbo.Works_for WF ON E.SSN = WF.ESSn
JOIN 
    dbo.Project P ON WF.Pno = P.Pnumber
WHERE 
    P.Pname = 'Al Rabwah';

-- 11)

SELECT 
    E.SSN AS EmployeeNumber,
    E.Fname + ' ' + E.Lname AS EmployeeName
FROM 
    dbo.Employee E
WHERE 
    EXISTS (
        SELECT 1
        FROM dbo.Dependent D
        WHERE E.SSN = D.ESSN
    );
































