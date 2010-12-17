create table tags (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  primary key (`id`),
  UNIQUE KEY `I_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

create table taggings (
  `id` bigint(20) NOT NULL auto_increment,
  `post_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `I_post_id` (`post_id`,`tag_id`),
  KEY `I_tag_id` (`tag_id`,`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

alter table posts drop column tags, drop column source, drop column source_uri;
drop table post_commands;