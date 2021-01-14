USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:
-- 1. 
SELECT
	COUNT(*)
FROM
	director_mapping;
    
-- 2. 
SELECT 
    COUNT(*)
FROM
    genre;
    
-- 1. 
SELECT
	COUNT(*)
FROM
	movie;
    
-- 1. 
SELECT
	COUNT(*)
FROM
	names;

-- 1. 
SELECT
	COUNT(*)
FROM
	ratings;
    
-- 1. 
SELECT
	COUNT(*)
FROM
	role_mapping;
    
/*
Ans
1. director_mapping => 3867
2. genre => 14662
3. movie => 7997
4. names => 25735
5. ratings => 7997
6. role_mapping => 15615
*/








-- Q2. Which columns in the movie table have null values?
-- Type your code below:
SELECT
	SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS title,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year,
    SUM(CASE WHEN date_published IS NULL THEN 1 ELSE 0 END) AS date_published,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS duration,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country,
    SUM(CASE WHEN worldwide_gross_income IS NULL THEN 1 ELSE 0 END) AS worldwide_gross_income,
    SUM(CASE WHEN languages IS NULL THEN 1 ELSE 0 END) AS languages,
    SUM(CASE WHEN production_company IS NULL THEN 1 ELSE 0 END) AS production_company
FROM
	movie;
    
/*
Ans. Columns with NULL values are
1. worldwide_gross_income => 3724
2. production_company => 528
3. languages => 194
4. country => 20

Observations:
- Column 'worldwide_gross_income' seems to have highest number of NULL values which might be because 
	those movies were never released in foreign countries.
- Column 'production_company' 'languages' and 'country' seems to have suspiciously missing values because without such
	information no movie neither can be released or produced. 
*/








-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- First Part
SELECT
	year AS Year,
    COUNT(id) as number_of_movies
FROM
	movie
GROUP BY
	Year;
    
-- Second Half
SELECT
	MONTH(date_published) AS month_num,
    COUNT(title) as number_of_movies
FROM
	movie
GROUP BY
	month_num
ORDER BY
	month_num;
    
/*
Ans.
1. 
Year   number_of_movies
2017	    3052
2018	    2944
2019	    2001

2.
month_num number_of_movies
     1	        804
     2	        640
     3	        823
     4	        680
     5	        624
     6	        579
     7	        492
     8	        677
     9	        807
    10	        801
    11	        625
    12	        437

Observations:
- Year 2017 seems to have highest number movie produced with 3036 movies.
- After year 2017, the numbers of movies produced per year for 2018 and 2019 respectively seems to decrease 
	constantly now below 2000 movies per year in 2019.
- Whereas if we try to observe for the movies produced per month for years 2017, 2018 and 2019 combined than
	month of March seems to have highest number of movies produced and released.
- Also, we can see that month of December seems to have lowest number of movies produced for all three year combined,
	this might be because of the bad light and low temperature which reduces working speed.  
*/








/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT
    COUNT(id) AS no_of_movies
FROM
	movie
WHERE
	country='INDIA' OR country='USA' AND year = 2019;
    
/*
Number of movies produced in India and USA are 1599 in year 2019

Observation:
- The reason behind this could be the popularity of movies made in Bollywood(India) and Hollywood(USA)
*/








/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:
SELECT
	DISTINCT genre
FROM
	genre
ORDER BY
	genre;

/*
Ans.
Action
Adventure
Comedy
Crime
Drama
Family
Fantasy
Horror
Mystery
Others
Romance
Sci-Fi
Thriller

Observations:
- These are the some common genre on which almost all movies are produced and loved by people of different countries.
- Combo of some genres from this list can help RSVP Movies to produce a Super Hit movie. 
*/





/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:
SELECT
    genre,
    COUNT(movie_id) AS no_of_movie_per_genre
FROM
	genre
GROUP BY
	genre
ORDER BY
	COUNT(movie_id) DESC;

