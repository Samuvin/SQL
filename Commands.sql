--Every sql query ends with ; or else 
--SQL comments can be written in CAPITAL LETTER best practice
--SQL is not case sensitive 

CREATE DATABASE IMDB; --create Database 
USE imdb;             --Chaging Database tells mysql what database to use
SOURCE C:\Users\ASUS\Downloads\imdb.sql  -- Load dataset

SHOW databases;    -- used to see all available databases
SHOW TABLES;       -- used to see all available tables

DESCRIBE actors    --Used to describe the Table COMMENT
DESCRIBE <table_name>

\! cls  -- Clear the screen

--List all the movies in the database
SELECT * from movies;
--more data transfer 
--SELECT x  from movies;
-- x columns(1 or more) that i need 
-- * all columns
-- table name movies

--If we only want name and year
SELECT name,year from movies;
--Query optimiser handle how to get it we just say whant we want

--Generate some output which is called the result set
--set of rows with column names

-- * return all the colums the returns data will be more so we use only rare *
-- we can specify the column names that we required

--result-set : a set of rows that form the result of a query along with column-names and meta data
--meta-data  : data about the data
--column name is also a meta data

--order of columns is as same as of the table
--my order of column name can be anything but when we run this will be as we given in the query

SELECT rankscore,name FROM movies;

--The order in which the rows appear will be as that present in the tables (row order preservation) for simple queries


--For each page we need to print the 20 movies when we press the next button if we click on this we print next 20 we need to return the data 20 by 20

--LIMIT keyword
SELECT name,rankscore FROM movies LIMIT 20;
--The number of rows that we limit to

SELECT name,rankscore FROM movies LIMIT 20 OFFSET 40;
--The number of row that we limit to but we have to skip first 40;
--It will ignore the first 40 rows

--ORDER BY
SELECT name,rankscore,year FROM movies ORDER BY year DESC LIMIT 10;
--will give top 10 movies


--Sorted by descending order based on the year and limited it by 20
SELECT name,rankscore,year FROM movies ORDER BY year DESC LIMIT 10;

--If dont mention desc the default sorting order is asce

mysql> SELECT name,rankscore,year FROM movies ORDER BY year LIMIT 10;

--ORDER BY:
--Sorting happens by one column values
--The output row order may not be same as the one in the table due to query optimizer / data structures / indices will change it


--DISTINCT keyowrd
--can be applied to one or more columns

SELECT DISTINCT genre FROM movies_genres;
--will return unique genres
SELECT DISTINCT genre FROM movies_genres;z

SELECT DISTINCT first_name, last_name FROM directors ORDER BY first_name;
--will return the first_name and last_name should be unique



--WHERE 
--list all movies with rankscore
--pick based on a column name

SELECT name,year,rankscore FROM movies WHERE rankscore>9;

SELECT name,year,rankscore FROM movies WHERE rankscore>9 ORDER BY rankscore DESC LIMIT 20;

-- Conditions output should be boolean:TRUE FALSE NULL

--Comparison operator
-- = ( <> or != ) < <= >= >

SELECT * FROM movies_genres WHERE genre='Comedy';

SELECT * FROM movies_genres WHERE genre<>'Comedy';
SELECT * FROM movies_genres WHERE genre!='Comedy';


NULL => does notexit / unkown/missing

-- "=" does not work with NULL will give and empty result set

SELECT name,year,rankscore FROM movies WHERE rankscore=NULL;

-- To work with NULL
SELECT name,year,rankscore FROM movies WHERE rankscore is NULL LIMIT 20;

--LOGICAL OPERATORS
--AND OR NOT ALL ANY BETWEEN EXISTS IN LIKE SOME
--Real world Application
SELECT name,year,rankscore FROM movies WHERE rankscore>9 AND year>2000;

SELECT name,year,rankscore FROM movies WHERE NOT year<=2000 LIMIT 20;

SELECT name,year,rankscore FROM movies WHERE rankscore>9 OR year>2007;

