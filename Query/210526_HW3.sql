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




#########################################################################
## Basic Training(1)
## 
## examtable 100개 데이터
## 1. 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등수 나오는 테이블 Hint : 내총점보다 많은 row개수..
## 2. 등수 출력
## 3. 등수 출력 테이블을 오름차순 소트
#########################################################################
        
        

#########################################################################
## Basic Training(2)
## 
## 1. 트와이스 멤버 선호도를 조사하기 위한 데이터 입력 procedure 만들기
## 2. call input_data(1000) .. 이렇게 호출하면 선호도투표가 무작위로 데이터 생성되도록
## 3. 선호도비율 함수 만들기
#########################################################################


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



    





























