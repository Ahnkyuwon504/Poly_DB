package makeStockData;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class P8_MakeDay_CSV {

	public static void main(String[] args) throws IOException {
		File k20_f = new File("E:\\Download\\새 폴더 (2)\\day_data\\StockDailyPrice.csv");
		BufferedReader k20_br = new BufferedReader (new FileReader(k20_f));
		
		File k20_f1 = new File("E:\\Download\\새 폴더 (2)\\day_data\\19951124.csv");
		BufferedWriter k20_bw1 = new BufferedWriter (new FileWriter(k20_f1));
		
		String k20_readtxt;
		int k20_cnt = 0;
		
		while ((k20_readtxt = k20_br.readLine()) != null) {
			String[] k20_field = k20_readtxt.split(",");
			
			if (k20_field[1].equals("19951124")) {
				k20_bw1.write(k20_readtxt); k20_bw1.newLine();
			}
			k20_cnt++;
		}
		
		k20_br.close();
		k20_bw1.close();
		
		System.out.printf("Program End[%d]records\n", k20_cnt);


	}

}
