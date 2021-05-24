import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블 읽기
////////////////////////////////////////////////////////////////////////
//#examtable (4) / 2021. 05. 24. / 2125341020안규원
//테이블 읽기
////////////////////////////////////////////////////////////////////////
public class DBtest06 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement(); 
	     ResultSet rset = stmt.executeQuery("select * from examtable2;"); 
	     
	     System.out.printf("  이름   학번   국어  영어  수학\n");
	     while (rset.next()) {
	    	 System.out.printf("%4s %6d   %3d   %3d   %3d \n", 
	    			 rset.getString(1), rset.getInt(2), rset.getInt(3), rset.getInt(4), rset.getInt(5));
	      } 
	     rset.close(); 
	     stmt.close(); 
	     conn.close(); 


	}

}
