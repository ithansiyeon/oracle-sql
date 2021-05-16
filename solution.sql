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
                    
--  없어진 기록 찾기
SELECT ANIMAL_ID, NAME FROM ANIMAL_OUTS
MINUS
SELECT ANIMAL_ID, NAME FROM ANIMAL_INS;   
                      
--  있었는데요 없었습니다                      
SELECT a.animal_id, a.name from animal_ins a join animal_outs b on a.animal_id = b.animal_id where a.datetime > b.datetime order by a.datetime;                      
