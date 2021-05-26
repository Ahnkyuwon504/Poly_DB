#########################################################################
## 4장 / 2021. 05. 26. / 2125341020 안규원
## 실습
##
#########################################################################

#########################################################################
## 6번 슬라이드
## 테이블 만들어 보기
#########################################################################
show databases;
use kopoctc0526Wed;

drop table if exists hubo;
create table hubo(
	kiho int not null,
    name varchar(10),
    gongyak varchar(50),
    primary key(kiho),
    index(kiho));
desc hubo;

drop table if exists tupyo;
create table tupyo(
	kiho int,
    age int,
    foreign key tupyo(kiho) references hubo(kiho)
    );
desc tupyo;

show tables;

#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################

delete from hubo where kiho > 0;
insert into hubo values (1, "나연", "정의사회 구현");
insert into hubo values (2, "정연", "모두 1억 줌");
insert into hubo values (3, "모모", "월화수목토토일");
insert into hubo values (4, "사나", "살맛나는 세상, 비계맛도 조금");
insert into hubo values (5, "지효", "먹다 지쳐 잠드는 세상");
insert into hubo values (6, "미나", "나 뽑으면 너 하고 싶은 거 다 해!");
insert into hubo values (7, "다현", "장바구니 다 사줄게");
insert into hubo values (8, "채영", "노는 게 제일 좋아 뽀로로 세상 구현");
insert into hubo values (9, "쯔위", "커플 지옥 싱글 파라다이스");

select * from hubo;
select kiho as 기호, name as 성명, gongyak as 공약 from hubo;

#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################






#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################






#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################




#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################




#########################################################################
## 7번 슬라이드
## 위에서 만든 테이블에 데이터 집어넣기
#########################################################################










