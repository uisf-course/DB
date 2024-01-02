/*create or replace function time_slot_check()
returns trigger
as
$$
begin
	if new.time_slot_id not in (select time_slot_id from time_slot) then 
		return null;
	else
		return new;
	end if;
end;
$$
language plpgsql;

create or replace trigger time_slot_check_trigger before insert or update of time_slot_id
on section 
for each row 
execute procedure time_slot_check();

insert into section 
values('BIO-101', '1', 'Summer', 2017, 'Painter', '514', 'X')
*/

/*
create or replace function time_slot_delete()
returns trigger
as
$$
begin
	if old.time_slot_id in (select time_slot_id from section) then
		update section 
		set time_slot_id = null
		where time_slot_id = old.time_slot_id;
	end if;
	return old;
end;
$$
language plpgsql;

create or replace trigger time_slot_delete_tigger after delete on time_slot
for each row execute procedure time_slot_delete();
*/

/*
delete from time_slot
where time_slot_id = 'B'
*/
/*
select * from section
*/


/* 
Suppose that when the name of an student changes, you want to log the changes 
in a separate table called employee_audits
*/
/*
drop table if exists student_audits;
CREATE TABLE student_audits (
   id int generated always as identity ,
   s_id varchar(5) not null,
   name VARCHAR(20) not null,
   changed_on TIMESTAMP not null
);
*/
/* drop function if exists log_last_name_changes() cascade */
/*create or replace function log_name_changes_func()
returns trigger as
$$
begin
	if new.name <> old.name then
		insert into student_audits
		values(default, old.id, old.name, now());
	end if;
	return new;
end;
$$
language plpgsql;


create or replace trigger log_name_changes 
before update of name 
on student
for each row 
execute procedure log_name_changes_func();

update student
set name = 'Brandt5'
where id = '19991';


select * from student_audits
*/

