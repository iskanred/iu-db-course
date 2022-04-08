
----------------------- Before adding indices ----------------------------------

drop index if exists customer_index1;
drop index if exists customer_index2;

explain analyze select *
                from customer;
-- 4033 346.551 ms
explain analyze select name, count(*) as cnt
                from customer cst
                group by name
                order by cnt;
-- 9606 1073.167 ms
explain analyze select id, name, address, review, id, name, address, review
                from customer cst
                where cst.name = 'Matthew Andrews';
-- 4283 31.150 ms

----------------------- After adding indices BTREE -----------------------------------

drop index if exists customer_index1;
drop index if exists customer_index2;
create index customer_index1 on customer using btree(name);

explain analyze select *
                from customer;
-- 4033 341.568 ms
explain analyze select name, count(*) as cnt
                from customer cst
                group by name
                order by cnt;
-- 9606 1218.807 ms
explain analyze select id, name, address, review, id, name, address, review
                from customer cst
                where cst.name = 'Matthew Andrews';
-- 12 0.233 ms

----------------------- After adding indices HASH -----------------------------------
drop index if exists customer_index1;
drop index if exists customer_index2;
create index customer_index2 on customer using hash(name);

explain analyze select *
                from customer;
-- 4033 381.78 ms
explain analyze select name, count(*) as cnt
                from customer cst
                group by name
                order by cnt;
-- 9606 1048.641 ms
explain analyze select id, name, address, review, id, name, address, review
                from customer cst
                where cst.name = 'Matthew Andrews';
-- 12 0.267 ms

-- Queries which requires fields on which index has been created
--  are much faster (in terms of cost and execution time), other queries
--  are the same

