-------------------------------------------------------------------------------------------
------------------------------------- DB Assignment 1 -------------------------------------
-------------------------------------------------------------------------------------------
-- Iskander Nafikov B20-02 i.nafikov@innopolis.univeristy ---------------------------------
-------------------------------------------------------------------------------------------


------------------------------------- Exercise 1 ------------------------------------------
create index if not exists rental_btree_query1 on rental using btree(
    last_update, rental_id, customer_id , staff_id
) with (fillfactor = 25);
-------------------------------------------------------------------------------------------


------------------------------------- Exercise 2 ------------------------------------------
create index if not exists film_btree_query2 on film using btree (
    release_year, rental_rate
);
-------------------------------------------------------------------------------------------


------------------------------------- Exercise 3 ------------------------------------------
create index if not exists rental_btree1_query3 on rental using btree (
    customer_id
);
create index if not exists rental_btree2_query3 on rental using btree (
    customer_id, inventory_id
);
create index if not exists rental_btree3_query3 on rental using btree (
    inventory_id, customer_id, rental_id
);

create index if not exists payment_rental_id_query3 on payment using hash (
    rental_id
);

create index if not exists inventory_btree1_query3 on inventory using btree (
    film_id, inventory_id
);

create index if not exists film_btree1_query3 on film using btree(
    film_id, title, release_year
) where rating='PG-13' or rating='NC-17';

create index if not exists film_actor_btree_query3 on film_actor using btree (
    film_id, actor_id
);

create index if not exists customer_first_name_query3 on customer using hash (
    first_name
);
-------------------------------------------------------------------------------------------
