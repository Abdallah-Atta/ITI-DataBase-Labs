--1
SELECT * FROM Student s ;
SELECT * FROM Department d ;

CREATE PROC stu_per_dep
AS
	SELECT d.Dept_Name , Count(s.St_Id) AS Number_of_St
	FROM Student s INNER JOIN Department d
	ON s.Dept_Id = D.Dept_Id 
	GROUP BY D.Dept_Name

stu_per_dep
EXECUTE stu_per_dep
EXEC stu_per_dep


-----------------------------------------------------------------
--2
USE Company_Sd

SELECT * FROM Employee e
SELECT * FROM Works_for wf
SELECT * FROM Project p

CREATE PROC check_Emp_num 
AS
	DECLARE @empnum INT
	SELECT @empnum = Count(e.SSN)
	FROM Employee e , Works_for wf
	WHERE e.SSN = wf.ESSn AND wf.Pno = 100 
	IF @empnum >= 3
		BEGIN
			select 'The number of employees in the project p1 is 3 or more'
		END
	ELSE
		BEGIN
			select 'The following employees work for the project p1' as result, e.Fname,e.Lname
			from Employee e, Works_for w
			where e.SSN=w.ESSn and w.Pno=100
		END

check_Emp_num 


-----------------------------------------------------------------
--3


/*
	SELECT P.Pname , Coun
	FROM Employee e INNER JOIN Works_for wf ON e.SSN = wf.ESSn
		INNER JOIN Project p ON wf.Pno = p.Pnumber
	GROUP BY P.Pname
	e.Fname,e.SSN,wf.ESSn,wf.Pno,P.Pnumber,
*/