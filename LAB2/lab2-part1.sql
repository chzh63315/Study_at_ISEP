/* 

SELECT
  empno,
  deptno,
  ename,
  sal,
  AVG(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS avg_neighbor_salary 
FROM EMP;


EXPLAIN SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by gender;



CREATE OR REPLACE PROCEDURE Exercicel(in_EMP_id NUMERIC)
language plpgsql
as $procedure$

DECLARE 
r_EMP EMP%ROWTYPE;

BEGIN 
	SELECT *
	INTO r_EMP
	FROM EMP 
	WHERE EMPNO = in_EMP_id;
	
	raise notice 'Employee No:% ,Employee Name :% ,Employee Salary : % ', r_EMP.EMPNO, r_EMP.ENAME, r_EMP.SAL;
	
	End;
	
	$procedure$
	



select * from(
select empno,efirst,hiredate,deptno,rank()
	over (PARTITION BY deptno ORDER BY hiredate DESC) 
	AS rank FROM emp
)WHERE rank <= 2;
	
WITH RankedEmployees AS (
  SELECT
    empno,
    ename,
    deptno,
    hiredate,
    ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY hiredate DESC) AS rank
  FROM emp
)
SELECT empno, ename, deptno, hiredate
FROM RankedEmployees
WHERE rank <= 2;



------------------------------------------
------------ Create Employee Table -------
------------------------------------------
CREATE TABLE EMP_MEDIUM_TABLE
       (EMPNO INTEGER,
        MANAGER_ID INTEGER,
        DEPT_ID VARCHAR(10),
        GENDER VARCHAR(2) not null,
        NAME VARCHAR(1000));

INSERT INTO EMP_MEDIUM_TABLE
SELECT     
    S AS empno,
    ROUND(random()*100) AS manager_id,
    ROUND(random()*10) AS dept_id,
    (ARRAY['M','F'])[round(random())+1] AS gender,
    gen_random_uuid() AS name_hashed
FROM generate_series(1,5000) as S;


------------------------------------------
------------ Create Project Table --------
------------------------------------------

CREATE TABLE PROJECT_MEDIUM_TABLE
       (PROJECTNO integer,
        NAME_hashed VARCHAR(100));

INSERT INTO PROJECT_MEDIUM_TABLE
SELECT     S                                                       PROJECTNO,
           gen_random_uuid() AS NAME_hashed
FROM generate_series(1,5000) as S;


------------------------------------------
---- Create Join table: Project-Employee -
------------------------------------------

CREATE TABLE PROJECT_EMP_MEDIUM_TABLE
       (PROJECTNO integer,
        EMPNO integer);

INSERT INTO PROJECT_EMP_MEDIUM_TABLE
SELECT     ROUND(random()*100) AS                                PROJECTNO,
           ROUND(random()*100) AS                                EMPNO
FROM generate_series(1,5000) as S;

SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by gender;	
EXPLAIN SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by gender;


	
SELECT * FROM pg_stat_statements
WHERE query like '%group by gender' and query not like 'EXPLAIN%'

SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by gender;

	
SELECT * FROM pg_stat_statements
WHERE query like '%group by gender' and query not like 'EXPLAIN%'


create index MANAGER_ID_GENDER_INDEX ON EMP_MEDIUM_TABLE(MANAGER_ID, GENDER);

select pg_stat_statements_reset();

SELECT * FROM pg_stat_statements
WHERE query like '%group by gender' and query not like 'EXPLAIN%'


SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by gender;

EXPLAIN SELECT gender, count(*) from EMP_MEDIUM_TABLE where MANAGER_ID = 7 group by
gender;

CREATE TABLE MY_OBJECTS (
    Object VARCHAR(255),
    Type VARCHAR(50)
);


INSERT INTO MY_OBJECTS (Object, Type)
SELECT table_name, 'Table'
FROM information_schema.tables
WHERE table_schema = 'public';  

INSERT INTO MY_OBJECTS (Object, Type)
SELECT column_name, 'Column'
FROM information_schema.columns
WHERE table_schema = 'public'; 

INSERT INTO MY_OBJECTS (Object, Type)
SELECT constraint_name, 'Constraint'
FROM information_schema.table_constraints
WHERE constraint_schema = 'public';  

SELECT * FROM MY_OBJECTS

*/
UPDATE EMP SET SAL = 7000 WHERE EMPNO = 7369; 
UPDATE EMP SET SAL = 7000 WHERE EMPNO = 7369;