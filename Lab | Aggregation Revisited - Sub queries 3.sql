--- Select the first name, last name, and email address of all the customers who have rented a movie.

select first_name, last_name, email
from customer; 

--- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id, avg(p.amount) as average_payment_made, concat(c.first_name, ' ' ,c.last_name) as customer_name
from customer c
inner join payment p on c.customer_id = p.customer_id
group by c.customer_id;

--- Select the name and email address of all the customers who have rented the "Action" movies.
--- Write the query using multiple join statements
select c.email, concat(c.first_name, ' ' ,c.last_name) as customer_name
from customer c
inner join rental r on c.customer_id = r.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join film_category fc on fc.film_id = f.film_id
inner join category ca on fc.category_id = ca.category_id
where ca.name = 'Action'

--- Write the query using sub queries with multiple WHERE clause and IN condition
select concat(first_name, ' ' ,last_name) as customer_name, email from customer where customer_id IN (select customer_id from rental where customer_id IN (select customer_id from rental where inventory_id IN (select inventory_id from inventory where film_id IN (select film_id from film where film_id IN (select film_id from film_category where category_id = (select category_id from category where category_id = 1))))));

--- Verify if the above two queries produce the same results or not
--- they are the same

--- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
select customer_id, amount,
CASE 
	WHEN amount BETWEEN 0 AND 2 THEN 'low'
	WHEN amount BETWEEN 2 AND 4 THEN 'medium'
	WHEN amount > 4 THEN 'high'
END
from payment;

