-- Cross and Self Joins

-- Self Joins:
-- Allows you to join a table to itself, useful when comparing rows within the same table.
-- You use it if you have two or more different values in the same column, but you want to display them in different columns and in the same row.
-- More examples: https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/

-- Find the customers that are from the same district:
select * from bank.loan;

select * from bank.account a1
join bank.account a2
on a1.account_id <> a2.account_id -- the same as != (not equal to)
and a1.district_id = a2.district_id
order by a1.district_id, a1.account_id,a2.account_id;

select * from bank.account a1
join bank.account a2
on a1.district_id = a2.district_id
order by a1.district_id, a1.account_id,a2.account_id;

-- Find the accounts that have both OWNER and DISPONENT:
select * from disp;

select * from bank.disp d1
join bank.disp d2
on d1.account_id = d2.account_id
and d1.type <> d2.type
where d1.type = 'DISPONENT';


-- Cross Joins:
-- Used when you wish to create a combination of every row from two tables:
-- (A, B, C) x (1, 2): (A, 1), (A, 2), (B, 1), (B, 2), (C, 1), (C, 2)

-- Find all the combinations of different card types and ownership of account:
create temporary table card_type
select distinct type from bank.card;

create temporary table disp_type
select distinct type from bank.disp;

select * from card_type
cross join disp_type;

-- Intro to subqueries.