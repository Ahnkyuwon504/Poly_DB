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
// #freewifi(2) / 2021. 05. 24. / 2125341020안규원
// 실습3) 복합 프라이머리 키 구성, 재실습
////////////////////////////////////////////////////////////////////////

public class DBtest082 {

	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// MySQL 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
		// 쿼리를 stmt에 넣을 거다...
		Statement stmt = conn.createStatement();
		// 파일의 경로 지정..
		File f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\전국무료와이파이표준데이터1.txt");
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
			System.out.println("LineCnt : " + LineCnt);
			// 그러고도 다른 데이터상 공백 존재한다면... null 위배할수있으므로 0으로 부여

			for (int i = 0; i < field.length; i++) {
				if (field[i].length() == 0) {
					field[i] = "0";
				}
			}
			// 쿼리문 생성
			QueryTxt = String.format(
					"insert into freewifi ("
							+ "inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag, "
							+ "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land, "
							+ "manage_office, manage_office_phone, latitue, longitude, write_date) " + "values ("
							+ "'%s', '%s', '%s', '%s', '%s', " + "'%s', '%s', '%s', '%s', '%s', "
							+ "'%s', '%s', %s, %s, '%s');",
					field[0], field[1], field[2], field[3], field[4], field[5], field[6], field[7], field[8], field[9],
					field[10], field[11], field[12], field[13], field[14]);
			stmt.execute(QueryTxt);
			System.out.printf("%d번째 항목 Insert OK [%s]\n", LineCnt, QueryTxt);

			LineCnt++;
		}
		br.close();
		stmt.close();
		conn.close();
	}
}
