
-- hopefully no one's going to have more than 1000 containers by the time this is run
update posts set id=id+1000;
update posts set parent_id = parent_id+1000 where not parent_id is null;
update posts set parent_id = container_id where parent_id is null;

alter table posts drop foreign key FK_post_container,
                  drop index FK_post_container,
                  drop column container_id;

insert into posts (id, post_key, status, created_at, updated_at, title)
            select id, UUID(), 'OK', created_at, updated_at, name from containers;

drop table containers;