/*
genre      no_of_movie_per_genre
--------------------------------
Drama	        4285
Comedy	     	2412
Thriller		1484
Action			1289
Horror			1208
Romance			906
Crime			813
Adventure		591
Mystery			555
Sci-Fi			375
Fantasy			342
Family			302
Others			100

Observations:
- Drama, Comedy, Thriller, Action and Horror seems to be top five genres on which most of the movies were produced.
- These five genres can definetly proof to be profitable if movies are based on these.
*/









/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:
SELECT 
	COUNT(*) AS no_of_movies_with_one_genre
FROM 
	genre g1
WHERE 
	NOT EXISTS
    (
		SELECT 1 
        FROM 
			genre g2 
		WHERE 
			g2.movie_id = g1.movie_id 
            AND 
            g2.genre <> g1.genre
	);
/*
+---------------------------+
|no_of_movies_with_one_genre|
+---------------------------+
|			3289            |
+---------------------------+

Observation:
- Their are many movies produced based on only one genre but we can't say how many of them had success in winning hearts of 
	audiance.
*/




/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT
	g.genre,
    ROUND(AVG(m.duration),2) AS avg_duration
FROM
	genre AS g
    JOIN
    movie AS m
		ON
        g.movie_id = m.id
GROUP BY
	g.genre
ORDER BY
	avg_duration DESC;

/*
Ans.
genre		avg_duration
Action			112.88
Romance			109.53
Crime			107.05
Drama			106.77
Fantasy			105.14
Comedy			102.62
Adventure		101.87
Mystery			101.80
Thriller		101.58
Family			100.97
Others			100.16
Sci-Fi			97.94
Horror			92.72

Observations:
- On average 'Action' genre seems to be first choice of the movie Producers and Production Companies. So, I think RSVP
	Movies can have more focus towards Action genre to produce profitable movies.
- For conclsuive results let's observe does audience things in similar manner or not.
*/
    









/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT
	g.genre,
    COUNT(m.id) AS movie_count,
    ROW_NUMBER() OVER(ORDER BY COUNT(m.title) DESC) 'genre_rank'
FROM
    genre AS g
    JOIN
    movie AS m
		ON
        g.movie_id = m.id
GROUP BY
	g.genre;

/*
Ans.
genre	movie_count	genre_rank
Drama		4285		1
Comedy		2412		2
Thriller	1484		3
Action		1289		4
Horror		1208		5
Romance		906			6
Crime		813			7
Adventure	591			8
Mystery		555			9
Sci-Fi		375			10
Fantasy		342			11
Family		302			12
Others		100			13

Observations:
- Thriller genre seems to be 3rd most focused genre by movies makers.
- But Drama and Comdey lead in number of movies based on them.
- So again as per these results Drama, Action, Horror, Comedy and Romance should be the options for RSVP Movies to make
	movies based on them.
*/







/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:
SELECT
	MIN(avg_rating) AS min_avg_rating,
    MAX(avg_rating) AS max_avg_rating,
    MIN(total_votes) AS min_total_votes,
	MAX(total_votes) AS max_total_votes,
    MIN(median_rating) AS min_median_rating,
	MAX(median_rating) AS max_median_rating
FROM
	ratings;
    
/*
|min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
	1.0				10.0				 100					725138				   1			  10
*/



    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too
WITH movie_rank_info
AS
(
SELECT
	m.title,
    r.avg_rating,
    DENSE_RANK() OVER(ORDER BY r.avg_rating DESC) AS movie_rank
FROM
	movie AS m
    JOIN
    ratings AS r
		ON
		m.id = r.movie_id
)
SELECT *
FROM
	movie_rank_info
WHERE
	movie_rank <= 10;
    
