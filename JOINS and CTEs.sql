--1)
with rainy as
(select date
from weather
where events = 'Rain'
group by 1)

select trip_id, duration, 
date(start_date) trip_date
from trips
join rainy
on rainy.date = trip_date
order by duration DESC
limit 3

--2)
select
status.station_id,
stations.name,
count(case when docks_available=0 then 1 end) count
from status
join stations
on stations.station_id = status.station_id
group by 1
order by count desc

--3)
select start_station, dockcount, count(*)
from trips t 
join stations s
on s.name = t.start_station
group by 1 , 2
order by  2 desc

--4)
with rainy as (
select date 
from weather
where events = 'Rain'
group by 1 ),

rain_trips as (
select trip_id, duration, date(start_date) trip_date
from trips 
join rainy
on rainy.date = trip_date	
order by duration desc)

select trip_date, max(duration)
from rain_trips
group by 1
