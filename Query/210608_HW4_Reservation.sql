#########################################################################
## 4장 / 2021. 06. 08. / 2125341020 안규원
## 실습
##
#########################################################################
#########################################################################
## 25번 슬라이드
## 리조트 예약시스템
#########################################################################
set sql_safe_updates=0;

show databases;
use reservation;
show tables;

drop table if exists reservation;
create table reservation (
    name varchar(10),
    reserve_date date,
    room int,
    addr varchar(20),
    tel varchar(20),
    ipgum_name varchar(10),
    memo varchar(20),
    input_date date,
    primary key(reserve_date, room));
desc reservation;

delete from reservation where room>0;
insert into reservation values ('트와이스', '20210611', 1, '헤헤', '010-9973-6907', '입금', '메모', '20190330');
insert into reservation values ('원더걸스', '20210612', 1, '꼬꼬', '010-9973-6907', '입금', '메모', '20190330');
insert into reservation values ('비투비', '20210615', 3, '나나', '010-9973-6907', '입금', '메모', '20190330');
insert into reservation values ('김창렬', '20210613', 2, '텔레토비', '010-9973-6907', '입금', '메모', '20190330');
insert into reservation values ('교수님', '20210610', 2, '텔레토비', '010-9973-6907', '입금', '메모', '20190330');
insert into reservation values ('교수님', '20210608', 2, '텔레토비', '010-9973-6907', '입금', '메모', '20190330');
select * from reservation;

