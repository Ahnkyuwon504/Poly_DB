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
// 실습1) 현재꺼 그대로 해보기
////////////////////////////////////////////////////////////////////////

public class DBtest08AddKeysRecreate {

	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     File f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\전국무료와이파이표준데이터1.txt");
	     BufferedReader br = new BufferedReader(new FileReader(f));
	     
	     String readtxt;
	     if((readtxt = br.readLine()) == null) {
	    	 System.out.println("빈 파일입니다.");
	    	 br.close();
	    	 return;
	     }
	     String[] field_name = readtxt.split("\t");
	     
	     int LineCnt = 1;
	     while((readtxt = br.readLine()) != null) {
	    	 String[] field = readtxt.split("\t");
	    	 String QueryTxt;
	    	 
	    	 for (int i = 0; i < field.length; i++) {
	    		 if (field[i].length() == 0) {
	    			 field[i] = "0";
	    		 }
	    	 }
	    	 
	    	 
	    	 QueryTxt = String.format("insert ignore into freewifi4 ("
	    			 // ignore 통해 중복행은 insert하지 않는다...
	    			 + "inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag, "
	    			 // 첫번째 ~ 다섯번째 칼럼
	    			 + "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land, "
	    			 // 여섯번째 ~ 열번째 칼럼
	    			 + "manage_office, manage_office_phone, latitue, longitude, write_date) "
	    			 // 열한번째 ~ 열다섯번째 칼럼
	    			 + "values ("
	    			 // 실제 넣을 값들
	    			 + "'%s', '%s', '%s', '%s', '%s', "
	    			 // 첫번째 ~ 다섯번째에 순서대로 들어갈 value들
	    			 + "'%s', '%s', '%s', '%s', '%s', "
	    			 // 다섯번째 ~ 열번째에 순서대로 들어갈 value들
	    			 + "'%s', '%s', %s, %s, '%s');",
	    			 // 열한번째 ~ 열다섯번째에 순서대로 들어갈 value들
	    			 field[0], field[1], field[2], field[3], field[4],
	    			 field[5], field[6], field[7], field[8], field[9],
	    			 field[10], field[11], field[12], field[13], field[14]);
	    	 
	    	 stmt.execute(QueryTxt);
	    	 
	    	 System.out.printf("%d번째 항목 Insert OK\n", LineCnt);
	    			 
	    	 LineCnt++;
	     }
	     br.close();
	     stmt.close(); 
	     conn.close(); 
	}
}

