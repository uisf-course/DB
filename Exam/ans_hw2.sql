select * from student where name like 'C___%';
select * from student where dept_name = 'Comp. Sci.' and tot_cred < 80 order by id;
select * from student where name like 'M%';
select s.course_id,s.sec_id,s.semester,s.year,count(*)as enrolment_number from section s,takes t 
where (s.course_id,s.sec_id,s.semester,s.year)=(t.course_id,t.sec_id,t.semester,t.year)
and s.year='2007' group by (s.course_id,s.sec_id,s.semester,s.year);
select c.course_id,c.title from course c
where not exists (select * from section s,teaches t where c.course_id=s.course_id 
				  and (s.course_id,s.sec_id,s.year,s.semester)=(t.course_id,t.sec_id,t.year,t.semester))
				  and c.dept_name='Comp. Sci.';
				  

with enrolment as (select count(*) as cnt,s.course_id,s.sec_id from section s,takes t 
							where (s.year,s.semester,s.sec_id,s.course_id)=(t.year,t.semester,t.sec_id,t.course_id)
						   and s.year=2010 group by (s.course_id,s.sec_id,s.semester,s.year))
select course_id,sec_id from enrolment where cnt = (select max(cnt) from enrolment);

select distinct s.id, s.name from student s,takes t,course c 
where s.id=t.id and t.course_id=c.course_id and c.dept_name='Comp. Sci.';

with max_salary as (select dept_name,max(salary) as maxs from instructor group by dept_name)
select dept_name, maxs from max_salary where maxs = (select min(maxs)from max_salary);

													   
select distinct s.id,s.name,c.course_id,c.title from student s,course c,takes t1 
where 2 <= (select count(*) from takes t2
		where t2.course_id=t1.course_id and t2.id=t1.id) and
		s.id=t1.id and c.course_id=t1.course_id order by s.id;

select title,dept_name from course where dept_name like '%Eng.%' except 
(select title,dept_name from course where dept_name='Elec. Eng.') order by dept_name;

/* insert into course(course_id,title,credits) values ('100', 'Weekly Seminar', 3);*/

/* insert into section(course_id,sec_id,semester,year) values('100', '1', 'Fall', 2020)*/

/*insert into takes
select id,course_id,sec_id,semester,year,null from student,section
where dept_name='Comp. Sci.' and course_id='100'*/

select * from takes,course where takes.course_id=course.course_id and title like '%Programming%';
						   
/* delete from takes where course_id in (select course_id from course where title like '%Programming%')	*/				   
									  
select dept_name from instructor group by dept_name 
having sum(salary) > 
(select avg(sums) from (select sum(salary) as sums from instructor group by dept_name)as sum_salary);									  

with dup_course as
(select distinct s.id,s.name,c.course_id,c.title from student s,course c,takes t1
where s.id=t1.id and c.course_id=t1.course_id and 2 <= (select count(*) from takes t2
													   where t2.course_id=c.course_id and t2.id=s.id) order by s.id)
select id,name from dup_course group by (id,name) having count(*) >=3;													   
		
select distinct s.id,s.name from student s,takes ta
where s.id=ta.id and ta.course_id = some(select course_id from course c where c.dept_name != s.dept_name);

/*select a.i_id,count(*) from student s,advisor a,instructor i 
where s.id=a.s_id and i.id=a.i_id and s.dept_name != i.dept_name
group by a.i_id having count(*) > some(select count(*) from student s1,advisor a1,instructor i1 
where s1.id=a1.s_id and i1.id=a1.i_id and s1.dept_name = i1.dept_name ;*/

select a.i_id,i.dept_name,s.dept_name,count(*) from student s,advisor a,instructor i 
where s.id=a.s_id and i.id=a.i_id and s.dept_name != i.dept_name
group by (a.i_id,i.dept_name,s.dept_name) 
having count(*) > all(select count(*) from student s1,advisor a1,instructor i1 
where s1.id=a1.s_id and i1.id=a1.i_id and s1.dept_name = i1.dept_name and s1.dept_name=s.dept_name);
	 


