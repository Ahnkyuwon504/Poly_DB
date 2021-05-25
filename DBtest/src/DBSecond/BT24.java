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
public class BT24 {
	static int studentNumber = 0;
	static int onepageNumber = 30;

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
		int page = studentNumber / onepageNumber;
		int lastpage = studentNumber % onepageNumber;
		
		// 페이지별 총합 담을 table 생성
		stmt.execute("drop table if exists reserv_stat;");
		stmt.execute("create table reserv_stat (_kor int, _eng int, _mat int, "
												+ "_sum int, _ave int);");
		
		///////////////////////////////////////////////
		// 30명이 꽉 차는 페이지
		for (int i = 1; i <= page; i++) {
			QueryTxt = String.format(" "
					+ "select count(*) from freewifi;"
					+ "select count(*) from freewifi2;");
					
			stmt.execute(QueryTxt);
			
			QueryTxt = "select * from exam_calc_temp;";
			rset = stmt.executeQuery(QueryTxt);
			
			
			while (rset.next()) {
				System.out.printf("%4s %6d   %3d   %3d   %3d \n", 
		    			 rset.getString(1), rset.getInt(2), rset.getInt(3), 
		    			 rset.getInt(4), rset.getInt(5), rset.getInt(6));
			}
		}
		
		
		
		///////////////////////////////////////////////
		// 마지막 페이지, 30명 이하
		
		
		
		
		
		
//		
//		QueryTxt = String.format("");
//		stmt.execute(QueryTxt);
		rset.close(); // 끝났으면 닫아 주자..
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
