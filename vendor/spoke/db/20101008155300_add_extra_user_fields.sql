alter table users add column source varchar(255);
alter table users add column unique_id varchar(255);
alter table users add column extra_info text;

alter table users
  add index I_user_source (source);

alter table users
  add index I_user_unique_id (unique_id);