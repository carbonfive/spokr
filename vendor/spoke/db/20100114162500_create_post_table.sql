create table posts (
  id bigint(20) not null auto_increment,
  created_at datetime not null,
  updated_at datetime not null,
  title varchar(255) not null,
  author_id bigint(20),
  anon_author_name varchar(64),
  status varchar(16) not null,
  source varchar(64),
  source_uri varchar(255),
  parent_id bigint(20),
  container_id bigint(20) not null,
  tags varchar(1024),
  text_content text,
  binary_content blob,
  uri_content varchar(1024),
  primary key (id)
) engine=InnoDB default charset=utf8;

alter table posts
  add index FK_post_parent (parent_id),
  add constraint FK_post_parent foreign key (parent_id) references posts (id);

alter table posts
  add index FK_post_container (container_id),
  add constraint FK_post_container foreign key (container_id) references containers (id);

alter table posts
  add index FK_post_author (author_id),
  add constraint FK_post_author foreign key (author_id) references users (id);