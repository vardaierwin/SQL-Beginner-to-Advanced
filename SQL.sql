-- SELECT
select * from parks_and_recreation.employee_demographics;

select first_name, 
last_name, 
birth_date,
age
from parks_and_recreation.employee_demographics;
# PEMDAS

select distinct  first_name, gender 
from parks_and_recreation.employee_demographics;

-- WHERE Clause
select * from employee_salary es 
where es.salary >= 50000;


-- LIKE Statement
-- % and _
select  * from employee_demographics ed 
where gender != 'Female'
and ed.birth_date like '%-03-%';

select  * from employee_demographics ed 
where ed.first_name like 'a___%';

-- Group By
select gender, avg(age), max(age), min(age), count(age)
from employee_demographics ed
group by gender;

select es.occupation, avg(es.salary)
from employee_salary es 
group by es.occupation;

-- Order by
select *
from employee_demographics ed
order by 5, 4; -- positions of the fields

-- HAVING vs WHERE
select gender, avg(age)
from employee_demographics ed 
group by gender
having avg(age) > 40;

select occupation, avg(es.salary)
from employee_salary es 
where es.occupation like "%manager%"
group by occupation
having avg(salary) > 75000;

-- Limit and aliasing
select * from employee_demographics ed 
order by ed.age desc
limit 2, 1 -- after 2 rows, I take the first row
;

select gender, avg(age) as average_age
from employee_demographics ed 
group by gender
having average_age > 40;

-- JOIN
select *
from employee_demographics ed;

select *
from employee_salary es;

-- inner join
select ed.employee_id, ed.age, es.occupation
from employee_demographics ed 
inner join employee_salary es 
	on ed.employee_id = es.employee_id
;

-- outer joins
select *
from employee_demographics ed 
right join employee_salary es -- left join
	on ed.employee_id = es.employee_id

-- self join
select es.employee_id, es.first_name, es.last_name, es2.employee_id, es2.first_name, es2.last_name 
from employee_salary es
join employee_salary es2 
	on es.employee_id + 1 = es2.employee_id;

-- Joining multiple tables together
select *
from employee_demographics ed 
inner join employee_salary es 
	on ed.employee_id = es.employee_id
inner join parks_departments pd
	on es.dept_id = pd.department_id
;

-- Unions (rows together)
select ed.first_name, ed.last_name
from employee_demographics ed 
union all # or distinct
select es.first_name, es.last_name
from employee_salary es 
;

-- Unions (rows together)
select ed.first_name, ed.last_name, 'Old Man' as Label
from employee_demographics ed 
where age > 40 and gender = "Male"
union 
select ed.first_name, ed.last_name, 'Old Lady' as Label
from employee_demographics ed 
where age > 40 and gender = "Female"
union 
select es.first_name, es.last_name, 'Highly paid employee' as Label
from employee_salary es 
where salary > 70000 
order by first_name, last_name
;

-- String Functions
select LENGTH('mynameis');

select ed.first_name , LENGTH(ed.first_name)
from employee_demographics ed 
order by 2
;

select upper('mynameis'), lower('MYNAMEIS');

select first_name, upper(last_name)
from employee_demographics 
;

select ltrim('        name               ');
select rtrim('        name               ');

select ed.first_name, 
left(ed.first_name, 4),
right(ed.first_name, 4),
substring(ed.first_name, 3, 2), # beginning with the thirds character it reads 2 letters
substring(ed.birth_date, 6, 2) as 'Month'
from employee_demographics ed;

select ed.first_name, replace(first_name, 'a', 'z')
from employee_demographics ed;

select locate('x', 'Alexander'); # 'x' is in the 4th place in 'Alexander'

select ed.first_name, locate('An', first_name)
from employee_demographics ed;

select ed.first_name, ed.last_name,
CONCAT(ed.first_name, ' ', ed.last_name) as full_name
from employee_demographics ed;

-- Case Statements
select ed.first_name, ed.last_name, age,
case 
	when age <= 30 then 'Young'
	when age between 31 and 45 then 'Middle Age'
	else 'Old' 
end as 'Age Category'
from employee_demographics ed;

-- if-case
select ed.first_name, ed.last_name, age,
if (age <= 30, 'Young',
	if(age > 30 and age <= 45, 'Middle Age', 'Old')) as age_category
from employee_demographics ed;

-- pay increase and bonus: < 5000 = 5%, > 5000 = 7%, Finance = 10% bonus
select first_name, 
last_name,
salary,
case
	when salary < 5000 then salary * 1.05
	when salary > 5000 then salary * 1.07
