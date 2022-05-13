--solution :https://www.youtube.com/watch?v=_gy1o9UH2dQ

---(total number  of friends the user has )/ total number of users on the platform 
---total no of users in the platform: union distinct  user1 and user2 
----total number of friendsthe user has 

---first let us find out the users on the platform: union distinct user1 and user 2
select count(*) as all_users
from (select distinct user1 from facebook_friends
     union select distinct user2 from facebook_friends) as total_unique_users;
	 
---9
----next 
select user1  , user2  from facebook_friends
union select user2 as user1 , user1 as user2   from facebook_friends;


Output
View the output in a separate browser tab
user1	user2
6	1
2	7
1	3
9	3
7	2
6	2
3	9
1	2
4	1
3	8
1	5
1	4
3	1
8	3
1	6
2	6
5	1
2	1	 

---actual query --basically there is no common column for join , it jst concats together 

select * 
from 
(select count(*) as all_users
from (select distinct user1 from facebook_friends
     union select distinct user2 from facebook_friends) as total_unique_users) AS tuu

JOIN (select user1  , user2  from facebook_friends
union 
select user2 as user1 , user1 as user2   from facebook_friends) as user_friends on 1=1;


Output
View the output in a separate browser tab
all_users	user1	user2
9	6	1
9	2	7
9	1	3
9	9	3
9	7	2
9	6	2
9	3	9
9	1	2
9	4	1
9	3	8
9	1	5
9	1	4
9	3	1
9	8	3
9	1	6
9	2	6
9	5	1
9	2	1


---next actual query output without popularity_percent :

select user1,
 count(*)/max(tuu.all_users)::FLOAT
from 
(select count(*) as all_users
from (select distinct user1 from facebook_friends
     union select distinct user2 from facebook_friends) as total_unique_users) AS tuu
JOIN (select user1  , user2  from facebook_friends
union 
select user2 as user1 , user1 as user2   from facebook_friends) as user_friends on 1=1
group by user1
order by user1 asc;

user1	?column?
1	0.556
2	0.333
3	0.333
4	0.111
5	0.111
6	0.222
7	0.111
8	0.111
9	0.111

--actual query outout with popularity_percent 

select user1,
 (count(*)/max(tuu.all_users)::FLOAT)*100 as popularity_percent
from 
(select count(*) as all_users
from (select distinct user1 from facebook_friends
     union select distinct user2 from facebook_friends) as total_unique_users) AS tuu
JOIN (select user1  , user2  from facebook_friends
union 
select user2 as user1 , user1 as user2   from facebook_friends) as user_friends on 1=1
group by user1
order by user1 asc;

user1	popularity_percent
1	55.556
2	33.333
3	33.333
4	11.111
5	11.111
6	22.222
7	11.111
8	11.111
9	11.111

