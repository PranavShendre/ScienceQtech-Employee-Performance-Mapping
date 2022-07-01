 CREATE DATABASE  employee;
 
-- Task 3
SELECT 
	EMP_ID,
	FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT
FROM emp_record_table;

-- Task 4
-- EMP_RATING less than 2
SELECT 
	EMP_ID,
	FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;

-- EMP_RATING greater than 4
SELECT 
	EMP_ID,
	FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;

-- between two and four
SELECT 
	EMP_ID,
	FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4;

-- Task 5
SELECT 
	CONCAT(FIRST_NAME,' ', LAST_NAME) AS NAME,
    DEPT    
FROM emp_record_table
WHERE DEPT = 'FINANCE';

-- Task 6
-- Write a query to list only those employees who have someone reporting to them. 
-- Also, show the number of reporters (including the President).
SELECT 
	employee.EMP_ID,
	CONCAT(employee.FIRST_NAME, ' ',employee.LAST_NAME) AS Employee_Name,
    manager.MANAGER_ID,
    CONCAT(manager.FIRST_NAME, ' ',manager.LAST_NAME) AS Manager_Name,
    manager.ROLE AS ROLE
FROM  emp_record_table  employee
JOIN emp_record_table  manager
ON employee.MANAGER_ID = manager.EMP_ID;
      
-- Task 7
-- 6.	Write a query to list down all the employees from the healthcare and finance departments 
-- using union. Take data from the employee record table.
SELECT 
	EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    DEPT AS Department
FROM  emp_record_table
WHERE DEPT = 'HEALTHCARE'
UNION
SELECT 
	EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    DEPT AS Department
FROM  emp_record_table
WHERE DEPT = 'FINANCE';
    
-- Task 8
-- Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, 
-- and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp 
-- rating for the department.
SELECT 
	EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    ROLE, 
    DEPT, 
	MAX(EMP_RATING)
FROM   emp_record_table  
GROUP BY DEPT;

-- Task 9
-- Write a query to calculate the minimum and the maximum salary of the employees in each role. 
-- Take data from the employee record table.

SELECT 
    ROLE,
    MIN(SALARY) AS Min_Sal,
    MAX(SALARY) AS Max_Sal
FROM emp_record_table
GROUP BY ROLE;

-- Task 10 
-- Write a query to assign ranks to each employee based on their experience.
-- Take data from the employee record table.
SELECT 
	EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EXP,
    ROW_NUMBER() OVER (ORDER BY EXP DESC) AS Ranking
FROM emp_record_table ;
 
-- Task 11
-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand.
-- Take data from the employee record table.
CREATE VIEW employee_sal AS
SELECT EMP_ID,
	FIRST_NAME,
	LAST_NAME,
    COUNTRY,
    SALARY
FROM emp_record_table
WHERE SALARY > 6000;

-- Task 12
-- Write a nested query to find employees with experience of more than ten years. 
-- Take data from the employee record table.
SELECT 
	EMP_ID,
	FIRST_NAME,
    LAST_NAME,
    EXP
FROM  emp_record_table
WHERE EMP_ID IN 
		(SELECT EMP_ID
        FROM emp_record_table
        WHERE EXP > 10);
    
-- Task 13
-- Write a query to create a stored procedure to retrieve the details of the employees 
-- whose experience is more than three years. 
-- Take data from the employee record table.
DELIMITER $$
CREATE PROCEDURE  get_employee_exp()
BEGIN
SELECT * FROM emp_record_table WHERE EXP > 3;
END$$
DELIMITER;
CALL get_employee_exp();

-- Task 14
/*Write a query using stored functions in the project table to check whether 
-- the job profile assigned to each employee in the data science team matches 
-- the organization’s set standard.
-- The standard being:
-- For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
-- For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
-- For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
-- For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
-- For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/
DELIMITER $$
CREATE FUNCTION employee_job_profile(EXP int)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE employee_job_profile VARCHAR(50);
    IF EXP <= 2 THEN 
		SET employee_job_profile = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP BETWEEN 2 AND 5 THEN
		SET employee_job_profile = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP BETWEEN 5 AND 10 THEN
		SET employee_job_profile = 'SENIOR DATA SCIENTIST'; 
	ELSEIF EXP BETWEEN 10 AND 12 THEN
		SET employee_job_profile = 'LEAD DATA SCIENTIST'; 		
	ELSEIF EXP BETWEEN 12 AND 16 THEN
		SET employee_job_profile = 'MANAGER'; 
    END IF;
    RETURN (employee_job_profile);
END$$  

SELECT EMP_ID, FIRST_NAME, EXP, employee_job_profile(EXP)
FROM emp_record_table;

-- Task 15
-- Create an index to improve the cost and performance of the query to 
-- find the employee whose FIRST_NAME is ‘Eric’ in the employee table 
-- after checking the execution plan.
CREATE INDEX idx_first_name ON emp_record_table(FIRST_NAME);
EXPLAIN SELECT EMP_ID, FIRST_NAME, LAST_NAME 
FROM emp_record_table 
WHERE  FIRST_NAME = 'Eric';

-- Task 16
-- Write a query to calculate the bonus for all the employees, 
-- based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
SELECT EMP_ID, FIRST_NAME, LAST_NAME,
    ROLE, DEPT, EXP, SALARY, EMP_RATING, 
    (0.05 * SALARY)*EMP_RATING AS Bonus
FROM emp_record_table;
    




-- Task 17
-- Write a query to calculate the average salary distribution based on the continent and country.
-- Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME,LAST_NAME, COUNTRY,CONTINENT, AVG(SALARY)
FROM emp_record_table
GROUP BY CONTINENT,COUNTRY;

SELECT * FROM employee.emp_record_table;

















