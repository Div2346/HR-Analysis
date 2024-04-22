/* 
Divyanshi Sharma
Registration number: 12109922
*/

use hr;
show tables;
-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments

SELECT locations.location_id, locations.street_address, locations.city, locations.state_province, countries.country_name
FROM departments
JOIN locations ON departments.location_id = locations.location_id
JOIN countries ON locations.country_id = countries.country_id;

-- 2. Write a query to find the name (first_name, last name), department ID and name of all the employees

SELECT employees.first_name, employees.last_name, departments.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id;

-- 3. Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London

SELECT employees.first_name, employees.last_name, employees.job_id, departments.department_id, departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
JOIN locations ON departments.location_id = locations.location_id
JOIN countries ON locations.country_id = countries.country_id
WHERE locations.city = 'London';

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name)

SELECT employees.employee_id, employees.last_name AS employee_last_name, managers.manager_id, managers.last_name AS manager_last_name
FROM employees
JOIN employees managers ON employees.manager_id = managers.employee_id;

-- 5. Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date FROM employees WHERE last_name = 'Jones');

-- 6. Write a query to get the department name and number of employees in the department

SELECT departments.department_name, COUNT(*) AS num_of_employees
FROM employees
JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_name;

-- 7. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years

SELECT departments.department_name, managers.first_name || ' ' || managers.last_name AS manager_name, managers.hire_date AS manager_hire_date, managers.salary AS manager_salary
FROM employees managers
JOIN departments ON managers.department_id = departments.department_id
WHERE managers.employee_id IN (
    SELECT DISTINCT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id
    HAVING (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date)) > 15 OR ((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM hire_date)) = 15 AND EXTRACT(MONTH FROM SYSDATE) >= EXTRACT(MONTH FROM hire_date))
);

-- 8. Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Bull'
);

-- 9. Write a query to find the name (first_name, last_name) of all employees who works in the IT department

SELECT first_name, last_name
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- 10. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department

SELECT first_name, last_name
FROM employees
WHERE manager_id IS NOT NULL AND department_id IN (
    SELECT department_id
    FROM departments
    WHERE country_id = 'US'
);

-- 11. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 12. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade

SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
    WHERE job_id = e.job_id
);

-- 13. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
) AND department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name LIKE '%IT%'
);

-- 14. Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.

SELECT first_name, last_name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

-- 15. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest 

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE job_id = 'SH_CLERK'
)
ORDER BY salary;


