create table users (
  id bigint(20) not null auto_increment,
  created_at datetime not null,
  updated_at datetime not null,
  username varchar(64) not null,
  password varchar(255),
  salt varchar(255),
  email varchar(255),
  role varchar(16) not null,
  active tinyint(1) not null,
  primary key (id)
) engine=InnoDB default charset=utf8;

alter table users
  add index I_user_username (username);

alter table users
  add index I_user_email (email);