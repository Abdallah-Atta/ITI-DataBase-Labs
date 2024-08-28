-- 1)
Select *
From Employee

-- 2)
Select Fname,Lname,Salary,Dno
From Employee

-- 3)
Select Pname,Plocation,Dnum
From Project

-- 4)
Select concat(Fname,' ',Lname) As [full name] , (Salary*12*0.1) As [ANNUAL COMM]
From Employee

-- 5)
Select SSN , Fname ,salary
From Employee
Where Salary > 1000 

-- 6)
Select SSN , Fname ,(salary*12) As Annual_salary
From Employee
Where (Salary*12) > 10000 

-- 7)
Select  Fname ,salary
From Employee
Where Sex like 'F'

-- 8)
Select Dnum , Dname
From Departments
Where MGRSSN = 968574;

-- 9)
Select Pnumber,Pname , Plocation  
From Project
Where Dnum = 10 ;