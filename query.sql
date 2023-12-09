-- 1.  finding five oldest users.
select * 
from users
order by created_at
limit 5;

-- 2. what day of the weeek do most users register on?
select 
dayname(created_at) as day,
count(*) as total
from users
group by day
order by total desc
limit 2;

-- 3. find users who never posted a photo or inactive users?
select username
 from users 
 left join photos 
 on users.id = photos.user_id
 where photos.id is NULL;

-- 4. who get most likes on single photos?
select 
username,
photos.id,
photos.image_url,
count(*) as total
from photos
inner join likes
  on likes.photo_id = photos.id
  inner join users
  on users.id = photos.user_id
  group by photos.id
  order by total desc
  limit 1;
  
  -- 5. calculate avg number of photos per users
  
  select (select count(*) from photos)/
  (select count(*) from users) as avg;
  
  -- 6. what are the top 5 most commonly used hastags
  
  select 
  tags.tag_name,
  count(*) as total
  from photo_tags
  join tags
  on photo_tags.tag_id = tags.id
  group by tags.id
  order by total desc limit 5 ;

-- 7. find users who have liked every single photo on site.

select 
username,
user_id,
count(*) as total
 from users
inner join likes 
on users.id = likes.user_id
group by likes.user_id
having total =(select count(*) from photos);
