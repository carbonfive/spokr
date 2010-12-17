alter table posts change column author_info post_info text,
                  drop column binary_content,
                  drop column uri_content;