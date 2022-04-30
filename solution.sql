-- 1) Drop column picture from staff.
alter table sakila.staff
drop column picture;
-- 2) A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly

INSERT INTO sakila.staff (first_name,last_name,address_id,email,store_id,active,username,password,last_update)
    SELECT a.first_name,a.last_name,b.address_id,a.email,b.store_id,a.active,'',null,a.last_update
    FROM sakila.customer a 
left join sakila.store b 
on a.store_id = b.store_id
where first_name = 'TAMMY';

-- 3 
insert into sakila.rental(rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
SELECT '2022-04-30 22:53:30',a.inventory_id,b.customer_id,'2022-04-30 22:53:30',c.staff_id,c.last_update
FROM sakila.customer b -- sakila.inventory a 
INNER JOIN sakila.staff c ON c.store_id = b.store_id
INNER JOIN sakila.inventory a ON b.store_id  = a.store_id
where b.first_name = 'CHARLOTTE' and b.last_name = 'HUNTER'
limit 1;

-- test query
select * from sakila.rental
where rental_date = '2022-04-30 15:20:16';

-- 4)Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

CREATE TABLE deleted_users (
  customer_id int UNIQUE NOT NULL,
  email text,
  date datetime DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
) ;

insert into sakila.deleted_users(customer_id,email,date)
select customer_id,email,create_date
from sakila.customer
where active = 0;

delete from customer where account_idactive = 0;