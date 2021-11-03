--JOINS

select * from invoice_line
where unit_price > .99;

select invoice.invoice_date, customer.first_name, customer.last_name, invoice.total from invoice
join customer 
on customer.customer_id = invoice.customer_id;

select customer.first_name, customer.last_name, employee.first_name, employee.last_name from customer
join employee
on customer.support_rep_id = employee.employee_id;

select title, name from album
join artist
on album.artist_id = artist.artist_id;

select playlist_track.playlist_track_id from playlist_track
join playlist
on playlist_track.playlist_id = playlist.playlist_id
where playlist.name = 'Music';


select track.name from track
join playlist
on playlist.playlist_id = track.track_id
where playlist.playlist_id = 5;

select track.name, playlist.name from track
join playlist_track
on track.track_id = playlist_track.track_id
join playlist
on playlist_track.playlist_id = playlist.playlist_id;

select track.name, album.title from track
join album
on track.album_id = album.album_id
join genre
on genre.genre_id = track.genre_id
where genre.name = 'Alternative & Punk';

select playlist.name, genre.name, album.title, artist.name from playlist
join playlist_track
on playlist.playlist_id = playlist_track.playlist_id
join track
on playlist_track.track_id = track.track_id
join album
on track.album_id = album.album_id
join artist
on album.artist_id = artist.artist_id
join genre
on track.genre_id = genre.genre_id
where playlist.name = 'Music';

-- Subqueries

select * from invoice
where invoice_id in 
(select invoice_id from invoice_line
where unit_price > .99);

select * from playlist_track
where playlist_id in 
(select playlist_id from playlist
 where name = 'Music');

 select name from track
where track_id in 
(select track_id from playlist_track
 where playlist_id = 5);

 select * from track
where genre_id in 
(select genre_id from genre
 where name = 'Comedy');

 select * from track 
where album_id in 
(select album_id from album
 where title = 'Fireball');

select * from track
where album_id in 
(select album_id from album
 where artist_id in 
 (select artist_id from artist 
  where name = 'Queen'));

--   Practice updating rows

update customer
set fax = null
where fax is not null;

update customer
set company = 'Self'
where company is null;

update customer
set last_name = 'Thompson'
where last_name = 'Barnett';

update customer 
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

update track
set composer = 'The darkness around us'
where composer is null and 
genre_id = (select genre_id from genre 
 where name = 'Metal');

--  Group by

select count(*), genre.name
from track
join genre on track.genre_id = genre.genre_id
group by genre.name;

select count(*), genre.name
from track
join genre on track.genre_id = genre.genre_id
where genre.name = 'Pop' or genre.name = 'Rock'
group by genre.name;

select count(*), artist.name
from album 
join artist on album.artist_id = artist.artist_id
group by artist.name
order by count asc;

-- Use Distinct

select distinct composer
from track;

select distinct billing_postal_code 
from invoice;

select distinct company
from customer;

-- Delete Rows 

delete from practice_delete
where type = 'bronze';

delete from practice_delete
where type = 'silver';

delete from practice_delete
where value = 150;

-- E-Commerce Site 

create table users (
  id serial primary key,
  customer_name text,
  email text
  );


  
  create table products (
    id serial primary key,
    product_name text,
    price decimal
    );
    
    create table orders (
      id serial primary key,
      customer_name text,
      product_name text,
      price decimal,
      order_total decimal
      );
      
      insert into users 
      (customer_name, email)
      values
      ('Ryan', 'abc@gmail.com'),
      ('Jay', 'def@gmail.com'),
      ('Josie', 'ghi@gmail.com'),
      ('Chad', 'jkl@gmail.com');
      
      insert into products
      (product_name, price)
      values
      ('soccer cleats', 65.99),
      ('biology textbook', 54.08),
      ('D&D dice', 12.32),
      ('Adidas jacket', 70.50);
      
      insert into orders 
      (customer_name, product_name, price, order_total)
      values
      ('Ryan', '2 Adidas jackets', 70.50, 141.00),
      ('Jay', '5 soccer cleats', 65.99, 329.95),
      ('Josie', 'biology textbook', 54.08, 54.08),
      ('Chad', '8 D&D dice', 12.32, 98.56);

select product_name from orders
where id = 1;

select * from orders;

select sum(order_total)
from orders
where customer_name = 'Josie' or customer_name = 'Chad';

select * from users
join orders on 
users.customer_name = orders.customer_name
where orders.customer_name = 'Jay';

select * from orders
where customer_name = 'Josie';

select count(*), customer_name from orders
group by (customer_name);

select sum(order_total), customer_name from orders
group by (customer_name);