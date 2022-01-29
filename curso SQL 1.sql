select * from employees
where first_name="Elvis" or first_name="Aruna";
where first_name in (“Denis”, “Elvis”);

select first_name, last_name from employees;

select * from salaries
where salary between "66000" AND "70000";

select * from employees
where hire_date like "%200_%" and gender="F";

select count(*) * from salaries
where salary>100000;

select count(*) from dept_manager;

select salary, count(emp_no) from salaries
where salary>80000
group by salary
order by salary;

select * from salaries
where salary>150000;

select dept_no from departments;

select * from employees
where first_name not like ("%Jack%");

select emp_no, avg(salary) from salaries
group by emp_no
having avg(salary)>120000;

select emp_no, avg(salary) from salaries
where salary>120000
group by emp_no;

select *, count(from_date) from employees.dept_emp
where from_date >="2000-01-01"
group by emp_no
having count(from_date)>1;

select * from dept_emp
order by emp_no desc
limit 10;

insert into dept_emp
values (9999903,"d005","1997-10-01","9999-01-01");

insert into titles (emp_no, title, from_date, to_date)
values(9999903,"senior engineer","1997-10-01","999-01-01");

create table departments_dup 
(dept_no char(4) not null, dept_name varchar(40) not null);

select * from departments_dup;

insert into departments_dup
select * from departments;

insert into departments_dup
values ("d010","business analysis");

select * from employees
order by emp_no desc
limit 10;

update employees
set
	first_name = "Stella",
    last_name = "parkinson",
    gender = "F",
    birth_date = "1990-12-31"
where emp_no = 9999909;

select * from departments_dup
limit 10;

commit;

update departments_dup
set 
	dept_no = "d011",
    dept_name = "quality control";

rollback;

update departments_dup
set 
    dept_name = "data control"
where dept_name = "Research";

commit;

select * from titles
where emp_no="9999903";

delete from departments
where dept_no="d010";

delete from employees
where emp_no="9999903";

rollback;

select count(distinct dept_no) from dept_emp;

select sum(salary) from salaries
where from_date="1997-01-01";

select max(emp_no) from employees;

select round(avg(salary)) from salaries;

alter table departments_dup
change column dept_name dept_name varchar(40) null;

insert into departments_dup(dept_no) values ("d010"), ("d011");

select * from departments_dup
order by dept_no asc;

commit;

alter table departments_dup
add column dept_manager varchar(255) null after dept_name;

select dept_no,
	ifnull(dept_name, "not provided") as dept_name
 from departments_dup;
 
 select 
 ifnull(dept_no, "N/A") as dept_no, 
 ifnull(dept_name, "N/A") as dept_name,
	coalesce(dept_name,"not provided") as dept_info
 from departments_dup;
 
 select * from departments_dup;
 
 alter table departments_dup
 drop column dept_manager;
 
 alter table departments_dup
 change column dept_name dept_name varchar(40) null,
 change column dept_no dept_no char(4) null;
 
 insert into departments_dup
 (dept_name)
 values("public relations");
 
 insert into departments_dup
 (dept_no)
 values("d013"),("d012");
 
 delete from departments_dup
 where dept_no= "d002";
 
 ALTER TABLE departments_dup
DROP COLUMN dept_manager;
 
 ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
    DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );

INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                (999904, '2017-01-01'),
                                (999905, '2017-01-01'),
                               (999906, '2017-01-01'),
                               (999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE
    dept_no = 'd002'; 
    
select m.dept_no, m.emp_no, m.from_date, e.first_name, e.last_name
from dept_manager_dup m
left join
employees e on m.emp_no=e.emp_no
where e.first_name="Ebru";

order by m.dept_no;

select
e.emp_no, e.first_name, e.last_name, d.from_date, d.dept_no
from employees e,
	dept_manager d
where
e.emp_no=d.emp_no
order by d.dept_no, e.emp_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

select d.*, e.*
from employees e
cross JOIN
departments d
where e.emp_no<10010

select
	d.dept_name,
    m.from_date,
	e.first_name,
    e.last_name,
    e.hire_date
from 
	departments d
JOIN
	 dept_manager m on d.dept_no=m.dept_no
JOIN
	employees e on m.emp_no=e.emp_no;
    
    SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

select
	e.first_name,
    e.last_name,
    t.title,
    m.from_date,
    d.dept_name
from
	employees e
JOIN
	dept_manager m on e.emp_no = m.emp_no
JOIN
	departments d on m.dept_no = d.dept_no
JOIN
	titles t on e.emp_no = t.emp_no
order by e.emp_no;

select e.gender, count(dm.emp_no)
from 
	employees e
join
	dept_manager dm on e.emp_no=dm.emp_no
group by e.gender;


SELECT 
    *
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm)
        AND e.hire_date BETWEEN '1990-01-01' AND '1995-01-01';

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');

select * from employees e
where exists (select * from titles t where e.emp_no=t.emp_no AND title="Assistant Engineer");

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 110020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;
    
drop table if exists emp_manager;

