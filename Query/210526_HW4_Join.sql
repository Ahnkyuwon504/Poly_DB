#########################################################################
## 4장 / 2021. 05. 26. / 2125341020 안규원
## 실습
## 
#########################################################################

#########################################################################
## 6번 슬라이드
## 테이블 만들어 보기, f-key 걸기
#########################################################################
show databases;										## 데이터베이스 조회
use kopoctc_HW4;									## kopoctc_HW4 사용
show tables;										## table 조회

drop table if exists hubo;							## table 생성 전 지우는 습관
create table hubo(									## hubo table을 만든다..
	kiho int not null,								## 기호번호
    name varchar(10),								## 이름
    gongyak varchar(50),							## 공약
    primary key(kiho),								## 기호를 프라이머리 키로...
    index(kiho));									## 인덱스 부여
desc hubo;											## table 만든 후 describe하는 습관

drop table if exists tupyo;							## tupyo 만들기 전 지우는 습관
create table tupyo(									## tupyo table을 만든다..
	kiho int,										## 기호번호
    age int,										## 투표연령대
    foreign key tupyo(kiho) references hubo(kiho)	## tupyo는 hubo의 kiho를 참조하기 때문에 hubo를 지울 수 없음... tupyo 지워야 지울수있음...
    );												
desc tupyo;											## tupyo 확인

#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################

delete from hubo where kiho > 0;												## insert 전에 지운다..
insert into hubo values (1, "나연", "정의사회 구현");								## 1번 ~ 9번 후보 insert
insert into hubo values (2, "정연", "모두 1억 줌");
insert into hubo values (3, "모모", "월화수목토토일");
insert into hubo values (4, "사나", "살맛나는 세상, 비계맛도 조금");
insert into hubo values (5, "지효", "먹다 지쳐 잠드는 세상");
insert into hubo values (6, "미나", "나 뽑으면 너 하고 싶은 거 다 해!");
insert into hubo values (7, "다현", "장바구니 다 사줄게");
insert into hubo values (8, "채영", "노는 게 제일 좋아 뽀로로 세상 구현");
insert into hubo values (9, "쯔위", "커플 지옥 싱글 파라다이스");

select * from hubo;																## 확인
select kiho as 기호, name as 성명, gongyak as 공약 from hubo;						## 기호, 공약으로 이름 부여해서 확인

#########################################################################
## 8번 슬라이드
## 투표 랜덤 돌려보기, 1000번
#########################################################################

delete from tupyo where kiho>0;										## insert procedure 실행 전 싹다 지우기
DROP PROCEDURE IF EXISTS insert_tupyo;								## procedure 생성 전 없애기
DELIMITER $$														## procedure 시작
CREATE PROCEDURE insert_tupyo(_limit integer)						## 생성하겠다... _limit 받아서...
BEGIN																## 시작
DECLARE _cnt integer;												## _cnt 선언
SET _cnt=0;															## _cnt 값 0으로 세팅
	_loop: LOOP														## _loop라는 이름의 LOOP 시작
		SET _cnt = _cnt + 1;										## 루프마다 _cnt + 1
        INSERT INTO tupyo VALUE (rand()*8 + 1, rand()*8 + 1);		## tupyo에 insert
        IF _cnt = _limit THEN										## LOOP 종료조건
			LEAVE _loop;											
		END IF;														
	END LOOP _loop;													## LOOP 한바퀴 종료
END $$																## procedure생성 끝
call insert_tupyo(1000);											## 1000번 insert할거야...
select kiho as 투표한기호, age as 투표자연령대 from tupyo;				## insert결과 확인

#########################################################################
## 9, 10번 슬라이드
## select
#########################################################################

select kiho as 기호, name as 성명, gongyak as 공약 from hubo;			## 기호, 성명, 공약으로 확인
select kiho as 투표기호, age as 투표자연령대 from tupyo;					## 투표기호, 연령대 확인
select kiho, count(*) from tupyo group by kiho;						## 몇개 들어갔는지 확인