SELECT name,year,rankscore FROM movies WHERE year BETWEEN 1999 AND 2000;
--year >=1999 and year<=2000 Inclusive
--low value 
--high value
--if we invert them it will not work
--low value should be lesser than or equal to high

SELECT director_id,genre FROM directors_genres WHERE genre IN ('Comedy','Horror');


--Like
--Wild character to imply zero or more characters
SELECT name,year,rankscore FROM movies WHERE name LIKE 'Tis%';
-- % wild card where it can be one or more character or empty


--Ends with %
SELECT first_name,last_name from actors WHERE first_name LIKE '%es';

--To match one character -
SELECT first_name,last_name from actors WHERE first_name LIKE 'Agn_s'; 


--SELECT * from T WHERE percentage='96%';
-- '96%' Compiler will interpret as wild card
-- To do this we can use escape character
-- percenteage='96\%'

--SELECT * FROM T WHERE email='n1_abc@gmail.com'
-- - will treat it as wild card
-- to treat it as symbol
--SELECT * FROM T WHERE email='n1\_abc@gmail.com'



--AGGREGATE FUNCTIONS
-- COUNT MIN MAX SUM AVG


--COUNT: how many rows
SELECT COUNT(*) FROM movies;
SELECT COUNT(*) FROM movies WHERE year>2000;


--SUM: total of all values
SELECT SUM(rankscore) FROM movies;

--MIN: smallest value
SELECT MIN(rankscore) FROM movies;

--MAX: largest value
SELECT MAX(rankscore) FROM movies;

--AVG: average value
SELECT AVG(rankscore) FROM movies;


--GROUP BY: to group rows that have the same values in a column
--Find the number of movies released per year

SELECT year,COUNT(year) FROM movies GROUP BY year;
SELECT year,COUNT(year) FROM movies GROUP BY year ORDER BY year

--alias alternate name;
SELECT year,COUNT(year) year_count FROM movies GROUP BY year ORDER BY year_count;

--alias often used by COUNT MIN MAX or sum
--if grouping columns contains NULL values all NULL values or grouped together


--HAVING:
--print years which have >1000 moviues in our DB
SELECT year,COUNT(year) year_count FROM movies GROUP BY year HAVING year_count>1000;

--Having will apply on the group

--Order of Execution
--Apply Group Group by to create groups
--Aggregation Functions 
--Alias
--Each Group apply the having conditon

--Having is often used with group by , Not mandatory
SELECT name,year FROM movies HAVING year>2000;
--Having without group by is same as where


--Having vs WHERE
--Where is applied on individual rows while Having is applied on groups
--Having is applied after grouping while where is used before groups
--Where before grouping 
--Having after grouping

SELECT year,COUNT(year)year_count FROM movies WHERE rankscore>9 GROUP BY year HAVING year_count>20;

--Order of Execution  
--Where
--Group By
--Aggregation
--Alias
--Having


--Order of Execution
--ALL | DISTINCT | DISTINCTION
--FROM
--WHERE
--GROUP BY
--HAVING
--ORDER BY
    --ASC DESC
--LIMIT


--Joins

--Combine data in multiple tables
--For each movie print name and the genres
SELECT m.name,g.genre FROM movies m JOIN movies_genres g ON m.id=g.movie_id LIMIT 20;
--m.name m is alias to movies  table alias
--JOIN join the movies tables with the genre table how to combine tha tables condition where m.id=g.movie_id
--JOIN cross product using the condition given
--INNER JOIN

--Natural JOINS
--A join where we have the same column-names across two tables
--T1: C1,C2
--T2: C1,C2,C3
--Columns names are same we can use join these two tables 
SELECT * from T1 JOIN T2;
--Equivalent for saying T1.C1=T2.C1
--It will automatically joined using NATURAL JOIN
SELECT * from T1 JOIN T2 USING (C1);
--return C1,C2,C3,C4
--no need to use keyword "ON"


