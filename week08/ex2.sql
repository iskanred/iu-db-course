
---------------------- Query 1 ------------------------------------

select film.film_id
from film, film_category, category
where (film.rating = 'R' or film.rating = 'PG-13') and
      (film_category.film_id = film.film_id and
       film_category.category_id = category.category_id and
       (category.name = 'Sci-Fi' or category.name = 'Horror'))
except(
    select distinct rented.film_id
    from (inventory left join rental
    on inventory.inventory_id = rental.inventory_id)
    as rented
);

---------------------- Query 2 ------------------------------------

select max(amount), city.city, id as store_id
from (select sum(last_month.amount) as amount, staff.store_id as id
      from (select *
            from payment
            where payment_date >= (select max(payment_date) from payment) - interval '1 month'
      ) as last_month, staff
      where last_month.staff_id = staff.staff_id
      group by staff.store_id
) as total_amount, store, address as addr, city
where store.store_id = id and
      store.address_id = addr.address_id and
      addr.city_id = city.city_id
group by city.city, id;


-- It's clear that the most expensive operations are
--  joins and appends
-- So, if it is possible it's better for performance not to use them
-- On the other hand, aggregation functions (sum, max, etc.) cannot be interchanged with other solutions
