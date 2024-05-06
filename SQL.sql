-- 3.Fetch Employee Details and Department:
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

-- 4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: less than two
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;

--4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: greater than four
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;

--4. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: between two and four
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4;

--5.Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

--6.Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
SELECT E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, 
       (SELECT COUNT(*) FROM emp_record_table E2 WHERE E2.MANAGER_ID = E1.EMP_ID) AS REPORTERS_COUNT
FROM emp_record_table E1
WHERE E1.MANAGER_ID IS NOT NULL;

--7. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'Healthcare'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'Finance';

--8.Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.
SELECT E.EMP_ID, E.FIRST_NAME, E.LAST_NAME, E.ROLE, E.DEPT, E.EMP_RATING, MAX(DISTINCT E2.EMP_RATING) AS MAX_EMP_RATING
FROM emp_record_table E
JOIN emp_record_table E2 ON E.DEPT = E2.DEPT
GROUP BY E.DEPT, E.EMP_ID, E.FIRST_NAME, E.LAST_NAME, E.ROLE, E.EMP_RATING

--9.Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
SELECT ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE;

--10 Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
       CASE
           WHEN EXP <= 2 THEN 'Junior'
           WHEN EXP <= 5 THEN 'Associate'
           WHEN EXP <= 10 THEN 'Senior'
           WHEN EXP <= 12 THEN 'Lead'
           ELSE 'Manager'
       END AS Experience_Rank
FROM emp_record_table;

--11. Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
CREATE VIEW high_salary_employees  AS 
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

-- Selecting data from View - high_salary_employees
SELECT *
FROM high_salary_employees 

--12. Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP > (SELECT 10);

--13. Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.\
USE employee; 
GO

CREATE PROCEDURE GetExperiencedEmployees
AS
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
    FROM emp_record_table
    WHERE EXP > 3;
END;

--Executing store Procedure
EXEC GetExperiencedEmployees;

--14. Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
USE employee
GO

CREATE FUNCTION GetAssignedJobProfile(@experience INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @jobProfile NVARCHAR(50);

    IF @experience <= 2
        SET @jobProfile = 'JUNIOR DATA SCIENTIST';
    ELSE IF @experience <= 5
        SET @jobProfile = 'ASSOCIATE DATA SCIENTIST';
    ELSE IF @experience <= 10
        SET @jobProfile = 'SENIOR DATA SCIENTIST';
    ELSE IF @experience <= 12
        SET @jobProfile = 'LEAD DATA SCIENTIST';
    ELSE
        SET @jobProfile = 'MANAGER';

    RETURN @jobProfile;
END;
GO

--15. Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
USE employee; -- Replace with your actual database name
GO
CREATE NONCLUSTERED INDEX IX_Employee_FirstName    -- Create an index on the FIRST_NAME column
ON emp_record_table (FIRST_NAME);

--16. Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
USE employee; 
GO
SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING,
       0.05 * SALARY * EMP_RATING AS BONUS
FROM emp_record_table;

--17. Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;
