#########################################################################
## 11번 슬라이드
## join
#########################################################################

select b.name, b.gongyak, count(a.kiho)								## kiho로 묶어서 몇표 획득했는지 확인
	from tupyo as a, hubo as b
    where a.kiho=b.kiho
    group by a.kiho;

#########################################################################
## 12번 슬라이드
## select 안에 select / 다른버전
#########################################################################

select																## subquery 활용, select 안에 select
	(select name from hubo where kiho=a.kiho) as 이름,
    (select gongyak from hubo where kiho=a.kiho) as 공약,
    count(a.kiho) as 득표수
    from tupyo as a, hubo as b
    group by a.kiho;
    
select																## subquery 활용, select 안에 select
	(select name from hubo as b where b.kiho=a.kiho) as 이름,
    (select gongyak from hubo where kiho=a.kiho) as 공약,
    count(a.kiho) as 득표수
    from tupyo as a
    group by a.kiho;
    
#########################################################################
## 13번 슬라이드
## 호감도 투표2 : 세명 뽑기
#########################################################################

drop table if exists tupyo2;								## 세명씩 투표하는 tupyo2 만들기 전 지우기
create table tupyo2 (
	kiho1 int,
    kiho2 int,
    kiho3 int,
    age int
	);

desc tupyo2;												## tupyo2 확인

######### 세명 투표를 1000건 실행하는 procedure#################################

set sql_safe_updates=0;											## 이거 해야 update 또는 delete 가능...

delete from tupyo2 where kiho1>0;								## insert 전 지우기
DROP PROCEDURE IF EXISTS insert_tupyo2;							## procedure 만들기 전에 지우기...
DELIMITER $$
CREATE PROCEDURE insert_tupyo2(_limit integer)					## insert_tupyo2 만들기 
BEGIN
DECLARE _cnt integer;											## _cnt 선언
SET _cnt=0;
	_loop: LOOP
		SET _cnt = _cnt + 1;									
        INSERT INTO tupyo2 VALUE (rand()*8 + 1, rand()*8 + 1, rand()*8 + 1, rand()*8 + 1);
        IF _cnt = _limit THEN
			LEAVE _loop;
		END IF;
	END LOOP _loop;
END $$
call insert_tupyo2(1000);										## 1000번 시행... 

select count(*) from tupyo2;									## 잘 들어갔나 확인

#########################################################################
## 14번 슬라이드
## 호감도 투표2 (계속)
#########################################################################

select 																	## tupyo2의 내용 확인
	b.age as 연령대,
    a.name as 투표1,
    a.name as 투표2,
    a.name as 투표3
    from hubo as a, tupyo2 as b
    where a.kiho = b.kiho1 and a.kiho = b.kiho2 and a.kiho = b.kiho3;   ## 오류 케이스... 모두 똑같이 나옴
    
select																	## 오류 안나게 하려면.....
	b.age as 연령대,
    h1.name as 투표1,
    h2.name as 투표2,
    h3.name as 투표3
    from hubo as h1, hubo as h2, hubo as h3, tupyo2 as b
    where h1.kiho=b.kiho1 and h2.kiho=b.kiho2 and h3.kiho=b.kiho3;		## 같은 hubo라도 h1, h2, h3 각각 지정해 줘야
																		## 독립적으로 인식됨..
	
select																	## subquery로도 가능...
	age as 연령대,
    (select name from hubo where kiho=a.kiho1) as 투표1,
    (select name from hubo where kiho=a.kiho2) as 투표2,
    (select name from hubo where kiho=a.kiho3) as 투표3
    from tupyo2 as a;

#########################################################################
## 15, 16번 슬라이드
## 호감도 투표3, 4 (계속)
#########################################################################

