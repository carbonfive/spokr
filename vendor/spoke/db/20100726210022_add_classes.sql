
alter table posts add column post_class varchar(255),
                  change column status state varchar(255);
update posts set post_class='DEFAULT';
