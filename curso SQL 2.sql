use employees_mod;

select 
	year(td.from_date) as calendar_year,
	te.gender,
    count(te.emp_no)
from t_employees te
join t_dept_emp td on te.emp_no=td.emp_no
group by calendar_year, te.gender
having calendar_year >= 1990;

select
	dm.emp_no, dm.dept_no, dm.from_date, dm.to_date,
    d.dept_name,
    ee.gender,
    e.calendar_year,
    case
		when calendar_year between year(dm.from_date) and year(dm.to_date) then 1
        else 0
    end as active
from 
	(select
		year(hire_date) as calendar_year
	from t_employees
    group by calendar_year) e
    cross join
		t_dept_manager dm
	join t_departments d on dm.dept_no=d.dept_no
    join t_employees ee on dm.emp_no=ee.emp_no
order by dm.emp_no, calendar_year;


select
	ee.gender,
    d.dept_name,
    round(avg(s.salary),2) as salary,
	year(s.from_date) as calendar_year
from
t_employees ee
join t_salaries s on ee.emp_no=s.emp_no
join t_dept_manager dm on ee.emp_no=dm.emp_no
join t_departments d on dm.dept_no=d.dept_no
group by d.dept_no, ee.gender, calendar_year
having calendar_year < 2003
order by d.dept_no;   

drop procedure if exists avg_salaries;

Delimiter $$
create procedure avg_salaries (in p_min_salary float, in p_max_salary float)
begin
select 
	e.gender,
    d.dept_name,
	round(avg(s.salary),2) as avg_salary
from t_salaries s
join t_employees e on s.emp_no=e.emp_no
join t_dept_manager dm on e.emp_no=dm.emp_no
join t_departments d on dm.dept_no=d.dept_no
where s.salary between p_min_salary and p_max_salary
group by d.dept_no, e.gender;
END $$

DELIMITER ;

call avg_salaries(50000,90000);