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

// freewifi(2) DB에 값 집어넣기

public class DBtest08 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException, IOException, CsvValidationException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     File f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\무료와이파이정보txt.txt");
	     BufferedReader br = new BufferedReader(new FileReader(f));
	     CSVReader reader = new CSVReader(new FileReader("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\무료와이파이정보txt.txt"));
	     
	     //String readtxt;
	     String [] readtxt;
//	     
//	     if((readtxt = reader.readNext()) == null) {
//	    	 System.out.println("빈 파일입니다.");
//	    	 return;
//	     }
	     int cnt = 0;
	     while ((readtxt = reader.readNext()) != null) {
	    	 for (int i = 0; i < readtxt.length; i++) {
	    		 System.out.println(i + " " + readtxt[i]);
	    	 }
	    	 System.out.println("현재 줄 : " + cnt);
	    	 cnt++;
	    	 
	     }
//	     String[] field_name = readtxt[0].split(",");
//	     System.out.println(field_name[0]);
//	     System.out.println(field_name[1]);
//	     System.out.println(field_name[2]);
//	     System.out.println(field_name[3]);
//	     
//	     int LineCnt = 0;
//	     while((readtxt = reader.readNext()) != null) {
//	    	 String[] field = readtxt[LineCnt].split(",");
//	    	 String QueryTxt;
//	    	 System.out.println("LineCnt : " + LineCnt);
//	    	 System.out.println(field.length);
//	    	 System.out.println(field[0]);
//	    	 System.out.println(field[1]);
//	    	 System.out.println(field[2]);
//	    	 System.out.println(field[3]);
//	    	 System.out.println(field[4]);
//	    	 
//	    	 System.out.printf("0번째 : %s 1번째 : %s 2번째 : %s 3번째 : %s 4번째 : %s"
//	    	 		+ "5번째 : %s 6번째 : %s 7번째 : %s 8번째 : %s 9번째 : %s"
//	    	 		+ "10번째 : %s 11번째 : %s 12번째 : %s 13번째 : %s 14번째 : %s", 
//	    	 		field[0], field[1], field[2], field[1], field[1],
//	    			 field[5], field[6], field[7], field[8], field[9],
//	    			 field[10], field[11], field[12], field[13], field[14]);
//	    	 
//	    	 QueryTxt = String.format("insert into freewifi ("
//	    			 + "inst_place, inst_place_detail, inst_city, inst_country, inst_place_flag, "
//	    			 + "service_provider, wifi_ssid, inst_date, place_addr_road, place_addr_land, "
//	    			 + "manage_office, manage_office_phone, latitue, longitude, write_date) "
//	    			 + "values ("
//	    			 + "'%s', '%s', '%s', '%s', '%s'"
//	    			 + "'%s', '%s', '%s', '%s', '%s'"
//	    			 + "'%s', '%s', %s, %s, '%s');",
//	    			 field[0], field[1], field[2], field[1], field[1],
//	    			 field[5], field[6], field[7], field[8], field[9],
//	    			 field[10], field[11], field[12], field[13], field[14]);
//	    	 stmt.execute(QueryTxt);
//	    	 System.out.printf("%d번째 항목 Insert OK [%s]\n", LineCnt, QueryTxt);
//	    			 
//	    	 LineCnt++;
//	    	 
//	    	 if(LineCnt == 2) break;
//	     }
	     br.close();
	     reader.close();
	     stmt.close(); 
	     conn.close(); 
	}
}
