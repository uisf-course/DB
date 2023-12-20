/*create or replace function raise_error()
returns trigger as
$$
begin
	if new.name = 'Ali' then
		raise notice 'Ali is not allowed';
		return null;
	else
		return new;
	end if;
end;
$$
language plpgsql;


create or replace trigger ali_not_allowed before insert on student
for each row execute procedure raise_error();

--insert into student values('12346', 'Ali', 'Math', 81);
select * from student where name = 'Ali'
*/

--insert into section values ('313','2','Fall',2010, 'Chandler', 804, 'Z')


-------------------------------------------------------------------

create or replace function time_slot_check()
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
execute procedure time_slot_check()