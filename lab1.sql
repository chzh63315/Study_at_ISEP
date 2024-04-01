/*
CREATE TABLE DEPT
       (DEPTNO integer constraint pk_dept primary key,
        DNAME VARCHAR(14),
        LOC VARCHAR(13) );
 
 
CREATE TABLE EMP
       (EMPNO integer constraint pk_emp primary key,
        ENAME VARCHAR(10),
        EFIRST VARCHAR(10),
        JOB VARCHAR(9),
        MGR integer not null,
        HIREDATE DATE,
        SAL integer constraint ck_sal check (SAL>=0),
        COMM integer,
        TEL char(10),
        DEPTNO integer,
        constraint fk_emp_dept foreign key(DEPTNO) references DEPT (DEPTNO));
        
CREATE TABLE DEPENDENTS
       (DNO integer,
        DNAME VARCHAR(10),
        DFIRST VARCHAR(10),
		EMPNO integer,
		constraint pk_dependent primary key (DNO, EMPNO),
        constraint fk_dependent_emp foreign key(EMPNO) references EMP (EMPNO));
        
        
CREATE TABLE BONUS
       (ENAME VARCHAR(10),
        JOB   VARCHAR(9),
        SAL   integer,
        COMM  integer);
 
CREATE TABLE SALGRADE
        (GRADE integer,
         LOSAL integer,
         HISAL integer);


-- Q3 --
ALTER TABLE emp
ADD CONSTRAINT unique_emp UNIQUE (ename, efirst, tel);

-- Q4 --
ALTER TABLE emp
ADD CONSTRAINT checkTel
CHECK (tel LIKE '01%');

-- Q5 --
ALTER TABLE dependents
DROP CONSTRAINT fk_dependent_emp;

ALTER TABLE dependents
ADD CONSTRAINT fk_dependent_emp
FOREIGN KEY (empno)
REFERENCES EMP
ON DELETE CASCADE;

-- Q6 --
ALTER TABLE emp
ALTER COLUMN mgr DROP NOT NULL;

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


INSERT INTO EMP VALUES
        (7369, 'SMITH', 'JOHN', 'CLERK',     7902,
        TO_DATE('17-12-1980', 'DD-MM-YYYY'),  800, NULL,'0149545243', 20);
INSERT INTO EMP VALUES
        (7499, 'ALLEN', 'BOB', 'SALESMAN',  7698,
        TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600,  300, '0149547243',30);
INSERT INTO EMP VALUES
        (7521, 'WARD',  'PETER', 'SALESMAN',  7698,
        TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250,  500, '0149545247',30);
INSERT INTO EMP VALUES
        (7566, 'JONES', 'JOHN', 'MANAGER',   7839,
        TO_DATE('2-04-1981', 'DD-MM-YYYY'),  2975, NULL, '0149545456',20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN', 'JOE','SALESMAN',  7698,
        TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, '0149545784',30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE', 'BOB', 'MANAGER',   7839,
        TO_DATE('1-05-1981', 'DD-MM-YYYY'),  2850, NULL,'0149545254', 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK', 'JOHN', 'MANAGER',   7839,
        TO_DATE('9-06-1981', 'DD-MM-YYYY'),  2450, NULL, '0149545245',10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT', 'GUY', 'ANALYST',   7566,
        TO_DATE('09-12-1982', 'DD-MM-YYYY'), 3000, NULL,'0149545249', 20);
INSERT INTO EMP VALUES
        (7839, 'KING', 'GUY',  'PRESIDENT', NULL,
        TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, '0149545241',10);
INSERT INTO EMP VALUES
        (7844, 'TURNER','PETER', 'SALESMAN',  7698,
        TO_DATE('8-09-1981', 'DD-MM-YYYY'),  1500,    0, '0149548243',30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS', 'JOSEPH', 'CLERK',     7788,
        TO_DATE('12-01-1983', 'DD-MM-YYYY'), 1100, NULL,'0149565243', 20);
INSERT INTO EMP VALUES
        (7900, 'JAMES', 'ALAN', 'CLERK',     7698,
        TO_DATE('3-12-1981', 'DD-MM-YYYY'),   950, NULL, '0149545564',30);
INSERT INTO EMP VALUES
        (7902, 'FORD',  'MARIA', 'ANALYST',   7566,
        TO_DATE('3-12-1981', 'DD-MM-YYYY'),  3000, NULL,'0149785243', 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER', 'ALICE','CLERK',     7782,
        TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, '0199545243',10); 

INSERT INTO SALGRADE VALUES (1,  700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

-- Q7 --
CREATE SEQUENCE sequencdep
START WITH 8000
INCREMENT BY 2;

-- Q8 --
INSERT INTO dependents VALUES (nextval('sequencdep'),'xxx','yyy',7654);
SELECT * FROM dependents;


-- EX2 --
select table_name from information_schema.tables where table_schema ='pulic';
select * from emp where comm  > sal;

select empno,ename,efirst,(sal + comm) as EARNIG
from emp
where (sal + comm ) between 1200 and 2400 ;


select * from emp where job in ('CLERL','ANALYST');

select * from emp where ename like 'M%';

select ename,efirst from emp where ename like '_L%';

select * from dept where 
deptno not in (select deptno from emp);

-- E2Q13 --
select * from emp
where sal > (select sal from emp where ename = 'jones');

-- E2Q17 --
select e.* from EMP e
left outer join EMP b on e.MGR = b.EMPNO
where e.deptno <> b.deptno;

-- E2Q18 --
select * from emp 
where DEPTNO in (select  DEPTNO
				 from DEPT 
				 where job like 'CLERK' 
				 group by DEPTNO 
				having count(*)>=1);
				
-- E2Q21 --

select * from emp
where sal > all (select sal from EMP where DEPTNO=20);

SELECT e.EMPNO, e.ENAME as EmployeeName, m.ENAME as ManagerName
FROM EMP e
JOIN EMP m ON e.MGR = m.EMPNO;

SELECT E.EMPNO, E.ENAME, E.SAL
FROM EMP E, (SELECT SAL FROM EMP WHERE ENAME = 'JONES') JONES_SAL
WHERE E.SAL > JONES_SAL.SAL;

SELECT EMPNO, ENAME, COALESCE(SAL, 0) + COALESCE(COMM, 0) AS TotalCompensation
FROM EMP;


SELECT EMPNO, ENAME, 
CONCAT(COALESCE(SAL, 0), ' / ', COALESCE(COMM, 0)) AS SalaryAndComm
FROM EMP;

SELECT DISTINCT E.DEPTNO
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;


SELECT E.EMPNO, E.ENAME, E.JOB
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.LOC = 'CHICAGO'
AND E.JOB = (
    SELECT JOB 
    FROM EMP 
    WHERE ENAME = 'JONES'
);



select * from emp 
where DEPTNO in (select  DEPTNO
				 from DEPT 
				 where job like 'CLERK' 
				 group by DEPTNO 
				having count(*)>=1);
				
	
				
SELECT e.EMPNO, e.ENAME, e.JOB
FROM EMP e
WHERE e.DEPTNO = 10
AND e.JOB IN (
    SELECT DISTINCT e2.JOB
    FROM EMP e2
    JOIN DEPT d ON e2.DEPTNO = d.DEPTNO
    WHERE d.DNAME = 'SALES'
);



SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
FROM EMP E
WHERE E.JOB = (
    SELECT JOB
    FROM EMP
    WHERE ENAME = 'JONES'
)
OR E.SAL > (
    SELECT SAL
    FROM EMP
    WHERE ENAME = 'FORD'
);


select * from emp
where sal > all (select sal from EMP where DEPTNO=20);	



CREATE TABLE project (
  projno VARCHAR(10) PRIMARY KEY,
  pname VARCHAR(50),
  startdate DATE,
  budget DECIMAL(10, 2)
);


CREATE TABLE project_emp (
  empno INTEGER,
  projno VARCHAR(10),
  PRIMARY KEY (empno, projno),
  FOREIGN KEY (empno) REFERENCES EMP (EMPNO),
  FOREIGN KEY (projno) REFERENCES project (projno)
);

select * from emp

INSERT INTO project (projno, pname, startdate, budget) VALUES ('1', 'Project A', '2021-01-01', 100000);
INSERT INTO project (projno, pname, startdate, budget) VALUES ('2', 'Project B', '2021-02-01', 150000);
INSERT INTO project (projno, pname, startdate, budget) VALUES ('3', 'Project C', '2021-03-01', 200000);
INSERT INTO project (projno, pname, startdate, budget) VALUES ('4', 'Project D', '2021-04-01', 250000);

INSERT INTO project_emp (empno, projno) VALUES (7369, '1');
INSERT INTO project_emp (empno, projno) VALUES (7499, '2');
INSERT INTO project_emp (empno, projno) VALUES (7788, '3');
INSERT INTO project_emp (empno, projno) VALUES (7369, '4');
INSERT INTO project_emp (empno, projno) VALUES (7499, '1');
INSERT INTO project_emp (empno, projno) VALUES (7788, '2');
INSERT INTO project_emp (empno, projno) VALUES (7369, '3');
INSERT INTO project_emp (empno, projno) VALUES (7788, '4');
INSERT INTO project_emp (empno, projno) VALUES (7566, '1');
INSERT INTO project_emp (empno, projno) VALUES (7566, '2');
INSERT INTO project_emp (empno, projno) VALUES (7566, '3');
INSERT INTO project_emp (empno, projno) VALUES (7566, '4');
INSERT INTO project_emp (empno, projno) VALUES (7521, '1');
INSERT INTO project_emp (empno, projno) VALUES (7521, '2');
INSERT INTO project_emp (empno, projno) VALUES (7521, '3');
INSERT INTO project_emp (empno, projno) VALUES (7521, '4');
INSERT INTO project_emp (empno, projno) VALUES (7900, '1');
INSERT INTO project_emp (empno, projno) VALUES (7900, '2');
INSERT INTO project_emp (empno, projno) VALUES (7900, '3');
INSERT INTO project_emp (empno, projno) VALUES (7900, '4');


SELECT empno
FROM project_emp
GROUP BY empno
HAVING COUNT(DISTINCT projno) = (SELECT COUNT(*) FROM project);\



CREATE VIEW sales_staff AS
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10 WITH CHECK OPTION
 

SELECT empno, COUNT(projno) AS NumberOfProjects
FROM project_emp
GROUP BY empno
HAVING COUNT(projno) >= 2;



SELECT empno
FROM project_emp
WHERE projno = '1'
INTERSECT
SELECT empno
FROM project_emp
WHERE projno = '2';

SELECT * FROM EMP

INSERT INTO project_emp (empno, projno) VALUES (7902, '3');

SELECT empno
FROM project_emp
WHERE projno = '3'
EXCEPT
SELECT empno
FROM project_emp
WHERE projno = '4';


WITH RankedSalaries AS (
    SELECT pe.projno, pe.empno, e.sal,
           ROW_NUMBER() OVER (PARTITION BY pe.projno ORDER BY e.sal DESC) as rank
    FROM project_emp pe
    JOIN EMP e ON pe.empno = e.empno
)
SELECT projno, empno, sal
FROM RankedSalaries
WHERE rank <= 3;


SELECT 
    pe.empno,
    (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) AS project_percentage
FROM 
    project_emp pe
GROUP BY 
    pe.empno;

*/

SELECT 
    pe.empno,
    (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) AS project_percentage,
    CASE
        WHEN COUNT(pe.projno) = 0 THEN 'Empty'
        WHEN (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) BETWEEN 1 AND 50 THEN 'Small'
        WHEN (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) BETWEEN 51 AND 80 THEN 'Medium'
        WHEN (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) BETWEEN 81 AND 99 THEN 'Large'
        WHEN (COUNT(pe.projno) * 100.0 / (SELECT COUNT(*) FROM project)) = 100 THEN 'Total'
        ELSE 'Undefined'
    END AS scope_size
FROM 
    project_emp pe
GROUP BY 
    pe.empno;







