
alter table posts add column post_key VARCHAR(255) after id;
update posts set post_key=UUID();
alter table posts
            modify column post_key VARCHAR(255) NOT NULL;
alter table posts
            add unique index IDX_post_key (post_key);

