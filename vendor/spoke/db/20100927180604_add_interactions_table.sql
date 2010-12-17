create table interactions (
  `id` bigint(20) NOT NULL auto_increment,
  `post_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `interaction_type` varchar(60) NOT NULL,
  `value` varchar(1024) DEFAULT NULL,
  primary key (`id`),
  KEY `I_post_id_type` (`post_id`,`interaction_type`),
  KEY `I_user_id_type` (`user_id`,`interaction_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
