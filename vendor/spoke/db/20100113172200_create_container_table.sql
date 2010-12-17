create table containers (
  id bigint(20) not null auto_increment,
  created_at datetime not null,
  updated_at datetime not null,
  name varchar(255) character set utf8 collate utf8_bin not null,
  primary key (id),
  constraint U_container_name unique (name)
) engine=InnoDB default charset=utf8;