/*
Ans.
+-------------------------------------------------------------------------------------------+
|	title 															avg_rating 	movie_rank  |
+-------------------------------------------------------------------------------------------+    
	Kirket																10.0		1
	Love in Kilnerry													10.0		1
	Gini Helida Kathe													9.8			2
	Runam																9.7			3
	Fan																	9.6			4
	Android Kunjappan Version 5.25										9.6			4
	Yeh Suhaagraat Impossible											9.5			5
	Safe																9.5			5
	The Brighton Miracle												9.5			5
	Shibu																9.4			6
	Our Little Haven													9.4			6
	Zana																9.4			6
	Family of Thakurganj												9.4			6
	Ananthu V/S Nusrath													9.4			6
	Eghantham															9.3			7
	Wheels																9.3			7
	Turnover															9.2			8
	Digbhayam															9.2			8
	Tõde ja õigus														9.2			8
	Ekvtime: Man of God													9.2			8
	Leera the Soulmate													9.2			8
	AA BB KK															9.2			8
	Peranbu																9.2			8
	Dokyala Shot														9.2			8
	Ardaas Karaan														9.2			8
	Kuasha jakhon														9.1			9
	Oththa Seruppu Size 7												9.1			9
	Adutha Chodyam														9.1			9
	The Colour of Darkness												9.1			9
	Aloko Udapadi														9.1			9
	C/o Kancharapalem													9.1			9
	Nagarkirtan															9.1			9		
	Jelita Sejuba: Mencintai Kesatria Negara							9.1			9
	Shindisi															9.0			10
	Officer Arjun Singh IPS												9.0			10
	Oskars Amerika														9.0			10
	Delaware Shore														9.0			10
	Abstruse															9.0			10
	National Theatre Live: Angels in America Part Two - Perestroika		9.0			10
	Innocent															9.0			10

Obervations:
- As we can see some Indian movies in the list with high avgerage ratings, so some inputs can be generated from those
	movies like what should be the genre, cast, duration, etc for RSVP Movies
*/




/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have
SELECT
	median_rating,
    COUNT(movie_id) AS movie_count
FROM
	ratings
GROUP BY
	median_rating
ORDER BY
	median_rating;

/*
Ans:
+---------------+-------------------+
| median_rating	|	movie_count		|
+---------------+-------------------+
	1				94
	2				119
	3				283
	4				479
	5				985
	6				1975
	7				2257
	8				1030
	9				429
	10				346
    
Observations:
- Number of movies are rated(median rating) with 7, 6, 8 and 5
*/








/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:
SELECT
	m.production_company,
    COUNT(m.id) AS movie_count,
    DENSE_RANK() OVER(ORDER BY COUNT(m.id) DESC) AS prod_company_rank
FROM
	movie AS m
    JOIN
    ratings AS r
		ON
        m.id = r.movie_id
WHERE
	r.avg_rating > 8
GROUP BY
	m.production_company;
	
/*
NULL						21	1
Dream Warrior Pictures		3	2
National Theatre Live		3	2
Lietuvos Kinostudija		2	3
Swadharm Entertainment		2	3
Panorama Studios			2	3
Marvel Studios				2	3
Central Base Productions	2	3
Painted Creek Productions	2	3
National Theatre			2	3
Colour Yellow Productions	2	3
The Archers					1	4
Blaze Film Enterprises		1	4
Bradeway Pictures			1	4
Bert Marcus Productions		1	4
A Studios					1	4
*/







-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT
	g.genre,
    COUNT(m.id) AS movie_count
FROM
	movie AS m
	JOIN
    genre AS g	
		ON
        m.id = g.movie_id
			JOIN
            ratings AS r
				ON
                g.movie_id = r.movie_id
WHERE
	MONTH(m.date_published) = 4 
		AND 
			m.year = 2017 
				AND  
					m.country = 'USA' 
						AND
							r.total_votes > 1000
GROUP BY
	g.genre
ORDER BY
	movie_count DESC;

/*
genre		movie_count
Drama			15
Comedy			13
Horror			5
Sci-Fi			5
Thriller		4
Adventure		4
Romance			4
Action			4
Mystery			4
Crime			2

Observations:
- Movies based on Drama and Comedy genre are liked by most people in the USA in year 2017
- Least liked genre is Crime
*/							
    








