-- find 5 oldest users
SELECT * 
FROM users 
ORDER BY created_at ASC 
LIMIT 5;

-- find which day of the week most people register on
SELECT DAYOFWEEK(created_at) AS 'days', COUNT(*) AS 'registered users'  
FROM users 
GROUP BY 'days' 
ORDER BY 'registered users';

-- identify inactive users
SELECT *
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id
HAVING COUNT(photos.id) = 0;

-- find the most liked photo in the database (and the person who posted it)
SELECT username, 
       photos.id, 
       image_url, 
       COUNT(likes.user_id) AS total 
FROM photos
JOIN likes
    ON likes.photo_id = photos.id
JOIN users
    ON photos.user_id = users.id
GROUP BY photo_id
ORDER BY total DESC
LIMIT 1;

-- how many times does the average user post?
SELECT (
    (SELECT COUNT(*) FROM photos) / 
    (SELECT COUNT(*) FROM users)
) AS average;

-- find the 5 most popular hashtags
SELECT tags.id, 
       tags.tag_name, 
       COUNT(photo_id) AS total
FROM tags
JOIN photo_tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id, tags.tag_name
ORDER BY total DESC
LIMIT 5;

-- find users who have liked every single photo

-- find users who have the same amount of likes as the count of photos?

SELECT username, 
       COUNT(DISTINCT photo_id) AS total 
FROM likes
JOIN users
    ON users.id = likes.user_id
GROUP BY user_id 
HAVING COUNT(total) = (SELECT COUNT(*) FROM photos);

-- final select

SELECT CASE
    WHEN email LIKE '%gmail%' THEN 'gmail'
    WHEN email LIKE '%yahoo%' THEN 'yahoo'
    WHEN email LIKE '%hotmail%' THEN 'hotmail'
    ELSE 'other'
END AS provider,
COUNT(email)
FROM users
GROUP BY provider;
