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
// 실습2) 파일을 읽어서 table에 집어넣기(P-KEY)
////////////////////////////////////////////////////////////////////////
public class BT12 {
	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// MySQL 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 쿼리를 stmt에 넣을 거다...
		Statement stmt = conn.createStatement();
		// 파일의 경로 지정..
		File f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\주차장txt.txt");
		BufferedReader br = new BufferedReader(new FileReader(f));
		// 한줄 한줄 넣을 String 생성
		String readtxt;
		// 만일 첫줄이 없다면.. 빈 파일이므로 alert
		if ((readtxt = br.readLine()) == null) {
			System.out.println("빈 파일입니다.");
			// 이경우에도 close는 해야한다...
			br.close();
			// 알려주고 종료...
			return;
		}
		// 탭으로 나눠준다...
		String[] field_name = readtxt.split("\t");
		// 라인 수를 세어줄 LineCnt 생성
		int LineCnt = 1;
		// while문으로 자료 끝까지 반복
		while ((readtxt = br.readLine()) != null) {
			// 마찬가지로 탭으로 나눠준다...
			String[] field = readtxt.split("\t");
			// 쿼리 담을 String 생성
			String QueryTxt;

			// 쿼리문 생성
			QueryTxt = String.format(
					"insert into parking (number, name, longitude, latitude, division, "
							+ "type, location, roadlocation, size, openday)\r\n"
							+ " values (%s, '%s', %s, %s, '%s', '%s', '%s', '%s', %s, '%s');",
					field[0], field[1], field[2], field[3], field[4], field[5], field[6], field[7], field[8], field[9]);
			stmt.execute(QueryTxt);
			// 쿼리 실행...
			System.out.printf("%d번째 항목 Insert OK\n", LineCnt);
			// 몇번째 항목인지 알려 준다...
			LineCnt++;
		}
		br.close(); // 끝났으면 닫아 주자..
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}
}
