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
	    	 System.out.println("LineCnt : " + LineCnt);
	    	 
	    	 for (int i = 0; i < field.length; i++) {
	    		 if (field[i].length() == 0) {
	    			 field[i] = "0";
	    		 }
	    	 }
	    	 
	    	 QueryTxt = String.format("insert into freewifi ("
	    			 + "inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag, "
	    			 + "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land, "
	    			 + "manage_office, manage_office_phone, latitue, longitude, write_date) "
	    			 + "values ("
	    			 + "'%s', '%s', '%s', '%s', '%s', "
	    			 + "'%s', '%s', '%s', '%s', '%s', "
	    			 + "'%s', '%s', %s, %s, '%s');",
	    			 field[0], field[1], field[2], field[3], field[4],
	    			 field[5], field[6], field[7], field[8], field[9],
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
