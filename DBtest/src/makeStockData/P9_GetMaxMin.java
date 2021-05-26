package makeStockData;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class P9_GetMaxMin {

	public static void main(String[] args) throws IOException {
		File k20_f = new File("E:\\Download\\새 폴더 (2)\\day_data\\StockDailyPrice.csv");
		BufferedReader k20_br = new BufferedReader(new FileReader(k20_f));

		String k20_readtxt;
		int k20_Max_2015_closing = Integer.MIN_VALUE;
		int k20_Min_2015_closing = Integer.MAX_VALUE;

		while ((k20_readtxt = k20_br.readLine()) != null) {
			String[] k20_field = k20_readtxt.split(",");

			if (k20_field[1].contains("2015") && k20_field[2].equals("A005930")) {
				if (Integer.parseInt(k20_field[3]) > k20_Max_2015_closing) {
					k20_Max_2015_closing = Integer.parseInt(k20_field[3]);
				}
				
				if (Integer.parseInt(k20_field[3]) < k20_Min_2015_closing) {
					k20_Min_2015_closing = Integer.parseInt(k20_field[3]);
				}
			}
		}
		k20_br.close();
		System.out.printf("Max : %d\nMin : %d\n", k20_Max_2015_closing, k20_Min_2015_closing);
	}
}
