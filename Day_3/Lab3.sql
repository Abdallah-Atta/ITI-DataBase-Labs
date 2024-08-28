-- 1)
Select D.Dnum ,D.Dname ,E.SSN ,E.Fname
From Departments D , Employee E
Where E.SSN = D.MGRSSN ;

Select D.Dnum ,D.Dname ,E.SSN ,E.Fname
From Departments D inner Join Employee E
ON E.SSN = D.MGRSSN ;

-- 2)
Select Dname , Pname
From Departments D , Project P
Where D.Dnum = p.Dnum ;

Select Dname , Pname
From Departments D inner join Project P
On D.Dnum = p.Dnum ;

-- 3)
Select E.Fname , Dp.*
From Employee E , Dependent Dp
Where E.SSN = Dp.ESSN;

Select E.Fname , Dp.*
From Employee E inner join Dependent Dp
On E.SSN = Dp.ESSN ;

----------------------
Select d.Dependent_name , d.Sex
From Dependent d , Employee e
Where e.SSN = d.ESSN  And d.Sex like 'F' And e.Sex like 'F' 
UNION
Select d.Dependent_name , d.Sex
From Dependent d , Employee e
Where e.SSN = d.ESSN And d.Sex like 'M' And e.Sex like 'M' ;


Select E.*
From Employee E , Departments D
Where E.SSN = D.MGRSSN ;

Select E.*
From Employee E inner join Departments D
On E.SSN = D.MGRSSN ;
---------------------------

-- 4)
Select Pnumber ,Pname ,Plocation 
From Project
Where City in ('cairo','alex')

-- 5)
Select *
From Project
Where Pname like 'a%';

-- 6)
Select *
From Employee 
Where Dno = 30 AND Salary Between 1000 and 2000;
	
-- 7)
Select e.Fname
From Employee e , Departments d , Project p
Where d.Dnum = e.Dno And d.Dnum = p.Dnum And d.Dnum = 10 And p.Pname like 'AL Rabwah'

Select E.Fname
From Employee E inner join Works_for W
	On E.SSN = W.ESSn 
inner join Project P
	On P.Pnumber = W.Pno
Where E.Dno = 10 AND W.Hours >= 10 AND P.Pname = 'AL Rabwah' ;

Select E.Fname
From Employee E , Project P , Works_for W
Where E.SSN = W.ESSn AND  W.Pno = P.Pnumber  AND E.Dno = 10 AND W.Hours >= 10 AND P.Pname = 'AL Rabwah';


-- 8)
Select e1.Fname 
From Employee e1 , Employee e2
Where  e2.Superssn = e1.SSN AND e2.fname like 'Kamel' and e2.lname like 'Mohamed';

Select e1.Fname 
From Employee e1 Inner join Employee e2
On  e2.Superssn = e1.SSN AND e2.fname like 'Kamel' and e2.lname like 'Mohamed';


-- 9)

SELECT 
    E.Fname + ' ' + E.Lname AS EmployeeName,
    P.Pname AS ProjectName
FROM 
    dbo.Employee E
JOIN 
    dbo.Works_for WF ON E.SSN = WF.ESSn
JOIN 
    dbo.Project P ON WF.Pno = P.Pnumber
ORDER BY 
    P.Pname;


-- 10)

SELECT 
    P.Pnumber AS ProjectNumber,
    D.Dname AS DepartmentName,
    M.Lname AS ManagerLastName,
    M.Address,
    M.Bdate AS ManagerBirthDate
FROM 
    dbo.Project P
JOIN 
    dbo.Departments D ON P.Dnum = D.Dnum
JOIN 
    dbo.Employee M ON D.MGRSSN = M.SSN
WHERE 
    P.City = 'Cairo';


-- 11)

SELECT 
    E.*
FROM 
    dbo.Employee E
WHERE 
    E.SSN IN (
        SELECT 
            D.MGRSSN
        FROM 
            dbo.Departments D
    );


-- 12)

SELECT 
    E.*,
    D.Dependent_name,
    D.Sex AS DependentSex,
    D.Bdate AS DependentBirthDate
FROM 
    dbo.Employee E
LEFT JOIN 
    dbo.Dependent D ON E.SSN = D.ESSN;

