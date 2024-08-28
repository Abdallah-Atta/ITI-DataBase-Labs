--1
CREATE FUNCTION GETMON_FRM_DATE(@d DATE)
RETURNS varchar(15)
BEGIN
	DECLARE @N_of_mon VARCHAR(15)
	SELECT @N_of_mon = DATENAME(MONTH, @d)
	RETURN @N_of_mon
END

SELECT dbo.GETMON_FRM_DATE('09/05/2004');


-------------------------------------------------------------
--2

CREATE FUNCTION GETVALUES_BETWEEN_INTS(@x INT,@y INT)
RETURNS @t TABLE
	(
		Numbers INT
	)
AS 
BEGIN
	IF @x < @y
		BEGIN
		WHILE @x <= @y
			BEGIN
			INSERT INTO @t(Numbers)
			VALUES (@x)
			SET @x+=1;
			END
		END
	ELSE IF @y < @x
		BEGIN
		WHILE @y <= @x
			BEGIN
			INSERT INTO @t(Numbers)
			VALUES (@y)
			SET @y+=1;
			END
		END
	RETURN 
END

SELECT * FROM dbo.GETVALUES_BETWEEN_INTS(5,10)


-------------------------------------------------------------
--3

CREATE FUNCTION studentInfo(@id int)
RETURNS TABLE
AS
	RETURN
		(
			SELECT s.St_Fname + ' ' +s.St_Lname AS Full_Name , D.Dept_Name
			FROM Student s , Department d 
			WHERE D.Dept_Id = s.Dept_Id AND s.St_Id = @id
		)

SELECT * FROM dbo.studentInfo(1);


-------------------------------------------------------------
--4

CREATE FUNCTION StudentNameStatus(@id int)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @firstName varchar(50), @lastName varchar(50), @result varchar(50)

	SELECT @firstName = s.St_Fname , @lastName = s.St_Lname
	FROM Student s
	WHERE s.St_Id = @id

	SELECT @result = CASE 
			WHEN @firstName IS NULL AND @lastName IS NULL THEN 'First name & last name are null'
			WHEN @firstName IS NULL AND @lastName IS NOT NULL THEN 'First name is null'
	       	WHEN @firstName IS NOT NULL AND @lastName IS NULL THEN 'Last name is null'
            ELSE 'First name & last name are not null'
    END
	RETURN @result
END

SELECT	dbo.StudentNameStatus(1);


-------------------------------------------------------------
--5

SELECT * FROM Department d
SELECT * FROM Instructor i

CREATE FUNCTION GetManagerDetails(@id INT)
RETURNS TABLE 
AS
	RETURN
	(
		SELECT D.Dept_Name , D.Manager_hiredate , i.Ins_Name AS Manager_Name
		FROM Department d INNER JOIN Instructor i
		ON D.Dept_Manager = i.Ins_Id
		WHERE D.Dept_Manager = @id
	)

SELECT * FROM dbo.GetManagerDetails(1)


-------------------------------------------------------------
--6

CREATE FUNCTION CheckStudentName(@inputText varchar(20))
RETURNS @res TABLE (Result varchar(30))
AS
BEGIN
	IF @inputText = 'first name'
		INSERT INTO @res
		SELECT ISNULL(St_Fname, 'First Name is Null') FROM Student
	ELSE IF @inputText = 'last name'
		INSERT INTO @res
		SELECT ISNULL(St_Lname, 'Last Name is Null') FROM Student
	ELSE IF @inputText = 'full name'
		INSERT INTO @res
		SELECT CONCAT(St_Fname, ' ', St_Lname) FROM Student

	RETURN
END

SELECT * FROM CheckStudentName('first name');
SELECT * FROM CheckStudentName('last name');
SELECT * FROM CheckStudentName('full name');


-------------------------------------------------------------
--7
--Write a query that returns the Student No and Student first name without the last char

SELECT s.St_Id , Left(s.St_Fname,LEN(s.St_Fname)-1)
FROM Student s


-------------------------------------------------------------
--8

USE Company_SD
GO
CREATE OR ALTER FUNCTION GetAllEmployeesInProject(@projectNumber int)
RETURNS TABLE
AS
RETURN
(
	SELECT e.*
	FROM Employee e LEFT OUTER JOIN Works_for w ON w.ESSn = e.SSN
	INNER JOIN Project p ON p.Pnumber = w.Pno
	WHERE p.Pnumber = @projectNumber
)

SELECT * FROM GetAllEmployeesInProject(100);

