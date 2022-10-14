select * from airports_data ad 

select * from flights f 

--creamos una tabla temporal para recopilar los datos que necesitabamos en este caso 
--usamos airports_data y flights, para buscar los vuelos del aeropuerto.
with airport_flights as( select * from airports_data ad 
inner join flights f 
on f.departure_airport = ad.airport_code or f.arrival_airport = ad.airport_code),
--se crea otra tabla temporal para calcular cuantos vuelos tuvo un aeropuerto 
flights_per_airport as( select af.airport_code, count(af.airport_code) as flights
from airport_flights af
group by af.airport_code)
--buscar el aeropuerto con menos vuelos
select *
from flights_per_airport
order by flights asc limit 1;
--buscar el aeropuerto con mas vuelos
select * 
from flights_per_airport
order by flights desc limit 3;

-------------------------------------------------------------------------------------

--obtenimos el promedio de tiquet por avion
select f.aircraft_code, avg(tf.amount) as average_amount
from flights f 
inner join ticket_flights tf 
on f.flight_id = tf.flight_id 
inner join aircrafts_data ad 
on f.aircraft_code = ad.aircraft_code
group by f.aircraft_code 