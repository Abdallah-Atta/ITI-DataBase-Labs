USE ITI

--1
SELECT * FROM Student s
SELECT * FROM Stud_Course sc
SELECT * FROM Course c

CREATE VIEW	Students_case
AS
	SELECT s.St_Fname + ' ' + s.St_Lname AS Full_Name , c.Crs_Name
	FROM Student s , Course c , Stud_Course sc
	WHERE sc.St_Id = s.St_Id AND sc.Crs_Id = c.Crs_Id AND sc.Grade > 50 ;

SELECT * FROM Students_case sc


----------------------------------------------------
--2
CREATE VIEW Instructor$Topic
WITH ENCRYPTION
AS
	SELECT i.Ins_Name , T.Top_Name
	FROM 
	Instructor i INNER JOIN Department d ON d.Dept_Manager = i.Ins_Id 
	INNER JOIN Ins_Course ic ON ic.Ins_Id = i.Ins_Id
	INNER JOIN Course c ON ic.Crs_Id = c.Crs_Id
	INNER JOIN Topic t ON c.Top_Id = t.Top_Id


SELECT * FROM Instructor$Topic it


----------------------------------------------------
--3
CREATE VIEW Java_SD_Inst
AS	
	SELECT i.Ins_Name,d.Dept_Name
	FROM Instructor i , Department d
	WHERE D.Dept_Manager = i.Ins_Id AND d.Dept_Name IN ('Java','SD')

SELECT * FROM Java_SD_Inst jsi


----------------------------------------------------
--4
CREATE VIEW V1
AS
	SELECT * FROM Student s
	WHERE s.St_Address IN ('Cairo','Alex')
WITH CHECK OPTION

SELECT * FROM V1 v

Update V1 set st_address='tanta'    --Erorr
Where st_address='alex';		--Erorr


----------------------------------------------------
--5
CREATE VIEW Employee_Project
AS
	SELECT P.Pname,Count(e.Fname) AS 'Nof employees work on'
	FROM 
	Project p INNER JOIN Works_for wf ON wf.Pno = P.Pnumber
	INNER JOIN Employee e ON wf.ESSn = e.SSN
	GROUP BY Pname

SELECT * FROM Employee_Project ep


----------------------------------------------------
--6

CREATE CLUSTERED INDEX hiredate_i
ON Department(Manager_hiredate)   --Error: The table already contains a primary key, which has a clustered index by defaulta and only one clustered index is allowed.


----------------------------------------------------
--7
CREATE UNIQUE INDEX Age_i
ON Student(St_Age)


----------------------------------------------------
--8
create table d_trans (user_id int, tamount int)
create table L_trans (user_id int, tamount int)
insert into d_trans values (1,1000),(2,2000),(3,1000),(1,5000)
insert into L_trans values (1,4000),(4,2000),(2,10000)
SELECT * FROM d_trans dt
SELECT * FROM L_trans lt


MERGE INTO L_trans AS L
USING d_trans AS D
ON L.user_id = D.user_id
WHEN MATCHED AND L.tamount < D.tamount THEN
	UPDATE 
		SET	L.tamount = D.tamount
WHEN NOT MATCHED BY TARGET THEN 
	INSERT
		VALUES(D.USER_ID,D.tamount);
-- WHEN NOT MATCHED BY SOURCE THEN

SELECT * FROM L_trans









