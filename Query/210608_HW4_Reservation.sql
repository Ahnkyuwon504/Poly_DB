#########################################################################
## 4장 / 2021. 06. 08. / 2125341020 안규원
## 실습
##
#########################################################################
#########################################################################
## 25번 슬라이드
## 리조트 예약시스템
#########################################################################

show databases;
use kopoctc_HW4;
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
insert into reservation values ('헤헤', '20210510', 1, '헤헤', '010-9973-6907', '입금', '메모', '20190330');
select * from reservation;

