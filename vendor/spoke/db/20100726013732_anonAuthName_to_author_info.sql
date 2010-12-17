
alter table posts change column anon_author_name author_info text;
update posts set author_info=CONCAT('{name:''',author_info,'''}') where not author_info is null;