--LEFT OUTER JOIN
--T1: C1,C2,C3
--T2: C4,C5,C6
SELECT * FROM T1 JOIN T2 ON T1.C1=T2.C4; 

SELECT * FROM T1 LEFT OUTER JOIN T2 ON T1.C1=T2.C4;
--Same as inner join but in left outer join it will also add
--those tuple that fails the condition remaining columns will be filled with null
LEFT JOIN or LEFT OUTER JOIN

--RIGHT OUTER JOIN
--T1: C1,C2,C3
--T2: C4,C5,C6
SELECT * FROM T1 RIGHT OUTER JOIN T2 ON T1.C1=T2;
--Same as inner join but in right outer join it will also add 
--tables that fails the condition remaining columns will be filled with null

--FULL OUTER JOIN
SELECT * FROM T1 FULL OUTER JOIN T2 ON T1.C1=T2;
--Same as inner join but it will also add the tuples that failed the condition
--And remaining columns will be filled with null


SELECT m.name,g.genre FROM movies m LEFT JOIN movies_genres g ON m.id=g.movie_id LIMIT 20;


--3way join
SELECT a.first_name, a.last_name 
FROM actors a 
JOIN roles r ON a.id = r.actor_id 
JOIN movies m ON m.id = r.movie_id 
WHERE m.name = 'Officer 444';


--Subqueries

--List all actors in the movie Harry Potter

SELECT first_name, last_name 
FROM actors 
WHERE id IN (
    SELECT actor_id 
    FROM roles 
    WHERE movie_id IN (
        SELECT id 
        FROM movies 
        WHERE name = 'Avengers'
    )
);


--Syntax
SELECT colum_name [,colum_name]
FROM table1[,table1]
Where colum_name OPERATOR
(SELECT column_name FROM[,column_name]
 FROM table1,[table1,]
 [WHERE]
)

--OPERATORS
--IN NOT IN EXISTS NOT EXISTS ANY ALL 
--Exists -- The subquery if returns null no records else it will give the whole record
--ALL    
SELECT * FROM movies where rankscore>= ALL (
SELECT MAX(rankscore) from movies)


--Correlated subquery
SELECT employee_name,name
FROM employees emp 
WHERE salary>(
    SELECT AVG(salary) FROM employees
    WHERE department=emp.department
)

--Correlated subquery because the inner query runs for every tuple for the outer query
--For each tuple the inner query will run
--Costly



--Data Manipulation Language

INSERT INTO movies (id,name,year,rankscore) VALUES(2134,'Thor',2011,7);
INSERT INTO movies(id,name,year,rankscore) VALUES (412321.'Thor',2011,7),(42432,'Iron Man',2008,7.9),(432432,'Iron Man 2',2010,7);

--Can insert data from other table using nessted query
INSERT INTO phone_book2
SELECT * FROM phone_book2
WHERE name IN ('John Doe','Peter Doe');

--Update and delete
UPDATE <Table_name> SET col1=val1,col2=val2 WHERE condition

UPDATE movies SET rankscore=9 where id=412321;

--Update Multiple rows
--Suquery

--DELETE

DELETE FROM movies WHERE id=1323;



--DATA DEFINITION TABLE


CREATE TABLE language(id INT PRIMARY KEY,lang VARCHAR(50) NOT NULL);
+\7``NOT NULL     - Ensures that a column cannot have a NULL value 
UNIQUE       - Ensure that all values in a column are different it can contains null
PRIMARY KEY  - A combination of a NOT NULL and UNIQUE .uniquely identifies each row in a table
FOREIGN KEY  - Uniquely identifies a row/record in another tablle
DEFAULT      - Sets a default value for a column when no value is specified  
INDEX        - Used to c reate and retrive data from database very quickly

--remoev all rows
TRUNCATE TABLE tablename;

--Same as select without a where clause

--Data type 
--https://medium.com/baakademi/sql-data-types-7fc5a1851eb1
