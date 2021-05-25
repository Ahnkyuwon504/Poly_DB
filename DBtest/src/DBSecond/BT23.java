package DBSecond;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;

////////////////////////////////////////////////////////////////////////
// Basic Training (1) / 2021. 05. 25. / 2125341020안규원
// 실습3) 페이지당 30명씩 성적집계표 출력
////////////////////////////////////////////////////////////////////////
public class BT23 {
	static int studentNumber = 0; // 학생 수... 이는 데이터에 따라 다르므로 0줌..
	static int onepageNumber = 30; // 한 페이지 최대 학생 수.. 내맘대로 바꿀수있다..

	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// MySQL 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc?allowMultiQueries=true", "root", "kopoctc");
		// 쿼리를 stmt에 넣을 거다...
		Statement stmt = conn.createStatement();
		// 쿼리 담을 String 생성
		String QueryTxt;
		ResultSet rset;
		// 쿼리문 생성
		QueryTxt = "select count(*) from goodjob;";
		rset = stmt.executeQuery(QueryTxt);
		while (rset.next()) {
			studentNumber = Integer.parseInt(rset.getString(1)); 
		}
		// 학생수 저장
		int page = studentNumber / onepageNumber; // 페이지 수
		int lastpage = studentNumber % onepageNumber; // 마지막 페이지의 학생 수..
		// 페이지별 총합 담을 table 생성
		stmt.execute("drop table if exists reserv_stat;");
		// 누적 담을 테이블..
		stmt.execute("SET GLOBAL log_bin_trust_function_creators = 1;");
		// update를 많이 하기 때문에 이거 넣어줘야 함...
		stmt.execute("create table reserv_stat (korave int, engave int, matave int, "
												+ "sumave int);");
		///////////////////////////////////////////////
		// 30명이 꽉 차는 페이지
		for (int i = 1; i <= page + 1; i++) {
			// 현재페이지 누적 담을 table
			stmt.execute("drop table if exists nowpage_stat;");
			// 만일 이미 존재시 지워 버려...
			stmt.execute("create table nowpage_stat (korave int, engave int, matave int, "
													+ "sumave int);");
			// 테이블 만들고...
			System.out.printf("%2d번째 페이지===========================================\n", i); // 맨 윗줄..
			System.out.printf("    학번    이름    국어    영어    수학    총합    평균\n", i); // 메뉴...
			QueryTxt = String.format("call exam_calc(%d, %d);", i - 1, onepageNumber);
			// 호출 한다... 이건 이미 만들어 놓음...
			rset = stmt.executeQuery(QueryTxt);
			// 결과 저장...
			while (rset.next()) {
				// while로 돌려 준다...
				System.out.printf("%4s%5s  %6s  %6d  %6d  %6d  %6d\n", // 자리 맞춰 주고... 
		    			 rset.getString(1), "홍길동", rset.getInt(2), rset.getInt(3), 
		    			 rset.getInt(4), rset.getInt(5), rset.getInt(6));
			}
			///////////////////////////////////////////////////////////////////////////////
			// 현재페이지 누적, 평균
			QueryTxt = String.format("select *, sumave/3 as aveave from nowpage_stat; "); // aveave는 자체적으로 부여...
			rset = stmt.executeQuery(QueryTxt); // 결과 저장...
			while (rset.next()) {
				// while문으로 돌려 준다...
				System.out.printf("현재총합          %6s  %6d  %6d  %6d  %6d\n", 
						rset.getString(1), rset.getInt(2), rset.getInt(3), 
						rset.getInt(4), rset.getInt(5));
				// 현재 총합 출력...
				System.out.printf("현재평균          %6s  %6d  %6d  %6d  %6d\n", 
						Integer.parseInt(rset.getString(1))/onepageNumber, rset.getInt(2)/onepageNumber, rset.getInt(3)/onepageNumber, 
						rset.getInt(4)/onepageNumber, rset.getInt(5)/onepageNumber);
				// 현재 평균 출력...
			}
			////////////////////////////////////////////////////////////////////////////////
			// 모든페이지 누적, 평균
			QueryTxt = String.format("select sum(korave), sum(engave), "
					+ "sum(matave), sum(sumave), sum(sumave)/3 as aveave from reserv_stat");
			// 마찬가지로 평균은 여기서 부여...
			rset = stmt.executeQuery(QueryTxt);
			// 결과 담아 주고...
			int nowallstudent = i * onepageNumber; // 누적이라서..현재까지의 학생 수 필요.. 평균 구해야 함..
			if (i == page + 1) { // 마지막 장이면... i곱이 아니라 그냥 모든 학생 수니깐...
				nowallstudent = studentNumber;
			}
			while (rset.next()) {
				// while로 돌려 주고...
				System.out.printf("누적총합          %6s  %6d  %6d  %6d  %6d\n", 
						rset.getString(1), rset.getInt(2), rset.getInt(3), 
						rset.getInt(4), rset.getInt(5));
				// 누적 총합....
				System.out.printf("누적평균          %6s  %6d  %6d  %6d  %6d\n", 
						Integer.parseInt(rset.getString(1))/(nowallstudent), rset.getInt(2)/nowallstudent, rset.getInt(3)/nowallstudent, 
						rset.getInt(4)/nowallstudent, rset.getInt(5)/nowallstudent);
				// 누적 평균...
			}
			System.out.printf("========================================================\n");
			
		}
		rset.close(); // 끝났으면 닫아 주자..
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
