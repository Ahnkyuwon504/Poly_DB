package DBStock;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvValidationException;
////////////////////////////////////////////////////////////////////////
// # Training / 2021. 05. 26. / 2125341020안규원
// 실습 2) 파일을 읽어서 table에 집어넣기
// 단축코드, 일자, 시가, 고가, 저가, 종가, 거래량, 거래대금
// 복합 P-KEY : 일자, 단축코드
// DB실행 시작시간, 실행종료시간, 처리레코드 수 찍기
////////////////////////////////////////////////////////////////////////
public class DBStockInsertTable {
	public static void main(String[] args)
			throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 드라이버 적재...
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/stock", "root", "kopoctc");
		// 데이터베이스와 자바 연결..
		String QueryTxt = "insert into stockdailyprice"
				+ "(shrn_iscd, bsop_date, stck_oprc, stck_hgpr, "
				+ "stck_lwpr, stck_prpr, acml_vol, acml_tr_pbmn) "
				+ "values (?, ?, ?, ?, ?, ?, ?, ?);";
		PreparedStatement pstmt = conn.prepareStatement(QueryTxt);
		// 대용량 데이터를 빠르게 Insert 하기 위해 PreparedStatement 이용
		// 캐시에 SQL 문장을 담아 한번에 처리하기 때문에 Statement보다 처리속도가 빠르다...
		File f = new File("C:\\StockDailyPrice.csv");
		// 파일의 경로 지정..
		BufferedReader br = new BufferedReader(new FileReader(f));
		// 한줄 한줄 넣을 String 생성
		
		
		String readtxt; // 읽어온 파일 한줄씩 저장하기 위해 문자열 변수 선언
		
		if ((readtxt = br.readLine()) == null) {   // 첫줄이 null이면 빈 파일이므로
			System.out.println("빈 파일입니다."); // 출력해서 알려준다.
			return;
		}
		
		String[] field_name = readtxt.split(",");
		// 필드명을 나눠서 저장...
		int LineCnt = 0;
		int ErrorLineCnt = 0;
		// 라인 수 저장하기 위한 변수 선언
		conn.setAutoCommit(false);
		// insert 속도 향상 위해 AutoCommit false 설정
		
		long startTime = System.currentTimeMillis(); // 시작시간 저장...
		
		while ((readtxt = br.readLine()) != null) {
			if (LineCnt%1000000 == 0) {
				System.out.println("현재 : " + LineCnt);
			}
			
			if (LineCnt >= 11140000) {
			String[] field = readtxt.split(",");
			
			pstmt.setString(1, field[2]);  // 첫번째 ?에 2번 필드인 단축 종목코드 입력
			pstmt.setString(2, field[1]);  // 두번째 ?에 1번 필드인 일자 입력
			pstmt.setString(3, field[4]);  // 세번째 ?에 4번 필드인 시가 입력
			pstmt.setString(4, field[5]);  // 네번째 ?에 5번 필드인 고가 입력
			pstmt.setString(5, field[6]);  // 다섯번째 ?에 6번 필드인 저가 입력
			pstmt.setString(6, field[3]);  // 여섯번째 ?에 3번 필드인 종가 입력
			pstmt.setString(7, field[11]); // 일곱번째 ?에 11번 필드인 거래량 입력
			pstmt.setString(8, field[12]); // 여덟번째 ?에 12번 필드인 거래대금 입력
			pstmt.addBatch();
			
			System.out.printf("%d번째 항목 addBatch OK\n", LineCnt); // addBatch 성공 출력
			pstmt.clearParameters(); // 파라미터 비운다..
			}
			LineCnt++; 				 // LineCnt 증가
			
//			try {
//				if (LineCnt%10000 == 0) {	// 1만줄 읽을 때 마다
//					pstmt.executeBatch();	// executeBatch 호출하여 캐시의 SQL문장 실행
//					conn.commit();			// commit 호출하여 데이터 영구히 저장
//				}
//			} catch (Exception e) {			// 예외 발생시
//				e.printStackTrace();		// 메시지 출력
//				ErrorLineCnt++;
//			}
		}
		
		try {
			pstmt.executeBatch();			// 1만줄 단위 끝나면.. 마지막 페이지 문장실행
		} catch (Exception e) {				// 예외 발생시
			e.printStackTrace(); 			// 메시지 출력
		}
		
		conn.commit();						// 마찬가지다.. commit 호출해서 데이터 영구히 저장
		conn.setAutoCommit(true);			// 다시 AutoCommit을 true로 바꿔 준다..
		
		long endTime = System.currentTimeMillis(); // 끝나는 시간
		
		System.out.printf("Insert End\n");							// 종료시 출력 문구
		System.out.printf("total : %d\n", LineCnt);					// 몇 개 되었는지
		System.out.printf("error total : %d\n", ErrorLineCnt);					// 몇 개 되었는지
		System.out.printf("time : %dms\n", endTime - startTime);	// 소요 시간 출력
		
		br.close();	   // 끝났으면 닫아 주자..
		pstmt.close(); // 끝났으면 닫아 주자..
		conn.close();  // 끝났으면 닫아 주자..
	}
}