end as New_Salary,
case 
	when dept_id = 6 then salary * .1
end as Bonus
from employee_salary;

-- Subqueries
select avg(`min(ed.age)`), avg(`max(ed.age)`), avg(`avg(ed.age)`) from
(select ed.gender, min(ed.age), max(ed.age), avg(ed.age), count(ed.age)
from employee_demographics ed 
group by ed.gender) as agg_table
;

select avg(min_age), avg(max_age), avg(avg_age) from
(select 
ed.gender, 
min(ed.age) as min_age, 
max(ed.age) as max_age, 
avg(ed.age) as avg_age, 
count(ed.age)
from employee_demographics ed 
group by ed.gender) as agg_table
;
 
-- Window Functions

select ed.gender, avg(es.salary) from employee_demographics ed
join employee_salary es
on ed.employee_id = es.employee_id
group by ed.gender;

select ed.first_name, ed.last_name, ed.gender, es.salary, sum(es.salary) over(partition by ed.gender order by ed.employee_id) as sum_sal_rolling_total
from employee_demographics ed
join employee_salary es
on ed.employee_id = es.employee_id;

select ed.first_name, ed.last_name, ed.gender, es.salary, 
row_number() over(partition by ed.gender order by salary desc) as sum_sal_rolling_total,
rank() over(partition by ed.gender order by salary desc) as rank_num,
dense_rank() over(partition by ed.gender order by salary desc) as dense_rank_num
from employee_demographics ed
join employee_salary es
on ed.employee_id = es.employee_id;


-- CTE
select ed.gender, 
min(es.salary) as min_sal, 
max(es.salary) as max_sal, 
round(avg(es.salary), 0) as avg_sal,
count(es.salary) as count_sal
from employee_demographics ed
join employee_salary es
on ed.employee_id = es.employee_id
group by gender;


with cte_avg_male_age as (
    select avg(age) as avg_male_age
    from employee_demographics
    where gender = 'male'
)
select ed.*, cte_avg_male_age.avg_male_age
from employee_demographics ed, cte_avg_male_age
where ed.gender = 'male'
and ed.age > cte_avg_male_age.avg_male_age;

with CTE_example (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) as
(
select gender, 
avg(salary) avg_sal, 
max(salary) max_sal, 
min(salary) min_sal, 
count(salary) count_sal
from employee_demographics ed 
join employee_salary es 
on ed.employee_id = es.employee_id 
group by gender
)
select * # avg(avg_sal)
from CTE_example;

with cte_ocp as (
    select pd.department_name, concat(es.first_name, ' ', es.last_name) as name, es.salary
    from employee_salary es
    join parks_departments pd
        on es.dept_id = pd.department_id
),
cte_avg_sal as (
    select avg(salary) as avg_sal
    from employee_salary
)
select department_name, name, salary, (cte_avg_sal.avg_sal - salary) as salary_difference, avg_sal 
from cte_ocp, cte_avg_sal
where salary < cte_avg_sal.avg_sal;

-- Temporary Tables
create temporary table test
(
	`discipline` varchar(30),
	`grade` int unsigned
);

insert into test values ('Algorithms', 10);
insert into test values ('Maths', 8);
select * from test;


create temporary table salary_over_50k2 (
	select * from employee_salary es
	where es.salary >= 50000
);

select * from employee_salary es ;
select * from salary_over_50k2;


-- Stored Procedures
create procedure large_salaries()
select * from employee_salary es
where es.salary >= 50000;

call large_salaries();

create procedure large_salaries2()
begin
	select * 
	from employee_salary es
	where es.salary >= 50000;
	select * 
	from employee_salary es
	where es.salary >= 10000;
end;

call large_salaries2();
call large_salaries3();

delimiter $$
$$
create procedure large_salaries4(in p_employee_id int)
begin
	select es.salary 
	from employee_salary es
	where es.employee_id = p_employee_id;
end $$
delimiter ;

call large_salaries4(1);

-- Triggers 
delimiter $$
create trigger employee_insert 
	after insert on employee_salary
	for each row
begin 
	insert into employee_demographics (employee_id, first_name, last_name)
	values (new.employee_id, new.first_name, new.last_name);
end $$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values (13, 'John', 'Mark', 'Entertainment', 1000000, NULL);

select * from employee_salary es;
select * from employee_demographics ed;

-- Events
delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete from employee_dempgraphics
	where age >= 60;
end $$
delimiter ;

show variables like 'event%';
SET GLOBAL event_scheduler=on;

