create table post_commands (
  id bigint(20) not null auto_increment,
  created_at datetime not null,
  updated_at datetime not null,
  type varchar(16) not null,
  post_id bigint(20) not null,
  primary key (id)
) engine=InnoDB default charset=utf8;

alter table post_commands
  add index FK_post_command_post (post_id),
  add constraint FK_post_command_post foreign key (post_id) references posts (id);