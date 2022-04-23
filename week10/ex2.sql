create table if not exists accounts_ex2(
    username text ,
    fullname text ,
    balance integer ,
    group_id integer
);

insert into accounts_ex2 values
    ('jones', 'Alice Jones', 82, 1),
    ('bitdiddl', 'Ben Bitdiddle', 65, 1),
    ('mike', 'Michael Dole', 73, 2),
    ('alyssa', 'Alyssa P.Hacker', 79, 3),
    ('bbrow', 'Bob Brown', 100, 3)
;
