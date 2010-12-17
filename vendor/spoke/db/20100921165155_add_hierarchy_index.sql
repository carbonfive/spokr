alter table posts add column ancestry varchar(4096) default NULL;

-- works for hierarchies up to 15 levels deep.
update posts set ancestry='/' where parent_id is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;

update posts p join posts par on p.parent_id=par.id set p.ancestry=CONCAT(par.ancestry,par.post_key,'/')
       where p.ancestry is null and not par.ancestry is null;


alter table posts modify ancestry varchar(4096) NOT NULL,
                  add index posts_ancestry (ancestry);
