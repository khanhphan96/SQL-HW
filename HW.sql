#1
use sakila; 

select * from actor; 

select first_name, last_name from actor; 

select concat (first_name,' ', last_name) as Actor_Name from actor; 

#2

select first_name from actor where first_name = 'Joe'; 

select * from actor where actor_id in (select actor_id from actor where last_name in (select last_name from actor where first_name in 
(select first_name from actor where first_name = 'Joe'))); 

select * from actor where last_name in (
select last_name from actor where last_name like '%GEN%'); 

select * from actor where last_name in (
select last_name from actor where last_name like '%LI%'); 

select country, country_id from country where country in ('Afghanistan', 'Bangladesh','China'); 

#3

alter table actor
add description BLOB;

alter table actor drop description;

#4

select last_name, count(*) as NUM from actor group by last_name; 

select last_name, count(*) as NUM from actor group by last_name having NUM >= 2; 

update actor set first_name = 'HARPO', last_name = 'Williams' where first_name = 'GROUCHO' and last_name = 'Williams'; 

update actor set first_name = 'GROUCHO', last_name = 'Williams' where first_name = 'HARPO' and last_name = 'Williams'; 

select first_name from actor where last_name in (
select last_name from actor where last_name = 'Williams'); 

#5 

create schema address; 

#6 

select first_name, last_name from staff;

select first_name, last_name from staff inner join address on staff.address_id = address.address_id;  

select first_name, last_name, sum(payment.amount) from staff 
join payment on staff.staff_id = payment.staff_id group by staff.first_name, staff.last_name;

select title, count(actor_id) as 'actor_count' from film
join film_actor on film.film_id = film_actor.film_id group by film.title;

select count(*) as 'count', title from film inner join inventory on film.film_id = inventory.film_id 
where title = 'Hunchback Impossible';

select first_name, last_name, sum(payment.amount) from  customer join payment on customer.customer_id = payment.customer_id
group by customer.customer_id order by customer.last_name;

#7 

select * from film where language_id having language_id = '1' and title like "Q%" or title like "K%"; 

select first_name, last_name from actor where actor_id in 
(select actor_id from film_actor where film_id in (
select film_id from film where title like 'Alone Trip'));

select first_name, last_name, email from customer inner join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where country = 'CANADA';

Select title from film 
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where name = 'Family';

select title, count(*) as 'rented movies' from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by title order by 'rented movies' desc;

select film.title, count(*) as rental from film 
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id 
group by film.title
order by rental desc;

select store.store_id, sum(payment.amount) as 'dollars' from store 
join inventory on store.store_id = inventory.store_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on payment.rental_id = rental.rental_id
group by store.store_id
order by 'dollars' desc;

select store.store_id, city.city, country.country from store
join address on store.address_id = address.address_id
join city on city.city_id = address.city_id
join country on city.country_id= country.country_id;

select category.name,sum(payment.amount) as 'gross revenue' from payment 
join rental using (rental_id) 
join inventory on rental.inventory_id = inventory.inventory_id
join film_category on inventory.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
group by category.name 
order by 'gross revenue' desc
limit 5;

#8 

create view top_genres as
select category.name ,sum(payment.amount) as 'gross revenue' from payment 
join rental using (rental_id)
join inventory on rental.inventory_id = inventory.inventory_id
join film_category using (film_id)
join category on film_category.category_id = category.category_id
group by category.name 
order by 'gross revenue' desc
limit 5;

select * from top_genres;

drop view top_genres;