USE sakila_warehouse;

DELETE FROM customer;
INSERT INTO customer(customer_id, first_name, last_name, active, country, city, postal_code)
	SELECT customer_id, first_name, last_name, active, country, city, postal_code
		FROM sakila.customer
		INNER JOIN sakila.address ON sakila.customer.address_id = sakila.address.address_id
        INNER JOIN sakila.city ON sakila.address.city_id = sakila.city.city_id
        INNER JOIN sakila.country ON sakila.city.country_id = sakila.country.country_id
        ;

DELETE FROM staff;
INSERT INTO staff(staff_id, first_name, last_name, store_id)
	SELECT staff_id, first_name, last_name, store_id
		FROM sakila.staff
        ;

DELETE FROM store;
INSERT INTO store(store_id, manager_staff_id, country)
	SELECT store_id, manager_staff_id, country
		FROM sakila.store
        INNER JOIN sakila.address ON sakila.store.address_id = sakila.address.address_id
        INNER JOIN sakila.city ON sakila.address.city_id = sakila.city.city_id
        INNER JOIN sakila.country ON sakila.city.country_id = sakila.country.country_id
        ;
        
DELETE FROM film_actor;
DELETE FROM film;
INSERT INTO film(film_id, title, length, replacement_cost, category_name)
	SELECT sakila.film.film_id, title, length, replacement_cost, name
		FROM sakila.film
        INNER JOIN sakila.film_category ON sakila.film_category.film_id = sakila.film.film_id
        INNER JOIN sakila.category ON sakila.category.category_id = sakila.film_category.category_id
        ;

INSERT INTO film_actor(actor_id, film_id, first_name, last_name)
	SELECT sakila.film_actor.actor_id, film_id, first_name, last_name
		FROM sakila.film_actor
        INNER JOIN sakila.actor ON sakila.actor.actor_id = sakila.film_actor.actor_id
        ;

DELETE FROM fact;
INSERT INTO fact(rental_id, customer_id, film_id, staff_id, store_id, rental_date, return_date, rental_duration, amount, rental_rate)
	SELECT sakila.rental.rental_id, sakila.rental.customer_id, sakila.inventory.film_id, sakila.rental.staff_id, store_id, rental_date, return_date, rental_duration, amount, rental_rate
		FROM sakila.rental
        INNER JOIN sakila.inventory ON sakila.rental.inventory_id = sakila.inventory.inventory_id
        INNER JOIN sakila.film ON sakila.inventory.film_id = sakila.film.film_id
        INNER JOIN sakila.payment ON sakila.rental.rental_id = sakila.payment.rental_id
        ;
