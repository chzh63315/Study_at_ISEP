/*	

CREATE OR REPLACE FUNCTION myFunction(p_empno INTEGER) RETURNS TEXT AS $$
DECLARE
  empName TEXT;
BEGIN
  SELECT ename INTO empName FROM emp WHERE empno = p_empno;
  IF NOT FOUND THEN
    RETURN NULL; 
  END IF;
  RETURN empName;
END;
$$ LANGUAGE plpgsql;


SELECT myFunction(7654);



CREATE OR REPLACE PROCEDURE Exercicel(in_EMP_id NUMERIC)
language plpgsql
as $procedure$

DECLARE 
SAL_EMP EMP.SAL%TYPE;
AVG_SAL numeric; 

BEGIN 
	SELECT SAL 
	INTO SAL_EMP FROM EMP WHERE EMPNO = in_EMP_id;
	
	SELECT AVG(SAL) into avg_sal from emp where job in (select job from emp where empno = in_EMP_id);
	
	raise notice 'Employee No： % ，Employee Salary : %', in_EMP_id, SAL_EMP;
	raise notice 'AVG of salaries : %', avg_sal;
	
	EXCEPTION 
	
	WHEN OTHERS THEN 
	raise NOTICE 'SQL erros of query: %',SQLERRM;
	
	End;
	
	$procedure$


CALL public.exercicel( 7521 )






CREATE OR REPLACE PROCEDURE updateEmployeeSalary(p_empno INTEGER)
	LANGUAGE PLPGSQL
	AS $BODY$
	
DECLARE
  v_currentSalary NUMERIC;
  v_avgSalary NUMERIC;
 
BEGIN
  -- 计算平均薪水
  SELECT AVG(sal) INTO v_avgSalary FROM emp;

  -- 获取当前员工的薪水
  SELECT sal INTO v_currentSalary FROM emp WHERE empno = p_empno;

  -- 比较薪水并根据结果进行更新
  IF v_currentSalary >= v_avgSalary THEN
    -- 如果薪水大于等于平均薪水，增加10%
    UPDATE emp SET sal = v_currentSalary * 1.10 WHERE empno = p_empno;
  ELSE
    -- 否则，设置薪水为平均薪水
    UPDATE emp SET sal = v_avgSalary WHERE empno = p_empno;
  END IF;

  -- 显示更新前后的薪水
  RAISE NOTICE 'Previous Salary: %, New Salary: %', v_currentSalary, (SELECT sal FROM emp WHERE empno = p_empno);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE NOTICE 'No employee found with empno %', p_empno;
  WHEN OTHERS THEN
    RAISE EXCEPTION 'Error occurred: %', SQLERRM;
END;

$BODY$

CALL updateEmployeeSalary(7654);

ALTER TABLE bonus ADD COLUMN bonus NUMERIC;

CREATE OR REPLACE PROCEDURE calculateAndInsertBonus() 
LANGUAGE PLPGSQL
AS $$
DECLARE
  emp_record EMP%ROWTYPE;
BEGIN
  FOR emp_record IN SELECT * FROM EMP LOOP
    -- 基于职位计算奖金
    CASE emp_record.job
      WHEN 'SALESMAN' THEN
        INSERT INTO BONUS(ename, job, sal, comm, bonus) 
        VALUES (emp_record.ename, emp_record.job, emp_record.sal, emp_record.comm, emp_record.comm * 2);
      WHEN 'CLERK' THEN
        INSERT INTO BONUS(ename, job, sal, comm, bonus) 
        VALUES (emp_record.ename, emp_record.job, emp_record.sal, emp_record.comm, emp_record.sal * 0.15);
      WHEN 'MANAGER' THEN
        INSERT INTO BONUS(ename, job, sal, comm, bonus) 
        VALUES (emp_record.ename, emp_record.job, emp_record.sal, emp_record.comm, emp_record.sal * 0.18);
      -- 如果职位不是上述任何一种，你可以选择插入0，或者不插入记录
      ELSE
        INSERT INTO BONUS(ename, job, sal, comm, bonus) 
        VALUES (emp_record.ename, emp_record.job, emp_record.sal, emp_record.comm, 0);
    END CASE;
  END LOOP;
END;
$$;

CALL calculateAndInsertBonus();

select * from bonus;


课程上写的版本
CREATE OR REPLACE PROCEDURE UPDATECOMMISSION()
	LANGUAGE PLPGSQL
	AS $BODY$
	
	DECLARE 
	ONE_EMP EMP%ROWTYPE;
	E_SAL numeric;
	new_comm numeric;
	
	SAL_EMP CURSOR FOR SELECT * from EMP for UPDATE;
	
begin
	
	OPEN SAL_EMP;
	LOOP 
	FETCH SAL_emp INTO ONE_EMP;
	EXIT WHEN NOT FOUND;
	
	E_SAL := ONE_EMP.SAL ;
	IF E_SAL <= 1800 THEN
	new_comm := 800;
	else if E_SAL<= 1200 THEN
	new_comm := 1200;
	else
	new_comm := 1500;
	end if;
	end if;
	
	update emp set comm = new_comm where empno = one_emp.ENPNO;
	raise notice 'salary of employee no：% is %',one_emp.empno,e_sal;
	raise notice 'the new commission is %',new_comm;
	END LOOP;
	commit;
	
	
	CLOSE SAL_EMP;
		
   END;

$BODY$




CREATE OR REPLACE PROCEDURE UPDATECOMMISSION()
	LANGUAGE PLPGSQL
	AS $BODY$
	
	DECLARE 
	ONE_EMP EMP%ROWTYPE;
	E_SAL numeric;
	new_comm numeric;
	SAL_EMP CURSOR FOR SELECT * from EMP for UPDATE;
	
begin
	
	OPEN SAL_EMP;
	LOOP 
	FETCH SAL_emp INTO ONE_EMP;
	EXIT WHEN NOT FOUND;
	
	E_SAL := ONE_EMP.SAL ;
	IF E_SAL <= 1800 THEN
	new_comm := 800;
	else if E_SAL<= 1200 THEN
	new_comm := 1200;
	else
	new_comm := 1500;
	end if;
	end if;
	
	update emp set comm = new_comm where empno = ONE_EMP.EMPNO;
	raise notice 'salary of employee no：% is %',ONE_EMP.empno,e_sal;
	raise notice 'the new commission is %',new_comm;
	END LOOP;
	commit;
	
	
	CLOSE SAL_EMP;
		
   END;

$BODY$

call UPDATECOMMISSION();



CREATE OR REPLACE PROCEDURE DisplayTopBottomSalaries() 
LANGUAGE PLPGSQL
AS $$
DECLARE
  -- 游标，用于获取薪水最高的五名员工
top_salaries_cur CURSOR FOR SELECT ename, sal FROM emp ORDER BY sal DESC LIMIT 5;
  
  -- 游标，用于获取薪水最低的五名员工
bottom_salaries_cur CURSOR FOR SELECT ename, sal FROM emp ORDER BY sal ASC LIMIT 5;
  
  emp_record emp%ROWTYPE;
BEGIN
  -- 显示薪水最高的五名员工
  RAISE NOTICE 'Top five highest salaries:';
  FOR emp_record IN top_salaries_cur LOOP
    RAISE NOTICE 'Employee: %, Salary: %', emp_record.ename, emp_record.sal;
  END LOOP;
  
  -- 显示薪水最低的五名员工
  RAISE NOTICE 'Top five lowest salaries:';
  FOR emp_record IN bottom_salaries_cur LOOP
    RAISE NOTICE 'Employee: %, Salary: %', emp_record.ename, emp_record.sal;
  END LOOP;
END;
$$;

call DisplayTopBottomSalaries();

CREATE TABLE monitor (
  user_update TEXT,
   date_update TIMESTAMP );
	
CREATE OR REPLACE FUNCTION auto_insert() returns trigger
AS $BODY$

begin 
insert into monitor(user_update,date_update) values(current_user,current_date);
raise notice 'user doing the modification :% ',current_user;
raise notice 'modification date: % ', current_date;
return NULL;

end;
$BODY$
language plpgsql;

create or replace trigger mytrigger
after insert or update or delete on emp
execute procedure auto_insert();

UPDATE emp SET sal = 900 WHERE empno = 7436;

update emp set comm = 2000 where empno =7521;
	
select * from monitor;	
	

CREATE TABLE audit_log (
  operation_type CHAR(1),   -- 'I' 插入, 'D' 删除, 'U' 更新
  username TEXT,            -- 执行操作的用户名
  operation_timestamp TIMESTAMP, -- 操作发生的时间
  empno INTEGER,            -- 被修改的EMP表中的员工编号
  changed_data TEXT         -- 修改的数据，可能是一个新值或旧值的快照
);
*/

CREATE OR REPLACE FUNCTION AnalyzeActivity(input_username TEXT, activity_date DATE)
RETURNS TABLE(username TEXT, operation_count INTEGER) LANGUAGE plpgsql AS $$
BEGIN
  RETURN QUERY
  SELECT user_update, CAST(COUNT(*) AS INTEGER) 
  FROM monitor
  WHERE (input_username IS NULL OR user_update = input_username)
    AND (activity_date IS NULL OR date_update::DATE = activity_date)
  GROUP BY user_update;
END;
$$;


-- 获取所有用户在特定日期的活动
SELECT * FROM AnalyzeActivity(NULL, '2024-04-01');

-- 获取特定用户的所有活动
SELECT * FROM AnalyzeActivity('postgres', NULL);





