-- 모든 레코드 조회하기
select * from animal_ins order by animal_id;

-- 최댓값 구하기
select max(datetime) from animal_ins;

-- 루시와 엘라 찾기
SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE from animal_ins where name in ('Lucy','Ella','Pickle','Rogan','Sabrina','Mitty');

-- 이름에 el이 들어가는 동물 찾기
SELECT animal_id as ANIMAL_ID, name as NAME from animal_ins where lower(name) like '%el%' and animal_type = 'Dog' order by lower(name);

-- 아픈 동물 찾기
select animal_id, name from animal_ins where intake_condition = 'Sick' order by animal_id;

-- 동물 수 구하기
SELECT count(*) as count from animal_ins;

-- NULL 처리하기
SELECT ANIMAL_TYPE, ifnull(name,'No name') as Name, SEX_UPON_INTAKE from animal_ins order by animal_id asc;

-- 중복 제거하기
SELECT count(distinct(name)) as count from animal_ins where name is not null;

-- DATETIME에서 DATE로 형 변환
SELECT animal_id, name, to_char(datetime,'yyyy-mm-dd') from animal_ins order by animal_id;

-- 고양이와 개는 몇 마리 있을까
SELECT animal_type, count(*) from animal_ins where animal_type='Dog' or animal_type='Cat' group by animal_type order by animal_type asc;

-- 동명 동물 수 찾기
SELECT NAME ,count(*) as COUNT from animal_ins group by name having name is not null and count(*) >= 2 order by name asc;

-- 최솟값 구하기
SELECT min(datetime) as 시간 from animal_ins;
                      
-- 우유와 요거트가 담긴 장바구니
select cart_id from (select cart_id, count(*) as cnt from (select distinct cart_id, name from cart_products where name = 'Milk' or name = 'Yogurt') group by cart_id) where cnt>=2 order by cart_id;                      

--  오랜 기간 보호한 동물(1)
SELECT * from (select name,datetime from animal_ins where animal_id not in (select animal_id from animal_outs)order by datetime asc) where rownum <=3 ;                      
                      
-- 어린 동물 찾기
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS WHERE INTAKE_CONDITION != 'Aged';                      

-- 중성화 여부 파악하기
SELECT animal_id, name, (case when (SEX_UPON_INTAKE like '%Neutered%' or SEX_UPON_INTAKE like '%Spayed%') then 'O' else 'X' end) as SEX_UPON_INTAKE from ANIMAL_INS order by animal_id;

-- 입양 시각 구하기(1)
SELECT HOUR,COUNT(HOUR)
FROM(
    SELECT DATE_FORMAT(DATETIME,'%H') AS HOUR
    FROM ANIMAL_OUTS    
)A
GROUP BY HOUR
HAVING HOUR>=9 AND HOUR<20
ORDER BY HOUR ASC;

-- 역순 정렬하기
SELECT name, datetime from animal_ins order by animal_id desc;                      
                      
-- 동물의 아이디와 이름
SELECT animal_id, name from animal_ins order by animal_id;

--  여러가지 기준으로 정렬하기
SELECT animal_id, name, datetime from animal_ins order by name, datetime desc;
                      
--  상위 n개 레코드 
SELECT name from animal_ins where datetime = (select min(datetime) from animal_ins);

-- 이름이 없는 동물의 아이디
SELECT animal_id from animal_ins where name is Null order by animal_id;       

-- 이름이 있는 동물의 아이디
SELECT animal_id from animal_ins where name is not null order by animal_id;
                    
--  없어진 기록 찾기
SELECT ANIMAL_ID, NAME FROM ANIMAL_OUTS
MINUS
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS;   
                      
--  있었는데요 없었습니다                      
SELECT a.animal_id, a.name from animal_ins a join animal_outs b on a.animal_id = b.animal_id where a.datetime > b.datetime order by a.datetime;             

--  오랜 기간 보호한 동물(1)
SELECT * from (select name,datetime from animal_ins where animal_id not in (select animal_id from animal_outs)order by datetime asc) where rownum <=3;     

-- 오랜 기간 보호한 동물(2)
select * from (SELECT a.animal_id, a.name from animal_ins a join animal_outs o on a.animal_id = o.animal_id order by (o.datetime-a.datetime) desc) where rownum <= 2;    
                      
-- 헤비 유저가 소유한 장소
select a.id, a.name, a.host_id from places a join (SELECT host_id, count(*) as cnt from places group by host_id) b on a.host_id = b.host_id where b.cnt >= 2 order by a.id;                      

-- 우유와 요거트가 담긴 장바구니
select cart_id from (select cart_id, count(*) as cnt from (select distinct cart_id, name from cart_products where name = 'Milk' or name = 'Yogurt') group by cart_id) where cnt>=2 order by cart_id;                      
                      
-- 보호소에서 중성화한 동물
SELECT a.animal_id, a.animal_type, a.name from ((select * from animal_ins where SEX_UPON_INTAKE not like 'Spayed%' and SEX_UPON_INTAKE not like 'Neutered%') a join (select * from animal_outs where SEX_UPON_OUTCOME like 'Neutered%' or SEX_UPON_OUTCOME like 'Spayed%') b on a.animal_id = b.animal_id) order by a.animal_id;                      

-- 입양 시각 구하기(2)
select b.no, nvl(count,0) as count from (SELECT to_number(to_char(datetime,'HH24')) as hour ,count(*) as count from animal_outs group by to_number(to_char(datetime,'HH24'))) a, (select level-1 as no from dual connect by level <=24) b where a.hour(+) = b.no order by b.no;
