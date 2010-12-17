alter table posts add column payload text;
alter table posts change column title `title` varchar(255) default NULL;
