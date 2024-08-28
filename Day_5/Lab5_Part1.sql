Use ITI

--1
SELECT count(1) As Num_of_Student
From ITI.dbo.Student
Where St_Age is not null ;

--2
Select distinct(Ins_Name)
From Instructor

--3
Select isnull(s.St_Id,'') As 'Student ID' , isnull(s.St_Fname,'')+' '+isnull(s.St_Lname,'') As 'Student Full Name' , d.Dept_Name As 'Department name'
from Student s join Department d
	on s.Dept_Id = d.Dept_Id

--4
select i.Ins_Name , d.Dept_Name
from Instructor i left join Department d
	on i.Dept_Id = d.Dept_Id

--5
select s.St_Fname + ' ' + s.St_Lname As 'full name' , c.Crs_Name
from Student s 
	inner join Stud_Course sc
	on s.St_Id = sc.St_Id
	inner join Course c
	on c.Crs_Id = sc.Crs_Id
where sc.Grade <> 0 ;


--6
select COUNT(c.Crs_Id) AS number_of_courses , t.Top_Name
from Course c inner join Topic t
	on c.Top_Id = t.Top_Id
group by t.Top_Name

--7
Select MAX(Salary) AS Max_Salary , MIN(Salary) AS Min_Salary	
from Instructor

--8
Select *
from Instructor
Where Salary > (Select AVG(Salary) from Instructor)

--9
Select d.Dept_Name , d.Dept_Desc
from Department d join Instructor i
	on i.Ins_Id = d.Dept_Manager

--10
Select top(2) *
From Instructor
Order by Salary desc

--11
select ISNULL(salary,Dept_Id)
from Instructor

--12
Select AVG(salary)
from Instructor

--13
select s1.St_Fname, s2.* 
from Student s1 left join Student s2
	on s2.St_Id = s1.St_super

--14
Select *
from(
select * , Dense_rank() Over(partition by Dept_id Order by Salary desc) AS dr 
from Instructor ) As Derive_Table
Where dr <= 2

--15

Select *
from(
select * , ROW_NUMBER() Over(partition by Dept_id Order by Newid() ) as rw
from Student) As Derive_Table
Where rw = 1 ;


