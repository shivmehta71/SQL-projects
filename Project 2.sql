#SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- Creating employee Table
CREATE TABLE employee (
    empno INT NOT NULL AUTO_INCREMENT,
    ename VARCHAR(50),
    job VARCHAR(50) DEFAULT 'CLERK',
    mgr INT,
    hiredate DATE,
    sal FLOAT CHECK (sal >= 0),
    comm FLOAT,
    deptno INT,
    PRIMARY KEY (empno),
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

-- Creating dept Table
CREATE TABLE dept (
    deptno INT NOT NULL,
    dname VARCHAR(50),
    loc VARCHAR(50),
    PRIMARY KEY (deptno)
);

-- Inserting Values into the employee Table
INSERT INTO employee (empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES
(7369, 'SMITH', 'CLERK',7902, '1890-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1881-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01',2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566,'1987-04-19', 3000.00,NULL ,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL ,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00 ,30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100.00,NULL ,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL ,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL ,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL ,10);

SELECT*FROM employee;

-- Inserting Values into the dept Table
INSERT INTO dept VALUES
(10,'OPERATIONS','BOSTON'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'ACCOUNTING','NEW YORK');

SELECT*FROM dept;

-- Names and salary of the employee whose salary is greater than 1000
SELECT ename, sal 
FROM employee 
WHERE sal > 1000;

-- Details of the employees who have joined before end of September 81.
SELECT * FROM employee 
WHERE hiredate <= '1981-09-30';

-- Employee Names having I as second character.
SELECT * FROM employee 
WHERE ename LIKE '_I%';

-- Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns
SELECT ename, sal, (sal * 0.40) AS Allowances, (sal * 0.10) AS P_F, (sal + (sal * 0.40) + (sal * 0.10)) AS Net_Salary 
FROM employee;

-- Employee Names with designations who does not report to anybody
SELECT * FROM employee 
WHERE mgr IS NULL;

-- Empno, Ename and Salary in the ascending order of salary.
SELECT empno, ename, sal 
FROM employee 
ORDER BY sal ASC;

#9 How many jobs are available in the Organization ?
SELECT d.dname AS 'Department', COUNT(e.job) AS 'Number of Jobs'
FROM dept d
LEFT JOIN employee e ON d.deptno = e.deptno
GROUP BY d.dname;

-- Total payable salary of salesman category
SELECT job, SUM(sal) AS 'Total Payable Salary' 
FROM employee 
WHERE job = 'SALESMAN';

-- Average monthly salary for each job within each department   
SELECT d.dname, e.job, AVG(e.sal) AS 'Average Monthly Salary' 
FROM employee e 
INNER JOIN dept d 
ON e.deptno = d.deptno 
GROUP BY d.dname, e.job;

-- EMPNAME, SALARY and DEPTNAME in which the employee is working.
SELECT e.ename AS 'EMPNAME', e.sal AS 'SALARY', d.dname AS 'DEPTNAME' 
FROM employee e 
INNER JOIN dept d 
ON e.deptno = d.deptno;


-- Creating a job table
CREATE TABLE job 
(grade VARCHAR(25),
lowest_sal INT,
highest_sal INT);

-- Inserting Values into job table
INSERT INTO job VALUES
('A',0,999),
('B',1000,1999),
('C',2000,2999),
('D',3000,3999),
('E',4000,5000);

-- Name, salary and  Corresponding Grade.
SELECT ename, sal,
       CASE 
         WHEN sal >= 0 AND sal < 1000 THEN 'A'
         WHEN sal >= 1000 AND sal < 2000 THEN 'B'
         WHEN sal >= 2000 AND sal < 3000 THEN 'C'
         WHEN sal >= 3000 AND sal < 4000 THEN 'D'
         ELSE 'E' 
       END AS grade
FROM employee;


-- Emp name and the Manager name under whom the Employee works 
SELECT e.ename AS 'EMP Name', m.ename AS 'Manager Name'
FROM employee e 
LEFT JOIN employee m 
ON e.mgr = m.empno;

-- Empname and Total sal where Total Sal (sal + Comm)
SELECT ename, (sal + IFNULL(comm, 0)) AS 'Total Salary' 
FROM employee;

-- Empname and Sal whose empno is a odd number
SELECT ename, sal 
FROM employee 
WHERE MOD(empno, 2) = 1;


-- Empname , Rank of sal in Organisation , Rank of Sal in their department
SELECT ename,
       RANK() OVER (ORDER BY sal DESC) AS 'Rank Organization',
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS 'Rank Department'
FROM employee;
    
-- Top 3 Empnames based on their Salary
SELECT ename, sal 
FROM employee 
ORDER BY sal DESC 
LIMIT 3;

-- Empname who has highest Salary in Each Department.
SELECT e.ename,d.dname,e.sal 
FROM employee e
LEFT JOIN dept d
ON e.deptno=d.deptno
WHERE e.sal IN (SELECT MAX(sal) 
				FROM employee 
                GROUP BY deptno )
LIMIT 3;