-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
SELECT
	m.title,
    r.avg_rating,
    g.genre
FROM
	movie AS m
    JOIN
	genre AS g
		ON
		m.id = g.movie_id
			JOIN
            ratings AS r
				ON
                g.movie_id = r.movie_id
WHERE
	m.title LIKE 'The%'
    AND
    r.avg_rating > 8;

/*
| title									|		avg_rating		|		genre	      |
The Blue Elephant 2								   	8.8					Drama
The Blue Elephant 2									8.8					Horror
The Blue Elephant 2									8.8					Mystery
The Brighton Miracle								9.5					Drama
The Irishman										8.7					Crime
The Irishman										8.7					Drama
The Colour of Darkness								9.1					Drama
Theeran Adhigaaram Ondru							8.3					Action
Theeran Adhigaaram Ondru							8.3					Crime
Theeran Adhigaaram Ondru							8.3	    			Thriller
The Mystery of Godliness: The Sequel				8.5					Drama
The Gambinos										8.4					Crime
The Gambinos										8.4					Drama
The King and I										8.2					Drama
The King and I										8.2					Romance

*/

SELECT
	m.title,
    r.median_rating,
    g.genre
FROM
	movie AS m
    JOIN
	genre AS g
		ON
		m.id = g.movie_id
			JOIN
            ratings AS r
				ON
                g.movie_id = r.movie_id
WHERE
	m.title LIKE 'The%'
    AND
    r.avg_rating > 8;

/*
The Blue Elephant 2	10	Drama
The Blue Elephant 2	10	Horror
The Blue Elephant 2	10	Mystery
The Brighton Miracle	10	Drama
The Irishman	9	Crime
The Irishman	9	Drama
The Colour of Darkness	10	Drama
Theeran Adhigaaram Ondru	9	Action
Theeran Adhigaaram Ondru	9	Crime
Theeran Adhigaaram Ondru	9	Thriller
The Mystery of Godliness: The Sequel	9	Drama
The Gambinos	10	Crime
The Gambinos	10	Drama
The King and I	8	Drama
The King and I	8	Romance
*/





-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:
SELECT
	COUNT(r.movie_id) 'total_movies_with_median_rating_8'
FROM
	ratings AS r
    INNER JOIN
    movie AS m
		ON
		r.movie_id = m.id
WHERE
	m.date_published BETWEEN "2018-04-01" AND "2019-04-01"
    AND
    r.median_rating = 8;

/*
total_movies_with_median_rating_8 => 361
*/






-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:
SELECT
	m.languages,
    SUM(r.total_votes)/COUNT(m.languages) AS votes
FROM
	movie AS m
	JOIN
	ratings AS r
		ON
		m.id = r.movie_id
WHERE
	 m.languages = 'Italian' OR m.languages='German'
GROUP BY
	m.languages
ORDER BY
	 SUM(r.total_votes)/COUNT(m.languages) DESC;

/*
Italian	898.6875
German	721.6727
*/





-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
SELECT
	SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_nulls,
    SUM(CASE WHEN height IS NULL THEN 1 ELSE 0 END) AS height_nulls,
    SUM(CASE WHEN date_of_birth IS NULL THEN 1 ELSE 0 END) AS date_of_birth_nulls,
    SUM(CASE WHEN known_for_movies IS NULL THEN 1 ELSE 0 END) AS known_for_movies_nulls
FROM
	names;
	
/*
Ans.
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|		17335		|	      13431		  |	   15226	    	 |
+---------------+-------------------+---------------------+----------------------+

Observations:
- Fields with NULL seems to be genuine and not mistake while inserting the data
*/






/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT
	name,
    COUNT(m.id) AS movie_count,
    avg_rating
