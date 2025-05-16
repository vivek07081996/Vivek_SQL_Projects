/*
In this SQL project, I have used the dataset named dvdrental, 
which contains 15 tables.
I will first describe the situation, then write the SQL code to solve it, 
in case you want dataset so reach out to me 
*/
--==================================================================================================================================================================================================

-- SQL STATEMENTS 

-- 1 we want to send out a promotional email to our existing Customer using select statment 
SELECT first_name, last_name,email From customer;

-- 2 we want to know the type of unique rating we have in our database use distinct
SELECT DISTINCT rating FROM film;

-- 3 how many customer have the first name jared ? using where
SELECT * FROM customer WHERE first_name = 'Jared';

-- 4 what is the email for the customer name nancy thomas ?
SELECT email FROM customer WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- 5 customer want to know what is the descritpion for the movie outlaw ?
SELECT description FROM film WHERE title ='Outlaw Hanky';

--6 we need to get the phone number for the customer who lives at 259 Ipoh Drive ?
SELECT phone FROM address WHERE address = '259 Ipoh Drive';

--7 A customer wants 5 movie titles which as shortest length of runtime?
SELECT title, length FROM film ORDER BY length ASC LIMIT 5;

--8 customer wants to know how many total movies are less then or equal to 50 length ?
SELECT COUNT(title) FROM film WHERE length <= 50;

--9 How many payment transactions were greater than $5.00?
SELECT COUNT(amount) FROM payment WHERE amount > 5;

--10 How many actors have a first name that starts with the letter P?
SELECT COUNT(*) FROM actor WHERE first_name LIKE 'P%';

--11 How many unique districts are our customers from?
SELECT COUNT(DISTINCT(district))  FROM address;

--12 Retrieve the list of names for those distinct districts?
SELECT DISTINCT(district) FROM address;

--13 How many films have a rating of R and a replacement cost between $5 and $15?
SELECT COUNT(*) FROM film WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

--14 How many films have the word Truman somewhere in the title?
SELECT COUNT(*) FROM film WHERE title LIKE '%Truman%';

--===============================================================================================================================================================================

-- SQL GROUP BY FUNCTIONS

--15 how many payments did each staff member handle and who gets the bonus ?
SELECT staff_id, COUNT(*) FROM payment GROUP BY staff_Id;

--16 what is the average replacement cost per mpaa rating ?
SELECT rating ,ROUND(AVG(replacement_cost))  FROM film GROUP BY rating;

--17 what are the customer ids of the top 5 customers by total spend ?
SELECT customer_id , SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5;

--18 what cutomer_ids are eligible for platinum status?
SELECT customer_id, COUNT(*) FROM payment GROUP BY customer_id HAVING COUNT(*)>=40;

--19 what are the customer ids of customers who have spent more then $100 in payment transactions with our staff_id member 2 ?
SELECT customer_id, SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount)>100;

-- 20 Return the customer IDs of customers who have spent at least $110 with the staff member who has an ID of 2.
SELECT customer_id , SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount) >=110;

--21 How many films begin with the letter J?
SELECT COUNT(*) FROM film WHERE title LIKE 'J%';

--22 What customer has the highest customer ID number whose name starts with an 'E' and has an address ID lower than 500?
SELECT first_name,last_name FROM customer WHERE first_name LIKE 'E%' AND address_id <500 ORDER BY customer_id DESC LIMIT 1;

--==========================================================================================================================================================================================================

-- SQL JOINS 

--1 what are the emails of the customers who live in california ?
SELECT email, district FROM address INNER JOIN customer ON address.address_id = customer.address_id WHERE district = 'California';

--2 get a list of all the movies "Nick Wahlberg" has been in ?
SELECT title,first_name,last_name FROM film_actor INNER JOIN actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film_actor.film_id = film.film_id WHERE first_name = 'Nick'
AND last_name = 'Wahlberg';

--========================================================================================================================================================================================================================

-- ADVANCE SQL COMMAND 

--1 During which month did payments occur?
SELECT DISTINCT(TO_CHAR(PAYMENT_DATE,'month')) FROM payment;

--2 How many payment occured on a Monday ?
SELECT COUNT(*) FROM payment WHERE EXTRACT(dow FROM payment_date) = 1;

--========================================================================================================================================================================================================================
-- CREATING DATABASES AND TABLE

--1 To create the students table
CREATE TABLE students(student_id serial PRIMARY KEY,
first_name VARCHAR(45) NOT NULL,last_name VARCHAR(45) NOT NULL, 
homeroom_number integer,Phone VARCHAR(20) UNIQUE NOT NULL,email VARCHAR(115) UNIQUE,grad_year integer);

--2 To create the teachers table
CREATE TABLE teachers(teacher_id serial PRIMARY KEY,first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL, homeroom_number integer,department VARCHAR(45),email VARCHAR(20) UNIQUE,phone VARCHAR(20) UNIQUE);

--3 inserting the student information
INSERT INTO students(first_name,last_name, homeroom_number,phone,grad_year)VALUES ('Mark','Watney',5,'7755551234',2035);

--4 inserting the teacher information
INSERT INTO teachers(first_name,last_name, homeroom_number,department,email,phone)VALUES ('Jonas','Salk',5,'Biology','jsalk@school.org','7755554321');

--=============================================================================================================================================================================================

-- Conditional Expressions and Procedures Introduction

--1 We want to know and compare the various amounts of film we have per movie rating.
SELECT 
SUM( CASE rating WHEN 'R' THEN 1 ELSE 0 END) AS r,
SUM( CASE rating WHEN 'PG' THEN 1 ELSE 0 END) AS pg,
SUM( CASE rating WHEN 'PG-13' THEN 1 ELSE 0 END) AS pg13 FROM film;

