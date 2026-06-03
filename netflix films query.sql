SELECT * FROM netflix.netflix_titles;

/*total rows*/
select count(*) as total_rows
from netflix_raw;

/*checking number of missing or null values*/
select
count(*) as total_rows,
sum(case when director = '' or director is null then 1 else 0 end) as missing_director,
sum(case when cast = '' or cast is null then 1 else 0 end) as missing_cast,
sum(case when country = '' or country is null then 1 else 0 end) as missing_country,
sum(case when date_added = '' or date_added is null then 1 else 0 end) as missing_date,
sum(case when rating = '' or rating is null then 1 else 0 end) as missing_rating
from netflix_raw;

/*creating the main clean table*/
create table netflix_titles as
select 
show_id, 
 type,
 title,
 date_added,
 release_year,
coalesce(nullif (trim(rating),''), 'Not Rated')as rating,
 duration,
 description
from netflix_raw;
select * from netflix_titles
limit 6;


/*netflix_country cleaning to make them have two columns rather than multiple ones*/
create table country_clean as 
select show_id, country_1 as country 
from netflix_country
where Country_1 is not null
union all
select show_id, country_2 as country 
from netflix_country
where Country_2 is not null
union all
select show_id, country_3 as country 
from netflix_country
where Country_3 is not null
union all
select show_id, country_4 as country 
from netflix_country
where Country_4 is not null
union all
select show_id, country_5 as country 
from netflix_country
where Country_5 is not null
union all
select show_id, country_6 as country 
from netflix_country
where Country_6 is not null
union all
select show_id, country_7 as country 
from netflix_country
where Country_7 is not null
union all
select show_id, country_8 as country 
from netflix_country
where Country_8 is not null
union all
select show_id, country_9 as country 
from netflix_country
where Country_9 is not null
union all
select show_id, country_10 as country 
from netflix_country
where Country_10 is not null
union all
select show_id, country_11 as country 
from netflix_country
where Country_11 is not null
union all
select show_id, country_12 as country 
from netflix_country
where Country_12 is not null;

/*netflix_directors cleaning to make them have two columns rather than multiple ones*/
create table directors_clean as
select show_id, Director_1 as director
from netflix_directors
where Director_1 is not null
union all
select show_id, Director_2 as director
from netflix_directors
where Director_2 is not null
union all
select show_id, Director_3 as director
from netflix_directors
where Director_3 is not null
union all
select show_id, Director_4 as director
from netflix_directors
where Director_4 is not null
union all
select show_id, Director_5 as director
from netflix_directors
where Director_5 is not null
union all
select show_id, Director_6 as director
from netflix_directors
where Director_6 is not null
union all
select show_id, Director_7L as director
from netflix_directors
where director_7L is not null
union all
select show_id, Director_8 as director
from netflix_directors
where Director_8 is not null
union all
select show_id, Director_9 as director
from netflix_directors
where Director_9 is not null
union all
select show_id, Director_10 as director
from netflix_directors
where Director_10 is not null
union all
select show_id, Director_11 as director
from netflix_directors
where Director_11 is not null
union all
select show_id, Director_12 as director
from netflix_directors
where Director_12 is not null;

/*netflix_genres cleaning to make them have two columns rather than multiple ones*/
create table genres_clean as
select show_id, listed_in_1 as genre
from netflix_genres
where listed_in_1 is not null
union all
 select show_id, listed_in_2 as genre
from netflix_genres
where listed_in_2 is not null
union all
select show_id, listed_in_3 as genre
from netflix_genres
where listed_in_3 is not null;

/*count of titles per genre*/
select g.genre, count(t.title) as total_titles
from genres_clean g
join netflix_titles t
on g.show_id = t.show_id
group by g.genre
order by total_titles desc;


/* count of genre split by movies and tv shows*/
select t.type, count(g.genre) as count_of_genres
from netflix_titles t
inner join genres_clean g
on t.show_id=g.show_id
group by t.type;

/*directors and what number of film they make*/

select d.director, count(g.genre) as number_of_films_made
from directors_clean d
inner join genres_clean g
on d.show_id = g.show_id
group by director
order by count(g.genre) desc;