FROM
	names AS n
    INNER JOIN
    director_mapping AS dm
		ON
        n.id = dm.name_id
        INNER JOIN
		movie AS m
			ON
            dm.movie_id = m.id
            INNER JOIN
			genre AS g
				ON
                m.id = g.movie_id
                INNER JOIN
                ratings AS r
					ON
                    g.movie_id = r.movie_id
WHERE
	r.avg_rating > 8
GROUP BY
	name
ORDER BY
	movie_count DESC
LIMIT 3;

/*
+------------------------------------+
| 	name	  |movie_count|avg_rating|
+------------------------------------+
|Joe Russo	  |		6	  |	  8.5    |
|Anthony Russo|		6	  |	  8.5    |
|James Mangold|		5	  |   8.3    |
+------------------------------------+

Observations
- Joe Russo, Anthony Russo and James Mangold, amongst these three any one can selected to direct their movies in the list by
	RSVP Movies as these are most successful Directors in the given data with most hit movies as per avg_rating.
*/






/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
SELECT
	name,
    COUNT(m.id) AS movie_count
FROM
	names AS n
    INNER JOIN
    role_mapping AS rm
		ON
        rm.name_id = n.id
        INNER JOIN
		movie AS m
			ON
            rm.movie_id = m.id
            INNER JOIN
            ratings AS r
				ON
                m.id = r.movie_id
WHERE
	category = 'actor' AND r.median_rating >= 8
GROUP BY
	name
ORDER BY
	movie_count DESC
LIMIT 2;

/*
+---------------------------------+
|	  name		|	movie_count	  | 
+---------------------------------+
|	Mammootty	|		8		  |
|	Mohanlal	|		5		  |
+---------------------------------+

Observations:
- Mammootty or Mohanlal can be choosen as the next co-actor for the next RSVP Movies movie as they have most hit movies in
	the data with median_rating more than 8 or 8 rating.
*/




/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
WITH movie_list 
AS
(
SELECT
	m.production_company,
    SUM(r.total_votes) AS vote_count,
    DENSE_RANK() OVER(ORDER BY SUM(r.total_votes) DESC) AS prod_comp_rank
FROM
	movie AS m
	INNER JOIN
	ratings AS r
		ON
		m.id = r.movie_id
GROUP BY
	m.production_company
)
SELECT *
FROM
	movie_list
WHERE
	prod_comp_rank < 4;

/*
+----------------------+--------------+---------------------+
|  production_company  |  vote_count  |	   prod_comp_rank   |
+----------------------+--------------+---------------------+
 Marvel Studios				2656967				1
 Twentieth Century Fox		2411163				2
 Warner Bros.				2396057				3
+-----------------------------------------------------------+

Observations:
- Movies made by production companies like Marvel Studios, Twentieth Century Fox and Warner Bros. can studied to make some
	super hit and highly profitable movies.
- RSVP Movies can also make movies with any top three production company mentioned above (if possible) for highly profitable
	movies.
*/






/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
WITH actor_info AS
(
SELECT
	name 'actor_name',
	SUM(total_votes),
    COUNT(m.id) 'movie_count',
    ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2) 'actor_avg_rating'
FROM
	names AS n
    JOIN
    role_mapping AS rm
		ON
        rm.name_id = n.id
        JOIN
        movie AS m
			ON
            rm.movie_id = m.id
            JOIN
            ratings AS r
				ON
                m.id = r.movie_id
WHERE
	rm.category = 'actor' AND m.country = 'India'
GROUP BY
	name)
SELECT *,
    DENSE_RANK() OVER(ORDER BY actor_avg_rating DESC) 'actor_rank'
FROM
	actor_info
WHERE
	movie_count >= 5
LIMIT 1;

/*
+-----------------+--------------+---------------+------------------------+--------------+
| actor_name	  |	total_votes	 |	movie_count	 |	actor_avg_rating  	  |	 actor_rank	 |
+-----------------+--------------+---------------+------------------------+--------------+
|Vijay Sethupathi | 	23114	 |		 5	  	 |			8.42	      |  	  1      |
+----------------------------------------------------------------------------------------+

Observations:
- Actor Vijay Sethupathi can be the targeted lead actor to make Indian movie by RSVP Movies due to various factors like no. of hit 
	movies, avg_rating, fan following etc.
- Other hidden factors could be personality and acting skill.
*/





