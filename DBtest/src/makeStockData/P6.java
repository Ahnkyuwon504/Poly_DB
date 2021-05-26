package makeStockData;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class P6 {
 	public static void main(String[] args) throws IOException {
		File k20_f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\day_data\\THTSKS010H00.dat");
		BufferedReader k20_br = new BufferedReader (new FileReader(k20_f));
		
		File k20_f1 = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\StockDailyPrice.csv");
		BufferedWriter k20_bw1 = new BufferedWriter (new FileWriter(k20_f1));
		
		String k20_readtxt;
		
		int k20_cnt = 0; int k20_wcnt = 0;
		while ((k20_readtxt = k20_br.readLine()) != null) {
			StringBuffer k20_s = new StringBuffer();
			String[] k20_field = k20_readtxt.split("%_%");
			
			if (k20_field.length > 2 && k20_field[2].replace("^", "").
					trim().substring(0,1).equals("A")) {
				k20_s.append(k20_field[0].replace("^", "").trim());
				for (int j = 1; j < k20_field.length; j++) {
					k20_s.append("," + k20_field[j].replace("^", "").trim());
				}
				k20_bw1.write(k20_s.toString());k20_bw1.newLine();
				k20_wcnt++;
			}
			
			k20_cnt++;
		}
		
		k20_br.close();
		k20_bw1.close();
		
		System.out.printf("Program End[%d][%d]records\n", k20_cnt, k20_wcnt);

	}

}
