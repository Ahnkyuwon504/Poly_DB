show tables;
drop table if exists examtable;
create table examtable(
	name varchar(20),
    id int not null primary key,
    kor int, eng int, mat int);
desc examtable;

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
select * from examtable order by kor;
select * from examtable order by eng;
select * from examtable order by kor, eng; ## 국어를 정렬하되.. 동점자 있으면 영어
select * from examtable order by kor asc;
select * from examtable order by kor desc;

select *, kor+eng+mat, (kor+eng+mat)/3 from examtable; ## 가상 column 만듬
select *, kor+eng+mat, (kor+eng+mat)/3 from examtable order by kor+eng+mat desc;
select *, kor+eng+mat as total, (kor+eng+mat)/3 as average from examtable order by total desc;

select name as 이름, id as 학번, kor as 국어, eng as 영어, mat as 수학, kor+eng+mat as 합계,
	(kor+eng+mat)/3 as 평균 from examtable order by 합계 desc;
    
select * from examtable group by name; ## 동일한 항목은 같은 레코드로 봐...  에러 에러 에러 에러 에러 삐용
select name, count(name) from examtable group by name;
select name, count(*) from examtable group by name;
select * from examtable group by kor;
select kor, count(kor) from examtable group by kor;
select kor, count(kor) from examtable group by eng;
select kor, count(kor), eng, count(eng) from examtable group by kor, eng;
select eng, count(eng) from examtable group by eng;

insert into examtable value ("팽수", 209921, 100, 90, rand()*100);
insert into examtable value ("팽수", 209922, 100, 90, rand()*100);
insert into examtable value ("팽수", 209923, 100, 80, rand()*100);
select kor, count(kor), eng, count(eng) from examtable group by kor, eng;
select name, count(name), kor, count(kor), eng, count(eng) from examtable group by name, kor, eng;
select *, name, count(name), kor, count(kor), eng, count(eng) from examtable group by name, kor, eng; ## 당연히 에러

select eng, count(eng) from examtable group by eng having count(eng)>1;
SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS f_get_sum;
DELIMITER $$
CREATE FUNCTION f_get_sum(_id integer) RETURNS integer
BEGIN
	DECLARE _sum integer;
    SELECT kor+eng+mat INTO _sum FROM examtable WHERE id=_id;
RETURN _sum;
END $$
DELIMITER ;

select * ,f_get_sum(id) from examtable;








drop procedure if exists exam_calc;

DELIMITER $$
create procedure exam_calc (_page int, _ppcnt int)
BEGIN
	DECLARE _kor int;
	declare _eng int;
	declare _mat int;
	declare _sum int;
	declare _ave int;
	declare _start int;
    declare _startpoint int;
    set _startpoint = (_page - 1) * _ppcnt + _ppcnt;
    
    
    drop table if exists exam_calc_temp;
    create table exam_calc_temp(title varchar(50), kor int, eng int, mat int);
    
    insert into exam_calc_temp(title, kor, eng, mat) 
    select goodjob.studentid, goodjob.kor, goodjob.eng,
    goodjob.mat from goodjob limit _startpoint, _ppcnt;
    
    select *, kor+eng+mat as sum, (kor+eng+mat)/3 as ave from exam_calc_temp; 

    set _start = (_page - 1) * _ppcnt + _ppcnt;
    
    SELECT sum(kor) INTO _kor from exam_calc_temp limit 0, _ppcnt;
    SELECT sum(eng) INTO _eng from exam_calc_temp limit 0, _ppcnt;
    SELECT sum(mat) INTO _mat from exam_calc_temp limit 0, _ppcnt;
    SELECT sum(kor+eng+mat) INTO _sum from exam_calc_temp limit 0, _ppcnt;
    SELECT sum((kor+eng+mat)/3) INTO _ave from exam_calc_temp limit 0, _ppcnt;
    
    insert into reserv_stat (korave,engave,matave,sumave) select _kor, _eng, _mat, _sum;
    insert into nowpage_stat (korave,engave,matave,sumave) select _kor, _eng, _mat, _sum;
END $$
DELIMITER ;

call exam_calc(0, 30);

select *, kor+eng+mat as sum, (kor+eng+mat)/3 as ave from exam_calc_temp; 




    





























