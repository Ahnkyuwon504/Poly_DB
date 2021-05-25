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
// 실습3) 최단거리 조회
////////////////////////////////////////////////////////////////////////
public class BT13 {
	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// MySQL 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 쿼리를 stmt에 넣을 거다...
		Statement stmt = conn.createStatement();
		double lat = 37.3860521; // 위도
		double lng = 127.1214038; // 경도
		String QueryTxt; // 쿼리 넣을 거다...
		QueryTxt = String.format(
				"select * from parking where " + "SQRT( POWER( latitude-%f,2) + POWER (longitude-%f,2) ) = "
						+ "(select MIN( SQRT( POWER( latitude-%f,2) + POWER (longitude-%f,2) ) ) from parking);",
				lat, lng, lat, lng);
		// 거리 최솟값 찾아주는 쿼리..
		ResultSet rset = stmt.executeQuery(QueryTxt);
		// 결과에 넣어준다...
		int iCnt = 0; // 카운트 세어준다..
		while (rset.next()) {
			System.out.printf("*(%d)*************************************************************\n", iCnt++);
			System.out.printf("주차장관리번호       : %s\n", rset.getString(1));
			System.out.printf("주차장명             : %s\n", rset.getString(2));
			System.out.printf("경도                 : %s\n", rset.getString(3));
			System.out.printf("위도                 : %s\n", rset.getString(4));
			System.out.printf("주차장구분           : %s\n", rset.getString(5));
			System.out.printf("주차장유형           : %s\n", rset.getString(6));
			System.out.printf("주차장지번주소       : %s\n", rset.getString(7));
			System.out.printf("주차장도로명주소     : %s\n", rset.getString(8));
			System.out.printf("주차구획수           : %s\n", rset.getString(9));
			System.out.printf("운영요일             : %s\n", rset.getString(10));
			System.out.printf("*****************************************************************\n");
		}
		rset.close(); // 끝났으면 닫아 주자..
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
