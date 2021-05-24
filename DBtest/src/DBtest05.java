import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//테이블에 레코드 집어넣기

public class DBtest05 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement();
	     
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('효민', 209901, 95, 100, 95);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('보람', 209902, 90, 100, 90);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('은정', 209903, 95, 80, 95);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('지연', 209904, 95, 100, 95);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('소연', 209905, 95, 100, 95);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('큐리', 209906, 95, 100, 95);");
	     stmt.execute( "insert into examtable2 (name, studentid, kor, eng, mat) values ('화영', 209907, 95, 100, 95);");
	     
	     stmt.close(); 
	     conn.close(); 


	}

}
