import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// 테이블에 있는것들 출력

public class DBtest01 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		Class.forName("com.mysql.cj.jdbc.Driver"); 
	     Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc",                  
	                                       "root" , "kopoctc");
	      
	     Statement stmt = conn.createStatement(); 
	     ResultSet rset = stmt.executeQuery("select * from examtable;"); 
	     while (rset.next()) { 
	          //결과물 처리 
	    	 System.out.println("이름 : " + rset.getString(1));
	    	 System.out.println("학번 : " + rset.getInt(2));
	    	 System.out.println("국어 : " + rset.getInt(3));
	    	 System.out.println("영어 : " + rset.getInt(4));
	    	 System.out.println("수학 : " + rset.getInt(5));
	    	 System.out.println("*************************");
	      } 
	     rset.close(); 
	     stmt.close(); 
	     conn.close(); 


	}

}