select																			## 한표씩 투표된 사항, 중복투표, 3중복투표 확인
	(select count(*) from tupyo2 where kiho1=1 or kiho2=1 or kiho3=1) as "나연",
	(select count(*) from tupyo2 where kiho1=2 or kiho2=2 or kiho3=2) as "정연",
	(select count(*) from tupyo2 where kiho1=3 or kiho2=3 or kiho3=3) as "모모",
	(select count(*) from tupyo2 where kiho1=4 or kiho2=4 or kiho3=4) as "사나",
	(select count(*) from tupyo2 where kiho1=5 or kiho2=5 or kiho3=5) as "지효",
	(select count(*) from tupyo2 where kiho1=6 or kiho2=6 or kiho3=6) as "미나",
	(select count(*) from tupyo2 where kiho1=7 or kiho2=7 or kiho3=7) as "다현",
	(select count(*) from tupyo2 where kiho1=8 or kiho2=8 or kiho3=8) as "채영",
	(select count(*) from tupyo2 where kiho1=9 or kiho2=9 or kiho3=9) as "쯔위",
    (select sum(나연 + 정연 + 모모 + 사나 + 지효 + 미나 + 다현 + 채영 + 쯔위)) as 총합,
    (select count(*) from tupyo2 where kiho1=kiho2 or kiho2=kiho3 or kiho3=kiho1) as "두 후보 중복투표수",
    (select count(*) from tupyo2 where kiho1=kiho2 and kiho2=kiho3) as "세 후보 중복투표수";

#########################################################################
## 17번 슬라이드
## View와 insert안에 select
#########################################################################

drop table if exists examtable;								## table 생성 전 지우기
create table examtable(
	name varchar(20),
	id int not null primary key,
    kor int, eng int, mat int);
desc examtable;
delete from examtable where id>0;							

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
        SET _id = 209900 + _cnt;							## id는 그대로 뒤에 가져다 붙여...
        
        INSERT INTO examtable VALUE (_name, _id, rand()*100, rand()*100, rand()*100); ## 랜덤점수 세개 생성하여 insert
        
        IF _cnt = _last THEN								## 만일 학생수만큼 꽉 찼으면
			LEAVE _loop;									## loop 를 떠난다...
		END IF;												## 자바와 달리 {}가 없기 때문에 END IF;를 따로 만들어준것임...
	END LOOP _loop;											## 마찬가지.. END LOOP 해야함...
END $$														## procedure절차 종료

call insert_examtable(1000);
select * from examtable;
select count(*) from examtable;

#########################################################################
## 18번 슬라이드
## View
#########################################################################

DROP view IF EXISTS examview;									## view 생성 전 지우기
create view examview(name, id, kor, eng, mat, tot, ave, ran)	## view의 column 지정
as select *,
	b.kor + b.eng + b.mat,
    (b.kor + b.eng + b.mat) / 3,
    ( select count(*) + 1 from examtable as a 
    where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat) )
	from examtable as b;
    
#########################################################################
## 19번 슬라이드
## View
#########################################################################

select * from examview;
select name, ran from examview order by ran;									## 성적총합 순위로 나열
select * from examview where ran > 5;

insert into examview values ("나연", 309933, 100, 100, 100, 300, 100, 1);		## 에러 발생

#########################################################################
## 20번 슬라이드
## View 대신 실제 table에 등수 때려넣기
#########################################################################

drop table if exists examtableEX;										## 실제 table 생성 전 지우기
create table examtableEX(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int, sum int, ave double, ranking int);
desc examtableEX;

insert into examtableEX
	select *,															## 학번, 이름, 국, 영, 수... 5개의 field
    b.kor + b.eng + b.mat,												## 총합... 1개의 field
    (b.kor + b.eng + b.mat) / 3,										## 평균... 1개의 field
    ( select count(*) + 1 from examtable as a
		where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat) )		## 랭킹... 1개의 field
	from examtable as b;
    
select * from examtableEX order by ranking desc;

#########################################################################
## 22, 23번 슬라이드
## 시험처리 : 정답테이블, 시험테이블, 채점테이블, 채점리포트테이블
##          Answer,  Testing, Scoring, Reporttable
#########################################################################

drop table if exists Answer;								## table 생성 전 지우기
create table Answer											## Answer table 생성
	(
	subjectID int not null primary key,
    a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
	a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int
    );
