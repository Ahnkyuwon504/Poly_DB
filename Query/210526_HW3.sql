#########################################################################
## 3장 / 2021. 05. 26. / 2125341020 안규원
## 실습
## 1) examtable 만들기
## 2) 데이터 20개 넣기
## 3) 1. 국어순 정렬 / 2. 영어순 정렬 / 3. 국어순정렬하다 동점이면 영어순 정렬
## 4) 국어순 내림차순 정렬 / 오름차순 정렬
#########################################################################

#########################################################################
## 1) examtable 만들기
#########################################################################
show databases;
use kopoctc0526Wed;

show tables;
drop table if exists examtable;
create table examtable(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
desc examtable;

#########################################################################
## 2) 데이터 20개 넣기
#########################################################################

delete from examtable where id>0;
INSERT INTO examtable VALUE ("나연",209901, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("정연",209902, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("모모",209903, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("사나",209904, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("지효",209905, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("미나",209906, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("다현",209907, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("채영",209908, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("쯔위",209909, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("송가인",209910, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("나연",209911, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("정연",209912, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("모모",209913, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("사나",209914, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("지효",209915, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("미나",209916, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("다현",209917, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("채영",209918, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("쯔위",209919, rand()*100, rand()*100, rand()*100);
INSERT INTO examtable VALUE ("송가인",209920, rand()*100, rand()*100, rand()*100);

select * from examtable;



#########################################################################
## 3) 1. 국어순 정렬 / 2. 영어순 정렬 / 3. 국어순정렬하다 동점이면 영어순 정렬 
## 4) 1. 국어 오름차순 정렬 / 2. 국어 내림차순 정렬
#########################################################################

select * from examtable;					## 전부 보기
select * from examtable order by kor;		## 국어 정렬
select * from examtable order by eng;		## 영어 정렬
select * from examtable order by kor, eng;  ## 국어를 정렬하되.. 동점자 있으면 영어
select * from examtable order by kor asc;   ## 국어를 오름차순으로 정렬
select * from examtable order by kor desc;  ## 국어를 내림차순으로 정렬

#########################################################################
## 5. 이름의 역순 정렬 / 수학의 역순 정렬 / 총점, 평균 구하고 총점 역순으로 정렬
##   
#########################################################################

select * from examtable order by name desc;		## 이름 역순 정렬
select * from examtable order by mat desc;		## 수학 역순 정렬
select *, kor+eng+mat as total, (kor+eng+mat)/3 from examtable order by total desc; ## 총점, 평균 구하고 총점의 역순으로 정렬

#########################################################################
## as -> 별칭 주기
## 일단 필드 뿐만 아니라 복합으로 만들어 낸 필드를 별칭 부여시 유용하게 사용
#########################################################################

select *, kor+eng+mat, (kor+eng+mat)/3 from examtable; ## 그냥 원래 필드 이름으로 사용

select *, kor+eng+mat, (kor+eng+mat)/3 from examtable  ## 그냥 원래 필드 이름으로 사용했기 때문에
order by kor+eng+mat desc;							   ## 원래 필드 이름을 사용해서 desc 배열

select *, kor+eng+mat as total, (kor+eng+mat)/3   	   ## as를 이용해 별칭 total을 부여했으므로
as average from examtable order by total desc;		   ## 편하게 사용 가능

select name as 이름, id as 학번, kor as 국어, eng as 영어, mat as 수학, kor+eng+mat as 합계,
	(kor+eng+mat)/3 as 평균 from examtable order by 합계 desc;
    
#########################################################################
## groub by -> 같은 항목이 있으면 동일 레코드로 취급
## 같은 행을 묶어서 보여줄 수 있다.
## group by로 지정하지 않은 칼럼을 보여줄 순 없다.
## group by에 조건을 부여하고자 하면 having을 사용한다.
#########################################################################
    
select * from examtable group by name; 							## 동일한 항목은 같은 레코드로 봐...  에러 에러 에러 에러 에러 삐용
select name, count(name) from examtable group by name;			## 이름으로 묶었기 때문에 이름을 뽑아줘야 함
select name, count(*) from examtable group by name;				## 동일 결과
select * from examtable group by kor;							## 에러 에러 에러 에러 에러 삐용삐용
select kor, count(kor) from examtable group by kor;				## 정상
select kor, count(kor) from examtable group by eng;				## 영어로 묶어서 영어로 봐야되는데 kor로 봤으니...에러 에러 에러 에러 에러
select kor, count(kor), eng, count(eng) from examtable 			## 정상 출력... kor로 묶고 eng으로 묶었으니 각각 보는 것임... 가상의 table만든다고 생각해라...
group by kor, eng;

select eng, count(eng) from examtable group by eng;				## 정상...

#########################################################################
## groub by(2)
## 
#########################################################################

insert into examtable value ("팽수", 209921, 100, 90, rand()*100);				## 일부러 같은 필드값 부여
insert into examtable value ("팽수", 209922, 100, 90, rand()*100);				## 일부러 같은 필드값 부여
insert into examtable value ("팽수", 209923, 100, 80, rand()*100);				## 일부러 같은 필드값 부여
select kor, count(kor), eng, count(eng) from examtable group by kor, eng;		## 국어 100, 영어 90 동일한 2명은 같은 레코드로 분류됨...
select name, count(name), kor, count(kor), eng, count(eng) from examtable 		## 이걸 잘 봐라..
group by name, kor, eng;														## 펭수인 이름은 3명이지만, 100-90 같은 펭수 2명이 1 record고
																				## 					  100-80으로 혼자 점수 다른 펭수는 1 record 독립..

select *, name, count(name), kor, count(kor), eng, count(eng) from examtable 	## 당연히 에러... name을 뽑아 줘야지...
group by name, kor, eng;

select eng, count(eng) from examtable group by eng having count(eng)>1;			## 중복점수 있는 eng만 뽑아 주는 것... 
SET GLOBAL log_bin_trust_function_creators = 1;									##

#########################################################################
## procedure 가지고 놀기
#########################################################################

DROP PROCEDURE IF EXISTS get_sum;								## 습관적으로 지우는 문장 넣기
DELIMITER $$
CREATE PROCEDURE get_sum(										## 지운 다음에, create procedure...
	IN _id integer,												## insert parameter 선언
    OUT _name varchar(20),										## out parameter 선언
	OUT _sum integer											## out parameter 선언
)
BEGIN															## 시작
	DECLARE _kor integer;										## 자바와 다른점... type을 뒤에 명시
	DECLARE _eng integer;										## 자바와 다른점... type을 뒤에 명시
	DECLARE _mat integer;										## 자바와 다른점... type을 뒤에 명시
    set _kor=0;													## 어차피 뒤에 _kor에 값 넣을거라 상관은 없다만.. 세팅 방법임..
    
    SELECT name, kor, eng, mat									## 먼저 examtable에서 parameter로 들어온 _id와 같은 id를 가지는 record를
		INTO _name, _kor, _eng, _mat FROM examtable WHERE id=_id; ## 뽑고, name, kor, eng, mat을 넣어주는 것...
	
    set _sum = _kor + _eng + _mat;
END $$															## 종료
DELIMITER ;

call get_sum(209901, @name, @sum);								## procedure 호출해서 가져올 값을 @name, @sum에 저장
select @name, @sum;												## 값 확인

#########################################################################
## procedure, function : 데이터베이스 공간에 저장해 놓고 사용하는 함수
## procedure은 sql문장에서 call procedure명 ()으로 사용됨.
## function은 select, insert같이 sql 쿼리 안에서 사용됨. 대부분은 비슷하긴 함...
## 테이블처럼 procedure, function을 지운 후 만든다...
#########################################################################

DROP FUNCTION IF EXISTS f_get_sum;								## 습관적으로 지우는 문장 넣기
DELIMITER $$
CREATE FUNCTION f_get_sum(_id integer) RETURNS integer			## 그후 만들어주자... in과 out을 정의 해줘야함...
BEGIN															## 시작
	DECLARE _sum integer;										## 자바와 다른점... type을 뒤에 명시
    SELECT kor+eng+mat INTO _sum FROM examtable WHERE id=_id;   ## where 만족하는 레코드에서..원하는 값을 뽑아서... _sum에 저장...
RETURN _sum;													## 그 _sum을 return..
END $$															## 종료
DELIMITER ;

select * ,f_get_sum(id) from examtable;							## 값 확인

#########################################################################
## 아래의 에러 발생시 OFF->ON으로
## Error Code : 1418
#########################################################################

show global variables like 'log_bin_trust_function_creators';
SET Global log_bin_trust_function_creators = 'ON';

#########################################################################
## 데이터 가지고 놀기
## procedure는 사용 변수앞에 _(언더 바)를 넣는것이 관례.. 꼭 지키자..
## CONCAT, CAST함수 
## Select에 limit 사용
#########################################################################

DROP PROCEDURE IF EXISTS insert_examtable;					## 만일 procedure가 이미 있으면 지워 버려...
DELIMITER $$
CREATE PROCEDURE insert_examtable(_last integer)			## create procedure
BEGIN														## 시작
DECLARE _name varchar(20);									## name 선언
DECLARE _id integer;										## id 선언
DECLARE _cnt integer;										## cnt 선언.. 이걸로 loop 빠져나올 것임..
SET _cnt = 0;												## 시작은 0

delete from examtable where id > 0;							## id 0보다 큰 레코드 다 지워...
	_loop : LOOP											## 루프 이름 지정. 루프 시작
		SET _cnt = _cnt + 1;								## 1번부터 들어갈거니깐... 
        SET _name = concat("홍길", cast(_cnt as char(4)));   ## name을 만들어 준다...
															## 4글자로 cnt을 cast한 후, 홍길에 붙여 주는 것임...
        SET _id = 209900 + _cnt;							## id는 그대로 뒤에 가져다 붙여...
        
        INSERT INTO examtable VALUE (_name, _id, rand()*100, rand()*100, rand()*100); ## 랜덤점수 세개 생성하여 insert
        
        IF _cnt = _last THEN								## 만일 학생수만큼 꽉 찼으면
			LEAVE _loop;									## loop 를 떠난다...
		END IF;												## 자바와 달리 {}가 없기 때문에 END IF;를 따로 만들어준것임...
	END LOOP _loop;											## 마찬가지.. END LOOP 해야함...
END $$														## procedure절차 종료

call insert_examtable(1000);								## 1000을 _last로 넣어주자...

select * from examtable;									## 다 뽑아내...
select *, kor+eng+mat as sum, (kor+eng+mat)/3 as ave from examtable LIMIT 30, 59; ## sum, ave 가상column 추가해서 select

#########################################################################
## 트와이스 호감도 투표
## 
## 랜덤함수 이용하여 호감도 투표, 용지에는 멤버이름과 연령대
## 1. 100건이상 투표시행후 리포트 작성
## 2. 멤버별 득표수, 득표율 현황
## 3. 나연의 연령대별 득표수, 득표율 현황
## 4. 정연의 연령대별 득표수, 득표율 현황
## 득표수 높은 순으로...
#########################################################################
## 0. hubo 테이블 만들기, tupyo 테이블 만들기, 데이터 insert하기
#########################################################################

show databases;										## databases 조회
use kopoctc0526Wed;									## kopoctc0526Wed 선택

show tables;										## tables 조회

drop table if exists hubo;							## hubo table 있으면 지운다...
create table hubo(									## hubo table을 만든다...
	kiho int not null,								## kiho : 기호번호
    name varchar(10),								## name : 이름
    primary key(kiho),								## primary key로 kiho를 잡겠다.
    index(kiho));									## 조회시 편하도록, index에 kiho를 잡겠다.
desc hubo;											## 다 만들었으면, 습관적으로 describe

drop table if exists tupyo;							## tupyo table 있으면 지운다
create table tupyo(									## tupyo table을 만든다..
	kiho int,										## kiho : 기호번호
    age int,										## age : 투표 나이대
    foreign key tupyo(kiho) references hubo(kiho)   ## tupyo는 hubo를 참조한다. foreign key 즉 f-key로 지정되었기 때문에, hubo는 tupyo가 있는 한
    );												## 지울 수 없다.
desc tupyo;

show tables;										## table 조회

delete from hubo where kiho > 0;					## 우선 hubo table 싹 비워준다. DB 할때 뭔가 create or insert 하기 전 습관적으로 하자.
insert into hubo values (1, "나연");					## 풀어 쓰면 kiho=1, name=나연
insert into hubo values (2, "정연");					## 풀어 쓰면 kiho=2, name=정연
insert into hubo values (3, "모모");					## 풀어 쓰면 kiho=3, name=모모
insert into hubo values (4, "사나");					## 풀어 쓰면 kiho=4, name=사나
insert into hubo values (5, "지효");					## 풀어 쓰면 kiho=5, name=지효
insert into hubo values (6, "미나");					## 풀어 쓰면 kiho=6, name=미나
insert into hubo values (7, "다현");					## 풀어 쓰면 kiho=7, name=다현
insert into hubo values (8, "채영");					## 풀어 쓰면 kiho=8, name=채영
insert into hubo values (9, "쯔위");					## 풀어 쓰면 kiho=9, name=쯔위

select kiho as 기호, name as 성명 from hubo;			## 잘 만들어졌는지 함 보자...
desc hubo;

#########################################################################
## 1. 100건 이상 투표시행후 리포트 작성
#########################################################################

delete from tupyo where kiho>0;											## 습관적으로 지우고 시작
DROP PROCEDURE IF EXISTS insert_tupyo;									## 습관적으로 지우고 시작
DELIMITER $$
CREATE PROCEDURE insert_tupyo(_limit integer)							## procedure을 만든다... parameter로 _limit 사용
BEGIN																	## procedure 시작
DECLARE _cnt integer;													## _cnt라는 integer형태 변수 선언
SET _cnt=0;																## _cnt값 0부여
	_loop: LOOP															## _loop라는 이름의 LOOP 시작
		SET _cnt = _cnt + 1;											## _loop 시행시마다 _cnt 증가
        INSERT INTO tupyo VALUE (rand()*8 + 1,  rand()*8 + 1);			## 랜덤함수로 만든 1~8까지의 숫자 부여
        IF _cnt = _limit THEN											## _loop 탈출조건. IF문의 사용 유념
			LEAVE _loop;												## 탈출
		END IF;															## IF문 종료
	END LOOP _loop;														## _loop 종료
END $$																	## procedure 종료
call insert_tupyo(100);													## _limit에 100이 들어가는 procedure call
select kiho as 투표한기호, age as 투표자연령대 from tupyo;					## 확인...
select count(*) from tupyo;

#########################################################################
## 2. 멤버별 득표수, 득표율 현황
## concat(cast((cast(rand()*8 as signed integer) + 1) as char(2)), "0대")
#########################################################################

select																	## select 하겠다..
	(b.name) as 이름,													## 첫번째 field에는 hubo의 name이 들어가고, 이름 이라고 부른다..
    ( count(a.kiho) ) as 득표수, 											## 두번째 field에는 count(tupyo의 kiho)가 들어가고, 득표수 라고 부른다..
	( ( count(a.kiho) ) * 100 / (select count(*) from tupyo)) as 득표율   ## 세번째 field에는 득표율이 들어가므로 나눠준다...
	from tupyo as a, hubo as b											## 이 select문에서는 tupyo를 a, hubo를 b로 잡는다..
    where a.kiho=b.kiho													## 또한 tupyo의 kiho와 hubo의 kiho 대응된다. 이 경우 다대일 대응이겠지..
    group by a.kiho order by 득표수 desc;									## tupyo의 kiho로 group화 하고, 순서는 득표수에 따라... 높은 득표부터 select

#########################################################################
## 3. 나연의 연령대별 득표수, 득표율 현황
#########################################################################


select																			## 나연에 대해 뽑을 거다..
	age * 10 as 연령대,															## kiho=2 를 where로 잡아 준다..
    count(kiho) as 득표수,														## 득표수에 count(kiho)를 잡아 넣는다...
    count(kiho) * 100 / (select count(*) from tupyo where kiho=2) as 득표율		## 득표율은 위와 같다...
    from tupyo												
    where kiho=2
    group by 연령대 order by 득표수 desc;

#########################################################################
## 4. 정연의 연령대별 득표수, 득표율 현황
#########################################################################

select																			## 나연에 대해 뽑을 거다..
	age * 10 as 연령대,															## kiho=2 를 where로 잡아 준다..
    count(kiho) as 득표수,														## 득표수에 count(kiho)를 잡아 넣는다...
    count(kiho) * 100 / (select count(*) from tupyo where kiho=1) as 득표율		## 득표율은 위와 같다...
    from tupyo												
    where kiho=1
    group by 연령대 order by 득표수 desc;
    
#########################################################################
## 교수님 정답
#########################################################################

select
	age * 10 as 연령대,
    count(age) as 득표수,
    count(age) / (select count(*) from tupyo where kiho=1) * 100 as 득표율
    from tupyo
    where kiho=1 group by age;

#########################################################################
## Basic Training(1)
## examtable 100개 데이터
## 1. 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등수 나오는 테이블 Hint : 내총점보다 많은 row개수..
## 2. 등수 출력
## 3. 등수 출력 테이블을 오름차순 소트
#########################################################################

delete from examtable where id>0;	
desc examtable;

DROP PROCEDURE IF EXISTS insert_examtable;					## 만일 procedure가 이미 있으면 지워 버려...
DELIMITER $$
CREATE PROCEDURE insert_examtable(_last integer)			## create procedure
BEGIN														## 시작
DECLARE _name varchar(20);									## name 선언
DECLARE _id integer;										## id 선언
DECLARE _cnt integer;										## cnt 선언.. 이걸로 loop 빠져나올 것임..
SET _cnt = 0;												## 시작은 0

delete from examtable where id > 0;							## id 0보다 큰 레코드 다 지워...
	_loop : LOOP											## 루프 이름 지정. 루프 시작
		SET _cnt = _cnt + 1;								## 1번부터 들어갈거니깐... 
        SET _name = concat("홍길", cast(_cnt as char(4)));   ## name을 만들어 준다...
															## 4글자로 char로 _cnt를 형변환한 후, 홍길에 붙여 주는 것임...
        SET _id = _cnt;							## id는 그대로 뒤에 가져다 붙여...
        
        INSERT INTO examtable VALUE (_name, _id, rand()*100, rand()*100, rand()*100); ## 랜덤점수 세개 생성하여 insert
        
        IF _cnt = _last THEN								## 만일 학생수만큼 꽉 찼으면
			LEAVE _loop;									## loop 를 떠난다...
		END IF;												## 자바와 달리 {}가 없기 때문에 END IF;를 따로 만들어준것임...
	END LOOP _loop;											## 마찬가지.. END LOOP 해야함...
END $$														## procedure절차 종료

call insert_examtable(100);									## 100명 생성
select count(*) from examtable;								## 숫자 확인
select * from examtable;									## 내용 확인

drop table if exists examtableEX;							## 이름, 학번, 국어, 영어, 수학, 총점, 평균, 등수를 field로 갖는
create table examtableEX(									## table : examtableEX 생성
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int, sum int, ave double, ranking int);
desc examtableEX;

insert into examtableEX
	select *,															## 학번, 이름, 국, 영, 수... 5개의 field
    b.kor + b.eng + b.mat,												## 총합... 1개의 field
    (b.kor + b.eng + b.mat) / 3,										## 평균... 1개의 field
    ( select count(*) + 1 from examtable as a							## 등수를 출력하는 함수 잘 보기...
		where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat) )		## 랭킹... 1개의 field... 
	from examtable as b;
    
DROP FUNCTION IF EXISTS get_rank;								## 습관적으로 지우는 문장 넣기
DELIMITER $$
CREATE FUNCTION get_rank(_id integer) RETURNS integer			## 그후 만들어주자... in과 out을 정의 해줘야함...
BEGIN															## 시작
	DECLARE _rank double;										## 자바와 다른점... type을 뒤에 명시
    SELECT ranking
		INTO _rank FROM examtableEX as a WHERE a.id=_id;   		## where 만족하는 레코드에서..원하는 값을 뽑아서... _sum에 저장...
RETURN _rank;													## 그 _sum을 return..
END $$															## 종료
DELIMITER ;

select get_rank(210190) as 등수;
    
select * from examtableEX order by ranking asc;			## 해당 테이블을 오름차순 소트...

#########################################################################
## Basic Training(2)
## 
## 1. 트와이스 멤버 선호도를 조사하기 위한 데이터 입력 procedure 만들기
## 2. call input_data(1000) .. 이렇게 호출하면 선호도투표가 무작위로 데이터 생성되도록
## 3. 선호도비율 함수 만들기
#########################################################################
show global variables like 'log_bin_trust_function_creators';			## 함수 만들어야하니까.. ON 으로...
SET Global log_bin_trust_function_creators = 'ON';

delete from tupyo where kiho>0;											## 습관적으로 지우고 시작
DROP PROCEDURE IF EXISTS insert_tupyo;									## 습관적으로 지우고 시작
DELIMITER $$
CREATE PROCEDURE insert_tupyo(_limit integer)							## procedure을 만든다... parameter로 _limit 사용
BEGIN																	## procedure 시작
DECLARE _cnt integer;													## _cnt라는 integer형태 변수 선언
SET _cnt=0;																## _cnt값 0부여
	_loop: LOOP															## _loop라는 이름의 LOOP 시작
		SET _cnt = _cnt + 1;											## _loop 시행시마다 _cnt 증가
        INSERT INTO tupyo VALUE (rand()*8 + 1,  rand()*8 + 1);			## 랜덤함수로 만든 1~8까지의 숫자 부여
        IF _cnt = _limit THEN											## _loop 탈출조건. IF문의 사용 유념
			LEAVE _loop;												## 탈출
		END IF;															## IF문 종료
	END LOOP _loop;														## _loop 종료
END $$																	## procedure 종료

DROP FUNCTION IF EXISTS get_love;								## 습관적으로 지우는 문장 넣기
DELIMITER $$
CREATE FUNCTION get_love(_kiho integer) RETURNS integer			## 그후 만들어주자... in과 out을 정의 해줘야함...
BEGIN															## 시작
	DECLARE _ratio double;										## 자바와 다른점... type을 뒤에 명시
    SELECT ( ( count(a.kiho) ) * 100 / (select count(*) from tupyo))
		INTO _ratio FROM tupyo as a WHERE a.kiho=_kiho;   		## where 만족하는 레코드에서..원하는 값을 뽑아서... _sum에 저장...
RETURN _ratio;													## 그 _sum을 return..
END $$															## 종료
DELIMITER ;

call insert_tupyo(1000);												## _limit에 1000이 들어가는 procedure call
select get_love(1) as 나연, get_love(2) as 정연, get_love(3) as 모모, get_love(4) as 사나, get_love(5) as 지효,
	   get_love(6) as 미나, get_love(7) as 다현, get_love(8) as 채영, get_love(9) as 쯔위;							## 1~9번 후보의 선호도비율 확인

#########################################################################
## Training(1)
## 
## examtable 1000개 데이터 만들기
## 1. 프로시져 만들기 - Call print_report(5, 25) : 25개씩 출력시 5번째 페이지 결과 테이블
## 결과테이블은 내용테이블, 현재페이지 테이블, 누적페이지 테이블로 3개
## 페이지가 1보다 작은값이면 1페이지, 마지막페이지보다 큰 값이면 마지막 페이지
## Limit 사용
##
## 2. 등수도 넣어 보시오...
#########################################################################

delete from examtable where id>0;	## examtable 내용 제거					## examtable 생성, 1000명
call insert_examtable(1000); 		## examtable에 1000명 생성, 점수아직없음
select count(*) as 총합 from examtable;  ## 1000명 확인

delete from examtableEX where id>0;  ## examtableEx 내용 제거					## examtableEX 생성
insert into examtableEX														## name, id, kor, eng, mat, sum, ave, ranking 부여 
	select *,																## 학번, 이름, 국, 영, 수... 5개의 field
    b.kor + b.eng + b.mat,													## 총합... 1개의 field
    (b.kor + b.eng + b.mat) / 3,											## 평균... 1개의 field
    ( select count(*) + 1 from examtable as a								## 등수를 출력하는 함수 잘 보기...
		where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat) )			## 랭킹... 1개의 field... 
	from examtable as b;
select * from examtableEX;

##########################################################################
##  이제 학생정보는 완료되었다. 불러보자... #######################################
##  현재페이지, 누적페이지 table 만들기 #########################################
##  현재페이지는 examtableEX 의 limit에서 만들고 ################################
##  누적페이지는 examtableEX 에서 만들고 #######################################
##########################################################################

DROP procedure IF EXISTS print_report;
DELIMITER $$
CREATE procedure print_report(_page int,_onepageprint int) 
BEGIN
	DECLARE _studentnumber int;
    DECLARE _lastpage int;
    DECLARE _start int;
    DECLARE _totalstudentnumber int;
    ###################
    SET _studentnumber = (SELECT count(*) FROM examtableEX);			## studentnumber은 examtableEX의 개수만큼...1000 들어간다
    SET _lastpage = (_studentnumber / _onepageprint) + 1;				## lastpage는 학생수와 한 페이지당 학생수로 구해주고...
    SET _page = (IF (_page < 1, 1, _page));								## page가 1보다 작은값 들어오면 1페이지 세팅
    SET _page = (IF (_page > _lastpage, _lastpage, _page));				## lastpage보다 큰 값 들어오면 마지막 페이지 세팅
    SET _start = (_page - 1) * _onepageprint;							## 시작지점 세팅
    SET _totalstudentnumber = _page * _onepageprint;
    
    SELECT * FROM examtableEX LIMIT _start, _onepageprint;			
    
     ## select sum(price) from (select items.price from items order by items.price desc limit 3) as subt;

	SELECT sum(kor) as "국어총점", sum(eng) as "영어총점", sum(mat) as "수학총점", sum(sum) as "총점총합", (sum(sum)) / 3 as "총점평균"
		FROM (SELECT * FROM examtableEX LIMIT _start, _onepageprint) as a;
        
	SELECT avg(kor) as "국어평균", avg(eng) as "영어평균", avg(mat) as "수학평균",avg(sum) as "총점총합의 평균", (avg(sum)) / 3 as "총점평균의 평균"
		FROM (SELECT * FROM examtableEX LIMIT _start, _onepageprint) as a;
        
	SELECT sum(kor) as "누적국어총점", sum(eng) as "누적영어총점", sum(mat) as "누적수학총점", sum(sum) as "누적총점 총합", (sum(sum)) / 3 as "누적총점의 평균"
		FROM (SELECT * FROM examtableEX LIMIT 0, _totalstudentnumber) as b;	
        
	SELECT avg(kor) as "누적국어총점 평균", avg(eng) as "누적영어총점 평균", avg(mat) as "누적수학총점 평균",
		avg(sum) as "누적총점 총합의 평균", (avg(sum)) / 3 as "누적총점의 평균의 평균"
		FROM (SELECT * FROM examtableEX LIMIT 0, _totalstudentnumber) as b;
END $$
DELIMITER ;

call print_report(0, 25);
call print_report(40, 30);

#########################################################################
## Training(2)
## 
## 와이파이 XML을 읽고 때려 넣은 테이블로...
## 1. 프로시져 만들기 - Call print_report(5, 25) : 25개씩 출력시 5번째 페이지 결과 테이블
## 결과테이블은 내용테이블 1개
## 페이지가 1보다 작은값이면 1페이지, 마지막페이지보다 큰 값이면 마지막 페이지
## Limit 사용
##
## 2. 우리집까지의 거리를 넣어보시오(두 위치 위,경도 가지고 거리구하는 공식 적용하는 함수를 작성하시오) <<< 구글링
#########################################################################

show databases;
use kopoctc;
show tables;

desc freewifi8;
select * from freewifi8 limit 30;

DROP procedure IF EXISTS print_wifi;							## 일단 지우고 시작해라..
DELIMITER $$		
CREATE procedure print_wifi(_page int,_onepageprint int) 		## procedure 정의... parameter은 2개...
BEGIN															## 시작
	DECLARE _wifinumber int;									## 총 개수 정의한다...
    DECLARE _lastpage int;										## 마지막 페이지...
    DECLARE _start int;											## 시작 포인트 정의한다...
    ###################
    SET _wifinumber = (SELECT count(*) FROM freewifi8);			## freewifi8의 개수만큼... 들어간다
    SET _lastpage = (_wifinumber / _onepageprint) + 1;			## lastpage를 구해주고...
    SET _page = (IF (_page < 1, 1, _page));						## page가 1보다 작은값 들어오면 1페이지 세팅
    SET _page = (IF (_page > _lastpage, _lastpage, _page));		## lastpage보다 큰 값 들어오면 마지막 페이지 세팅
    SET _start = (_page - 1) * _onepageprint;					## 시작지점 세팅
	SET @rownum:=0;												## 총 개수 정의한다...

    SELECT @rownum:=@rownum+1 as "num", place_addr_land as "location", latitude as "lat", longitude as "lng",
		(				
        SELECT													## 식별번호, loaction, 위도, 경도, 거리를 차례대로 SELECT한다...
			(6371*acos(cos(radians(lat))*cos(radians(37.3860521))*cos(radians(127.1214038)
			- radians(lng)) + sin(radians(lat))*sin(radians(37.3860521)))) 
        ) as "distance"
		FROM freewifi8 LIMIT _start, _onepageprint;				##  스타트 포인트와 한 페이지 수를 명시한다....

END $$
DELIMITER ;

call print_wifi(100, 20);										## 이렇게 치면... 100번째 페이지이고... 20개 출력된다...



    





