-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
WITH actor_info AS
(
SELECT
	name 'actress_name',
	SUM(total_votes) 'total_votes',
    COUNT(m.id) 'movie_count',
    ROUND(SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes),2) 'actress_avg_rating'
FROM
	names AS n
    JOIN
    role_mapping AS rm
		ON
        rm.name_id = n.id
        JOIN
        movie AS m
			ON
            rm.movie_id = m.id
            JOIN
            ratings AS r
				ON
                m.id = r.movie_id
WHERE
	rm.category = 'actress' AND m.country = 'India' AND m.languages LIKE '%Hindi%'
GROUP BY
	name)
SELECT *,
		DENSE_RANK() OVER(ORDER BY actress_avg_rating DESC) 'actress_rank'
FROM
	actor_info
WHERE
	movie_count >= 3
LIMIT 5;

/*
+---------------+-----------------------+---------------------+-------------------------+-----------------+
| actress_name	|	  total_votes		|   movie_count		  |	  actress_avg_rating 	|  actress_rank	  |
+---------------+-----------------------+---------------------+-------------------------+-----------------+
| Taapsee Pannu			18061					 3						7.73692					1		  |
| Kriti Sanon			21967					 3						7.04911					2		  |
| Divya Dutta			8579	 				 3						6.88440					3		  |
| Shraddha Kapoor	    26779					 3						6.63024					4		  |
| Kriti Kharbanda		2549					 3						4.80314					5		  |
+---------------------------------------------------------------------------------------------------------+

Observation:
- Taapsee Pannu, Kirit Sanon, Divya Dutta, Shraddha Kapoor and Kriti Kharbanda amogst these top five Indian Actresses any one
	could be taken as lead actress in the next movie by RSVP Movies by keeping Indian audiance in focus.
*/





/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:
SELECT
	m.title,
    r.avg_rating,
    CASE
		WHEN r.avg_rating > 8 THEN 'Superhit movie'
        WHEN r.avg_rating BETWEEN 7 AND 8 THEN 'Hit movie'
        WHEN r.avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movie'
        ELSE 'Flop movie'
	END AS Performance
FROM
	ratings AS r
    INNER JOIN
    genre AS g
		ON
        r.movie_id = g.movie_id
        INNER JOIN
        movie AS m
			ON
            g.movie_id = m.id
WHERE
	g.genre = 'Thriller';







/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:
WITH genre_info AS
(SELECT 
	g.genre,
    ROUND(AVG(m.duration),0) 'avg_duration'
FROM
	movie AS m
    JOIN
    genre AS g
		ON
        m.id = g.movie_id
GROUP BY
	g.genre
)
SELECT 
	*,
	SUM(avg_duration) OVER w1 'running_total_duration',
    AVG(avg_duration) OVER w2 'moving_avg_duration'
FROM
	genre_info
WINDOW w1 AS (ORDER BY genre ROWS UNBOUNDED PRECEDING),
		w2 AS (ORDER BY genre ROWS 6 PRECEDING);
        
/*
+-------+------------+----------------------+-------------------+
| genre	|avg_duration|running_total_duration|moving_avg_duration|
+-------+------------+----------------------+-------------------+
Action		113					113				113.0000
Adventure	102					215				107.5000
Comedy		103					318				106.0000
Crime		107					425				106.2500
Drama		107					532				106.4000
Family		101					633				105.5000
Fantasy		105					738				105.4286
Horror		93					831				102.5714
Mystery		102					933				102.5714
Others		100					1033			102.1429
Romance		110					1143			102.5714
Sci-Fi		98					1241			101.2857
Thriller	102					1343			101.4286
*/





