select * from olympic
select * from regions
--Count the number of regions
select count(distinct region) as total_regions
from regions
--There are 207 countries that paticipated in the Olympic Games

--Count total number of males and females
select sex, count(sex) as total_gender
from olympic
group by sex
order by 2
--There were total of 74,522 females and 196,594 males who participated in the Olympics

--Total number of males and females by city
select top 10 city, count(sex) as total_gender,
		sum(case when sex = 'M'then 1 else 0 end) as male,
		sum(case when sex = 'F' then 1 else 0 end) as female,
		sum(case when sex = 'M'then 1 else 0 end) /sum(case when sex = 'F' then 1 else 0 end) as ratio
from olympic
group by city
order by 3 desc, 4 desc
--London had the highest number of participants 

--Number of males and females who won medal
select medal, sum(case when sex = 'M' then 1 else 0 end) as medal_by_male,
			sum(case when sex = 'F' then 1 else 0 end) as medal_by_female
from olympic
group by medal
order by 2,3
--The number of gold medals won by male was the highest while the number of silver medals won by female was the smallest

-- Total number of female athletes in each olympics
select count(sex) as female_athletes, year
from olympic 
where sex ='F' and season = 'summer'
group by year
order by 2 
--The number of female athletes increased in each olympics

--The top 10 most popular sport events for women
select top 10 event, count(Event) as popular_sports
from olympic 
where sex = 'F'
group by event
order by 2 desc
--Volleyball Women's Volleyball was the sport that had the most female athletes

--The top 10 most popular sport events for men
select top 10 event, count(Event) as popular_sports
from olympic 
where sex = 'M'
group by event
order by 2 desc
--Football Men's Football was the sport that had the most male athletes

--Top 10 countries have the most gold medals
select top 10 region, count(medal) as number_of_gold
from olympic ol
join regions re
on ol.noc = re.noc
where medal = 'gold'
group by region
order by 2 desc
--United States had the most gold medals