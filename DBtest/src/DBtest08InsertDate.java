import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;

////////////////////////////////////////////////////////////////////////
// #freewifi(2) / 2021. 05. 24. / 2125341020안규원
// 실습4) 설치년월 Date로 고쳐서 정제하기
////////////////////////////////////////////////////////////////////////
public class DBtest08InsertDate {
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
			// 만일 빈칸이면.. 연월이 없는 것이므로 1970년으로 정해준다..
			if (field[7].isEmpty()) {
				field[7] = "1970-01-01";
			} else {
				// 빈칸이 아니라면... -으로 split한 후 앞에가 month를 나타내므로...
				String month = field[7].split("-")[0];
				if (month.contains("Jan")) { // 1월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-01-01";
				} else if (month.contains("Feb")) { // 2월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-02-01";
				} else if (month.contains("Mar")) { // 3월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-03-01";
				} else if (month.contains("Apr")) { // 4월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-04-01";
				} else if (month.contains("May")) { // 5월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-05-01";
				} else if (month.contains("Jun")) { // 6월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-06-01";
				} else if (month.contains("Jul")) { // 7월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-07-01";
				} else if (month.contains("Aug")) { // 8월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-08-01";
				} else if (month.contains("Sep")) { // 9월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-09-01";
				} else if (month.contains("Oct")) { // 10월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-10-01";
				} else if (month.contains("Nov")) { // 11월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-11-01";
				} else if (month.contains("Dec")) { // 12월에 해당됨...
					field[7] = "20" + field[7].split("-")[1] + "-12-01";
				} else {
					if (field[7].split("-")[1].contains("Jan")) {  // 1월에 해당됨...
						field[7] = "2021-01-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Feb")) { // 2월에 해당됨...
						field[7] = "2021-02-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Mar")) { // 3월에 해당됨...
						field[7] = "2021-03-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Apr")) { // 4월에 해당됨...
						field[7] = "2021-04-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("May")) { // 5월에 해당됨...
						field[7] = "2021-05-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Jun")) { // 6월에 해당됨...
						field[7] = "2021-06-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Jul")) { // 7월에 해당됨...
						field[7] = "2021-07-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Aug")) { // 8월에 해당됨...
						field[7] = "2021-08-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Sep")) { // 9월에 해당됨...
						field[7] = "2021-09-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Oct")) { // 10월에 해당됨...
						field[7] = "2021-10-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Nov")) { // 11월에 해당됨...
						field[7] = "2021-11-" + field[7].split("-")[0];
					} else if (field[7].split("-")[1].contains("Dec")) { // 12월에 해당됨...
						field[7] = "2021-12-" + field[7].split("-")[0];
					}
				}
			}

			// 그러고도 다른 데이터상 공백 존재한다면... null 위배할수있으므로 0으로 부여
			for (int i = 0; i < field.length; i++) {
				if (field[i].length() == 0) {
					field[i] = "0";
				}
			}
			// 쿼리문 생성
			QueryTxt = String.format("insert ignore into freewifi8 ("
					+ "inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag, "
					+ "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land, "
					+ "manage_office, manage_office_phone, latitude, longitude, write_date) " + "values ("
					+ "'%s', '%s', '%s', '%s', '%s', " + "'%s', '%s', '%s', '%s', '%s', " + "'%s', '%s', %s, %s, '%s');",
					field[0], field[1], field[2], field[3], field[4], field[5], field[6], field[7], field[8], field[9],
					field[10], field[11], field[12], field[13], field[14]);
			stmt.execute(QueryTxt);
			LineCnt++;
			
			if (LineCnt == 3000) break;
		}
		br.close();
		stmt.close();
		conn.close();
	}
}