-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies
WITH gross_movie_info AS
(SELECT
	g.genre,
    m.year,
    m.title 'movie_name',
    m.worldwide_gross_income,
    DENSE_RANK() OVER(ORDER BY COUNT(m.id) DESC) 'movie_rank'
FROM
	movie AS m
    JOIN
	genre AS g
		ON
        m.id =g.movie_id
GROUP BY
	g.genre
)
SELECT *
FROM
	gross_movie_info
WHERE
	movie_rank <=3;


/*
+-------+------+------------+------------------------+-----------+
| genre | year | movie_name | worldwide_gross_income | movie_rank|
+-------+------+------------+------------------------+-----------+
Drama	 2017	Der müde Tod				$ 12156		1
Comedy	 2017	A Matter of Life and Death	$ 124241	2
Thriller 2017	Der müde Tod				$ 12156		3
*/






-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:
WITH movie_count_info AS
(SELECT
	m.production_company,
    COUNT(m.id) 'movie_count',
    DENSE_RANK() OVER(ORDER BY COUNT(m.id) DESC) 'prod_comp_rank'
FROM
	movie AS m
    JOIN
    ratings AS r
		ON
        m.id = r.movie_id
WHERE
	r.median_rating >= 8 AND POSITION(',' IN m.languages)>0
GROUP BY
	m.production_company
)
SELECT *
FROM
	movie_count_info
WHERE
	prod_comp_rank < 4;
			
/*
+---------------------+-------------------+-----------------+
|production_company   |movie_count		  |	prod_comp_rank  |
+---------------------+-------------------+-----------------+
|NULL				  |	10				  |	1				|
|Star Cinema		  |	7				  |	2				|
|Twentieth Century Fox|	4				  |	3				|
+-----------------------------------------------------------+
*/






-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:
WITH actor_info AS
(
SELECT
	name 'actress_name',
	SUM(total_votes) 'total_votes',
    COUNT(m.id) 'movie_count',
    SUM(r.avg_rating*r.total_votes)/SUM(r.total_votes) 'actress_avg_rating'
FROM
	names AS n
    JOIN
    role_mapping AS rm
		ON
        rm.name_id = n.id
        JOIN
        movie AS m
			ON
            rm.movie_id = m.id
            JOIN
            ratings AS r
				ON
                m.id = r.movie_id
                INNER JOIN
				genre AS g
					ON
                    m.id = g.movie_id
WHERE
	rm.category = 'actress' AND r.avg_rating > 8 AND g.genre = 'Drama'
GROUP BY
	name
)
SELECT *,
		ROW_NUMBER() OVER(ORDER BY movie_count DESC) 'actress_rank'
FROM
	actor_info
LIMIT 3;

/*
+-------------------+-------------------+---------------------+----------------------+-------------+
| 	actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank |
+-------------------+-------------------+---------------------+----------------------+-------------+
|Parvathy Thiruvothu|		4974		|		2			  |		8.24813			 |		1	   |
|Susan Brown		|		656			|		2			  |		8.94436			 |		2      |
|-	|		656			|		2			  |		8.94436			 |		3	   |
+--------------------------------------------------------------------------------------------------+

Obervations:
- To focus on Global audiance RSVP Movies will need 
*/







/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

SELECT
	name_id 'director_id',
    name 'director_name',
    COUNT(m.id) AS 'number_of_movies',
    r.avg_rating,
    SUM(r.total_votes) 'total_votes',
    MIN(r.avg_rating) 'min_rating',
    MAX(r.avg_rating) 'max_rating',
    SUM(m.duration) 'total_duration'
FROM
	director_mapping AS dm
    JOIN
    names AS n
		ON
        dm.name_id = n.id
        JOIN
        movie AS m
			ON
            dm.movie_id = m.id
            JOIN
            ratings AS r
				ON
                m.id = r.movie_id
GROUP BY
	name_id
ORDER BY
	COUNT(m.id) DESC;
	





