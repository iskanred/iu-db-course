drop function if exists retrievecustomers(integer, integer);

create or replace function retrievecustomers(
    from_id integer,
    to_id integer
)
returns setof customer as
$func$ begin
    if (from_id not between 0 and 600 or to_id not between 0 and 600) then
        raise exception 'from_id and to_id parameters must be in range [0, 600], but got: from_id = %, to_id = %', from_id, to_id ;
    end if;
    return query
        select *
        from customer
        where
            customer.id between from_id and to_id
        order by customer.id ;
end $func$
language plpgsql
;

select * from retrievecustomers(20, 30); -- success
select * from retrievecustomers(-1, 605); -- error