create table emp_manager
( emp_no int(11) not null,
dept_no char(4) null,
manager_no int(11) not null);
    

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B
UNION SELECT 
    C.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110039') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) as C
    UNION SELECT 
    D.*
FROM
    (SELECT 
        e.emp_no AS emp_id,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = '110022') AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) as D
    ;

create or replace view v_dept_emp_latest_date as 
select
	emp_no, max(from_date) as from_date, max(to_date) as to_date
from dept_emp
group by emp_no;

create or replace view v_avg_mang_salary as 
select
	round(avg(s.salary),2)
from dept_manager dm
	join salaries s on s.emp_no=dm.emp_no;

drop procedure if exists select_employees;

delimiter $$
create procedure select_employees()
begin
select * from employees
limit 1000;
end$$

DELIMITER  ;

call select_employees();

delimiter $$
create procedure select_avg_salary()
begin
select avg(salary) from salaries;
end$$

DELIMITER  ;

delimiter $$
create procedure select_emp_no(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
begin
	select 
		e.emp_no
	into p_emp_no from
		employees e
	where e.first_name = p_first_name AND p_last_name = p_last_name;
end$$
DELIMITER ;

drop procedure if exists select_avg_salary_out;

delimiter $$
create procedure select_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
	select avg(s.salary) 
		into p_avg_salary
	from salaries s
    JOIN
		employees e on e.emp_no=s.emp_no
    where e.emp_no=p_emp_no;
end$$

DELIMITER ;

set @v_emp_no=0;
call select_emp_no('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;

set @v_avg_salary=0;
call employees.select_avg_salary_out(10030, @v_avg_salary);
select @v_avg_salary;

create function f_emp_info(p_first_name varchar(255), p_last_name varchar(255)) returns decimal(10,2)
delimiter $$
BEGIN
declare v_max_from_date date;
declare v_salary decimal(10,2);
	select
		s.salary
    into v_salary from
		salaries s
	JOIN
		employees e ON s.emp_no=e.emp_no
	where 
	e.first_name=p_first_name
		AND
    e.last_name=p_last_name;
    
	select
		s.max(from_date)
    into v_max_from_date from
		salaries s
	JOIN
		employees e ON s.emp_no=e.emp_no
	where 
	e.first_name=p_first_name
		AND
    e.last_name=p_last_name
		AND
	s.salary=v.salary
return v_salary;
END$$
delimiter ;

select f_emp_info('Arouna', 'Journel');

DELIMITER $$

create trigger before_emp_insert
before insert on employees
for each row
begin
	if new.hire_date > DATE_FORMAT(SYSDATE(), '%y-%m-%d') then
		set new.hire_date= DATE_FORMAT(SYSDATE(), '%y-%m-%d');
    End if;
end $$

DELIMITER ;


insert employees values ('999904','1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');

select * from employees
where emp_no='999904';

select * from salaries
where salary>'89000';

create index i_salary
on salaries (salary);

select * from salaries
where salary>'89000';

select 
	e.emp_no, e.first_name, e.last_name,
    case 
		when dm.emp_no is not null then 'Manager'
        else 'Employee'
	end as manager_check
from employees e
join dept_manager dm on e.emp_no=dm.emp_no
where e.emp_no>'109990';

select 
	dm.emp_no, e.first_name, e.last_name,
    max(s.salary)-min(s.salary) as salary_difference,
    case 
		when max(s.salary)-min(s.salary) >'30000' then 'Higher than 30K'
        else 'Lower than 30K'
	end as salary_check
from employees e
join dept_manager dm on e.emp_no=dm.emp_no
join salaries s on dm.emp_no=s.emp_no
group by s.emp_no;
#where e.emp_no >'109990';

select
	e.emp_no, e.first_name, e.last_name,
	case
		when sysdate() < max(de.to_date) then 'Employee'
		else 'Left'
    end as Still_employed
from employees e
join dept_emp de on e.emp_no=de.emp_no
group by de.emp_no
limit 100;

use employees;
select
	e.gender,
    dt.dept_name,
    round(avg(s.salary),2)
from employees e
join salaries s on e.emp_no=s.emp_no
join dept_emp d on e.emp_no=d.emp_no
join departments dt on d.dept_no=dt.dept_no
group by e.gender, dt.dept_name;

Select min(dept_no) from dept_emp;

Select max(dept_no) from dept_emp;

select
	e.emp_no,
    (select min(dept_no) 
    from dept_emp de
    where de.emp_no=e.emp_no) as crack,
    case 
		when e.emp_no<10020 then 110022
        else 110039
    end as manager
	from employees e
    group by e.emp_no
    having e.emp_no<10041;
    
    select
		e.emp_no,
		e.hire_date
	from employees e
    where year(e.hire_date)=2000;
    
    select 
    emp_no,
    title
    from titles 
    where title like 'Senior Engineer';
 
 
 delimiter $$
 create procedure select_employees (in p.emp_no integer)
 begin
    select 
		e.emp_no,
        e.dept_no
	from employees e
    where e.emp_no=p.emp_no
END
DELIMITER ;



drop procedure if exists select_employee;