/* استادی که تا کنون به هیچ کدام از دانشجویان نمره عالی نداده است*/
/* Instructors who have never taught a course trivially satisfy this condition */
/*
select id,name 
from instructor iout
where 
not exists (select iin.id 
			from (instructor iin natural join teaches te) join takes ta using (course_id,sec_id,semester,year)
				where ta.grade = 'A' and iin.id = iout.id)
*/








/*
Using the university schema, write an SQL query to find the number of students
in each section. The result columns should appear in the order
*/
select course_id,sec_id,semester,year,count(*) as num
from takes natural join section group by(course_id,sec_id,semester,year);



/* quiz*/
/* 
Using the university schema, write an SQL query to find section(s) with maximum
enrollment. The result columns should appear in the order “courseid,
secid, year, semester, num
*/

with enrolment(course_id,sec_id,semester,year,num) as
(select course_id,sec_id,semester,year,count(*)
from takes natural join section group by(course_id,sec_id,semester,year))
select * 
from enrolment where num = (select max(num) from enrolment);


/*
Using the university schema, write an SQL query to find the ID and title of each
course in Comp. Sci. that has had at least one section with afternoon hours (i.e.,
ends at or after 12:00). (You should eliminate duplicates if any.)
*/

select distinct(c.course_id), c.title
from (course c natural join section s),time_slot ts
where c.dept_name = 'Comp. Sci.' and s.time_slot_id = ts.time_slot_id and 
	s.time_slot_id in (select time_slot_id
							from time_slot
							where end_hr >=12);
							
/* quiz*/
/* 
Using the university schema, write an SQL query to find the name and ID of
each physsics student who has 
taken at least 3 Comp. Sci courses
*/
select * 
from student
where 3 <= (select count(*) from 
	takes natural join course
	where course.dept_name='Comp. Sci.' and takes.id=student.id and takes.grade is not null);

/* find the name of the student that takes maximum course from the computer science department */
select takes.id,count(*) from 
	takes natural join course
	where course.dept_name='Comp. Sci.' and takes.grade is not null
	group by takes.id;
	
select distinct(c.course_id), c.title
from (course c natural join section s),time_slot ts
where c.dept_name = 'Comp. Sci.' and s.time_slot_id = ts.time_slot_id and 
	ts.end_hr >= 12;


