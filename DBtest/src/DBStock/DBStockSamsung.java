package DBStock;

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
// # Training / 2021. 05. 26. / 2125341020안규원
// 실습 3) 삼성전자만 table로 만드는 쿼리
// 단축코드, 일자, 시가, 고가, 저가, 종가, 거래량, 거래대금
// 복합 P-KEY : 일자, 단축코드
// DB실행 시작시간, 실행종료시간, 처리레코드 수 찍기
////////////////////////////////////////////////////////////////////////
public class DBStockSamsung {
	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// MySQL 연결...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/stock", "root", "kopoctc");
		// 쿼리를 stmt에 넣을 거다...
		Statement stmt = conn.createStatement();
		// 쿼리 담을 String 생성
		String QueryTxt;
		for (int i = 1; i <= 1000; i++) {
			// 쿼리문 생성
			QueryTxt = String.format(
					"insert into goodjob (studentid, name, kor, eng, mat) " + "values ('%s', '%s', %d, %d, %d);",
					getID(i), "홍길동", getScore(), getScore(), getScore());
			// 랜덤 점수를 넣어 준다...
			stmt.execute(QueryTxt); // 실행 해주고...
			System.out.printf("%d번째 항목 Insert OK\n", i);
			// 몇번째인지 알려 준다...
		}
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
	}

	public static String getID(int i) {
		// 학번 획득 메소드...
		String studentid = "2021";
		// 2021로 시 작...
		if (0 < i && i < 10) { // 이 조건이면
			studentid += "000" + i; // 0이 3개
		} else if (10 <= i && i < 100) { // 여기서는
			studentid += "00" + i; // 0이 2개
		} else if (100 <= i && i < 1000) { // 여기서는
			studentid += "0" + i; // 0이 1개
		} else if (i == 1000) { // 마지막은
			studentid += i; // 그냥!
		}
		return studentid; // 리턴...
	}

	public static int getScore() { // 점수 획득 메소드...
		int score = (int) (Math.random() * 101);
		// 랜덤이용...0점 부터 100점 가능
		return score;
	}
}

// insert into goodjob (studentid, name, kor, eng, mat) values ('%s', '%s', %d, %d, %d);
