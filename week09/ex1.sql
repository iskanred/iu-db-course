
-- Returns all addresses which contains '11' and which city_id is between 400 and 600
create or replace function getSpecialAddresses()
    returns setof address as
    $$ begin
        return query
            select *
            from address
            where
                address.address like '%11%' and
                city_id between 400 and 600 ;
    end; $$
    language plpgsql
;

select * from getSpecialAddresses();