desc Answer;												
    
drop table if exists Testing;								## table 생성 전 지우기
create table Testing 										## Testing table 생성
	(
	subjectID int not null,
    stu_name varchar(20),
    stu_id int not null,
    a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
	a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int,
    primary key(subjectID, stu_id)
    );
desc Testing;												
    
drop table if exists Scoring;								## table 생성 전 지우기
create table Scoring 										## Scoring table 생성
	(
	subjectID int not null,
    stu_name varchar(20),
    stu_id int not null,
    a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
	a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int, sumOf int,
    primary key(subjectID, stu_id)
    );
    
drop table if exists Reporttable;							## table 생성 전 지우기
create table Reporttable 									## Reporttable table 생성
	(
    stu_name varchar(20),
    stu_id int not null primary key,
    kor int, eng int, mat int
    );

DESC Answer;												## table 확인
DESC Testing;												## table 확인
DESC Scoring;												## table 확인
DESC Reporttable;											## table 확인

#########################################################################
## 24번 슬라이드
## 정답테이블 Answer 만들기 / 4지선다
## 시험테이블 Testing 1000건 만들기
#########################################################################

delete from Answer where subjectID>0;						## insert 전 지우기
DROP PROCEDURE IF EXISTS insert_Answer;						## procedure 생성 전 제거
DELIMITER $$
CREATE PROCEDURE insert_Answer()							## procedure 생성
BEGIN
	#################국어###############################################################################
	INSERT INTO Answer VALUE (1, 
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
    #################영어###############################################################################                         
	INSERT INTO Answer VALUE (2, 
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
	#################수학###############################################################################
    INSERT INTO Answer VALUE (3, 
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
							 rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                             rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
END $$
call insert_Answer;
select * from Answer;


desc Testing;

delete from Testing where subjectID>0;						## insert 전 지우기
DROP PROCEDURE IF EXISTS insert_Testing;					## insert_Testing procedure 생성 전 지우기
DELIMITER $$
CREATE PROCEDURE insert_Testing(_limit integer)
BEGIN
DECLARE _name varchar(20);									## name 선언
DECLARE _id integer;										## id 선언
DECLARE _cnt integer;										## cnt 선언.. 이걸로 loop 빠져나올 것임.. _cnt integer;
SET _cnt=0;
	_loop: LOOP
		SET _cnt = _cnt + 1;
        SET _name = concat("홍길", cast(_cnt as char(4)));   ## name을 만들어 준다...
															## 4글자로 char로 _cnt를 형변환한 후, 홍길에 붙여 주는 것임...
        SET _id = 209900 + _cnt;							## id는 그대로 뒤에 가져다 붙여...
        
        ####국어 답안 생성######################################################################################
        INSERT INTO Testing VALUE (1, _name, _id,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
		####영어 답안 생성######################################################################################
		INSERT INTO Testing VALUE (2, _name, _id,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
		####수학 답안 생성######################################################################################
		INSERT INTO Testing VALUE (3, _name, _id,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
								   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1,
                                   rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1, rand()*4 + 1);
        
        IF _cnt = _limit THEN
			LEAVE _loop;
		END IF;
	END LOOP _loop;
END $$
call insert_Testing(50);

select count(*) from Testing;
select * from Testing where stu_name="홍길1";

#########################################################################
## 24번 슬라이드
## 채점하기
## 채점결과 집계하여 채점리포트 테이블에 넣기
#########################################################################

desc Testing;
desc Scoring;
desc Answer;

select * from Testing order by stu_id;

delete from Scoring where subjectID>0;			## 초기화, Testing의 subjectID, stu_name, stu_id, 정답여부 복사
desc Scoring;
insert into Scoring								## insert
	(subjectID, stu_name, stu_id, a01, a02, a03, a04, a05, a06, a07,
    a08, a09, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, sumOf)
    select
	a.subjectID
    , a.stu_name
    , a.stu_id
    , IF(b.a01 = a.a01, 1, 0), IF(b.a02 = a.a02, 1, 0), IF(b.a03 = a.a03, 1, 0), IF(b.a04 = a.a04, 1, 0) 
    , IF(b.a05 = a.a05, 1, 0), IF(b.a06 = a.a06, 1, 0), IF(b.a07 = a.a07, 1, 0), IF(b.a08 = a.a08, 1, 0) 
    , IF(b.a09 = a.a09, 1, 0), IF(b.a10 = a.a10, 1, 0), IF(b.a11 = a.a11, 1, 0), IF(b.a12 = a.a12, 1, 0) 
    , IF(b.a13 = a.a13, 1, 0), IF(b.a14 = a.a14, 1, 0), IF(b.a15 = a.a15, 1, 0), IF(b.a16 = a.a16, 1, 0) 
    , IF(b.a17 = a.a17, 1, 0), IF(b.a18 = a.a18, 1, 0), IF(b.a19 = a.a19, 1, 0), IF(b.a20 = a.a20, 1, 0),
    
    (IF(b.a01 = a.a01, 1, 0) + IF(b.a02 = a.a02, 1, 0) + IF(b.a03 = a.a03, 1, 0) + IF(b.a04 = a.a04, 1, 0) 
    + IF(b.a05 = a.a05, 1, 0) + IF(b.a06 = a.a06, 1, 0) + IF(b.a07 = a.a07, 1, 0) + IF(b.a08 = a.a08, 1, 0) 
    + IF(b.a09 = a.a09, 1, 0) + IF(b.a10 = a.a10, 1, 0) + IF(b.a11 = a.a11, 1, 0) + IF(b.a12 = a.a12, 1, 0) 
    + IF(b.a13 = a.a13, 1, 0) + IF(b.a14 = a.a14, 1, 0) + IF(b.a15 = a.a15, 1, 0) + IF(b.a16 = a.a16, 1, 0) 
    + IF(b.a17 = a.a17, 1, 0) + IF(b.a18 = a.a18, 1, 0) + IF(b.a19 = a.a19, 1, 0) + IF(b.a20 = a.a20, 1, 0))
    from Testing as a, Answer as b where a.subjectID=b.subjectID;
    
select * from Scoring;  

#########################################################################
## 24번 슬라이드
## 합계, 평균, 등수
## ex) 나연 - 209901 - 국어점수 - 영어점수 - 수학점수 - 총합 - 평균 - 등수
#########################################################################

DROP PROCEDURE IF EXISTS insert_Reporttable;				## 만일 procedure가 이미 있으면 지워 버려...
DELIMITER $$
CREATE PROCEDURE insert_Reporttable(_last integer)			## create procedure
BEGIN														## 시작
DECLARE _name varchar(20);									## name 선언
DECLARE _id integer;										## id 선언
DECLARE _cnt integer;										## cnt 선언.. 이걸로 loop 빠져나올 것임..
DECLARE _kor integer;
DECLARE _eng integer;
DECLARE _mat integer;
SET _cnt = 0;												## 시작은 0

delete from Reporttable where stu_id > 0;					## id 0보다 큰 레코드 다 지워...
	_loop : LOOP											## 루프 이름 지정. 루프 시작
		SET _cnt = _cnt + 1;								## 1번부터 들어갈거니깐... 
        SET _id = 209900 + _cnt;							## id는 그대로 뒤에 가져다 붙여...
        SET _name = (select stu_name from Scoring where stu_id=_id limit 1);   ## name을 만들어 준다..
        SET _kor = (select sumOf from Scoring where stu_id=_id and subjectID=1);  
        SET _eng = (select sumOf from Scoring where stu_id=_id and subjectID=2);   
        SET _mat = (select sumOf from Scoring where stu_id=_id and subjectID=3);  
        
        INSERT INTO Reporttable VALUE (_name, _id, _kor, _eng, _mat); 
        
        IF _cnt = _last THEN								
			LEAVE _loop;								
		END IF;												
	END LOOP _loop;											
END $$														## procedure절차 종료

call insert_Reporttable((select count(*) from Scoring group by subjectID limit 1));
desc Reporttable;
select * from Reporttable;

DROP view IF EXISTS Reportview;
create view Reportview(name, id, kor, eng, mat, tot, ave, ran)
as select 
	b.stu_name, b.stu_id, 
    b.kor * 5, b.eng * 5, b.mat * 5,
	(b.kor + b.eng + b.mat) * 5,
    (b.kor + b.eng + b.mat) * 5 / 3,
    ( select count(*) + 1 from Reporttable as a 
    where (a.kor + a.eng + a.mat) > (b.kor + b.eng + b.mat) )
	from Reporttable as b;
    
select * from Reportview;
select * from Reportview order by ran;

#########################################################################
## 24번 슬라이드
## 각 과목별 득점자수, 득점률
## 각 문제별 득점자수, 득점률
#########################################################################

select * from Scoring;

select count(*) from Scoring where subjectID=1 and a01=1;	## 국어 a01번 득점자

drop table if exists Result;								## Result 테이블 제거/생성
create table Result
	(
	subjectID int not null primary key,
    a01 int, a02 int, a03 int, a04 int, a05 int, a06 int, a07 int, a08 int, a09 int, a10 int,
	a11 int, a12 int, a13 int, a14 int, a15 int, a16 int, a17 int, a18 int, a19 int, a20 int
    );
desc Result;
select * from Result;

DROP PROCEDURE IF EXISTS insert_Result;						## 만일 procedure가 이미 있으면 지워 버려...
DELIMITER $$
CREATE PROCEDURE insert_Result()							## create procedure
BEGIN														## 시작
delete from Result where subjectID > 0;						## id 0보다 큰 레코드 다 지워...
insert into Result 
	(subjectID, a01, a02, a03, a04, a05, a06, a07, a08, a09, a10, 
				a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
	values
    (1
    , (select count(*) from Scoring where subjectID=1 and a01=1), (select count(*) from Scoring where subjectID=1 and a02=1)
    , (select count(*) from Scoring where subjectID=1 and a03=1), (select count(*) from Scoring where subjectID=1 and a04=1) 
    , (select count(*) from Scoring where subjectID=1 and a05=1), (select count(*) from Scoring where subjectID=1 and a06=1)
    , (select count(*) from Scoring where subjectID=1 and a07=1), (select count(*) from Scoring where subjectID=1 and a08=1)
    , (select count(*) from Scoring where subjectID=1 and a09=1), (select count(*) from Scoring where subjectID=1 and a10=1)
    , (select count(*) from Scoring where subjectID=1 and a11=1), (select count(*) from Scoring where subjectID=1 and a12=1)
    , (select count(*) from Scoring where subjectID=1 and a13=1), (select count(*) from Scoring where subjectID=1 and a14=1)
    , (select count(*) from Scoring where subjectID=1 and a15=1), (select count(*) from Scoring where subjectID=1 and a16=1)
    , (select count(*) from Scoring where subjectID=1 and a17=1), (select count(*) from Scoring where subjectID=1 and a18=1)
    , (select count(*) from Scoring where subjectID=1 and a19=1), (select count(*) from Scoring where subjectID=1 and a20=1)),
    
    (2
    , (select count(*) from Scoring where subjectID=2 and a01=1), (select count(*) from Scoring where subjectID=2 and a02=1)
    , (select count(*) from Scoring where subjectID=2 and a03=1), (select count(*) from Scoring where subjectID=2 and a04=1) 
    , (select count(*) from Scoring where subjectID=2 and a05=1), (select count(*) from Scoring where subjectID=2 and a06=1)
    , (select count(*) from Scoring where subjectID=2 and a07=1), (select count(*) from Scoring where subjectID=2 and a08=1)
    , (select count(*) from Scoring where subjectID=2 and a09=1), (select count(*) from Scoring where subjectID=2 and a10=1)
    , (select count(*) from Scoring where subjectID=2 and a11=1), (select count(*) from Scoring where subjectID=2 and a12=1)
    , (select count(*) from Scoring where subjectID=2 and a13=1), (select count(*) from Scoring where subjectID=2 and a14=1)
    , (select count(*) from Scoring where subjectID=2 and a15=1), (select count(*) from Scoring where subjectID=2 and a16=1)
    , (select count(*) from Scoring where subjectID=2 and a17=1), (select count(*) from Scoring where subjectID=2 and a18=1)
    , (select count(*) from Scoring where subjectID=2 and a19=1), (select count(*) from Scoring where subjectID=2 and a20=1)),
    
    (3
    , (select count(*) from Scoring where subjectID=3 and a01=1), (select count(*) from Scoring where subjectID=3 and a02=1)
    , (select count(*) from Scoring where subjectID=3 and a03=1), (select count(*) from Scoring where subjectID=3 and a04=1) 
    , (select count(*) from Scoring where subjectID=3 and a05=1), (select count(*) from Scoring where subjectID=3 and a06=1)
    , (select count(*) from Scoring where subjectID=3 and a07=1), (select count(*) from Scoring where subjectID=3 and a08=1)
    , (select count(*) from Scoring where subjectID=3 and a09=1), (select count(*) from Scoring where subjectID=3 and a10=1)
    , (select count(*) from Scoring where subjectID=3 and a11=1), (select count(*) from Scoring where subjectID=3 and a12=1)
    , (select count(*) from Scoring where subjectID=3 and a13=1), (select count(*) from Scoring where subjectID=3 and a14=1)
    , (select count(*) from Scoring where subjectID=3 and a15=1), (select count(*) from Scoring where subjectID=3 and a16=1)
    , (select count(*) from Scoring where subjectID=3 and a17=1), (select count(*) from Scoring where subjectID=3 and a18=1)
    , (select count(*) from Scoring where subjectID=3 and a19=1), (select count(*) from Scoring where subjectID=3 and a20=1))
    ;
END $$														## procedure절차 종료

call insert_Result();

select * from Result;
select subjectID
	   , a01 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a01 정답률'
	   , a02 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a02 정답률'
	   , a03 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a03 정답률'
	   , a04 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a04 정답률'
	   , a05 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a05 정답률'
	   , a06 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a06 정답률'
	   , a07 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a07 정답률'
	   , a08 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a08 정답률'
	   , a09 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a09 정답률'
	   , a10 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a10 정답률'
	   , a11 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a11 정답률'
	   , a12 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a12 정답률'
	   , a13 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a13 정답률'
	   , a14 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a14 정답률'
	   , a15 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a15 정답률'
	   , a16 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a16 정답률'
	   , a17 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a17 정답률'
	   , a18 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a18 정답률'
	   , a19 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a19 정답률'
	   , a20 / ((select count(*) from Scoring group by subjectID limit 1)) as 'a20 정답률'
       from Result;

#########################################################################
## 시행착오
## 시행착오
#########################################################################

insert into Scoring
	(subjectID, stu_name, stu_id, a01, a02, a03, a04, a05, a06, a07,
    a08, a09, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20)
    select
	(select subjectID from Testing) as subjectID
    , (select stu_name from Testing) as stu_name
    , (select stu_id from Testing)
    , (select IF(b.a01 = a.a01, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a02 = a.a02, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a03 = a.a03, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a04 = a.a04, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a05 = a.a05, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a06 = a.a06, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a07 = a.a07, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a08 = a.a08, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a09 = a.a09, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a10 = a.a10, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a11 = a.a11, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a12 = a.a12, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a13 = a.a13, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a14 = a.a14, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a15 = a.a15, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a16 = a.a16, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a17 = a.a17, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a18 = a.a18, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a19 = a.a19, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID)
    , (select IF(b.a20 = a.a20, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID);
    
## 209901번 학생의 1번 과목 정답여부
select IF(b.a01 = a.a01, 1, 0) from Testing as a, Answer as b where a.subjectID=b.subjectID and a.stu_id=209901 and a.subjectID=1;



