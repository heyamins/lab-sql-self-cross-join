

-- Get all pairs of actors that worked together.
select f1.actor_id ActorID, f2.actor_id ActorID_Pair, f1.film_id from film_actor f1
join film_actor f2
on f1.film_id = f2.film_id
and f1.actor_id <> f2.actor_id
order by f1.actor_id;

-- Get all pairs of customers that have rented the same film more than 3 times.
select * from rental;
select * from inventory;

-- Sort customers who rented same movies for 3times or more

select customer_id, film_id, count(*)  from rental r
left join inventory i
on r.inventory_id = i.inventory_id
group by customer_id, film_id
having count(*) > 2
order by film_id, customer_id;

-- find combination of those customers

select fc1.customer_id cus1, fc2.customer_id cus2, fc1.film_id film_id from 
(select customer_id, film_id, count(*)  from rental r left join inventory i on r.inventory_id = i.inventory_id group by customer_id, film_id 
having count(*) > 2 order by film_id, customer_id) fc1
join 
(select customer_id, film_id, count(*)  from rental r left join inventory i on r.inventory_id = i.inventory_id group by customer_id, film_id
having count(*) > 2
order by film_id, customer_id) fc2
on fc1.customer_id <> fc2.customer_id
order by cus1, cus2, film_id;

-- Get all possible pairs of actors and films.
drop temporary table if exists actors;
drop temporary table if exists films;
-- always good to add above clause
create temporary table actors
select concat(first_name,"  ", last_name) name from actor;

create temporary table films
select title from film;

-- answer
select * from actors
cross join films
order by name;

