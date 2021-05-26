package makeStockData;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class P5 {

	public static void main(String[] args) throws IOException {
		File k20_f = new File("C:\\Users\\kyuwon\\Desktop\\홍필두교수님_DB\\day_data\\THTSKS010H00.dat");
		BufferedReader k20_br = new BufferedReader (new FileReader(k20_f));
		
		String k20_readtxt;
		int k20_LineCnt = 0;
		int k20_n = -1;
		StringBuffer k20_s = new StringBuffer();
		while(true) {
			char[] k20_ch = new char[1000];
			
			k20_n = k20_br.read(k20_ch);
			
			if(k20_n == -1) break;
			
			for (char k20_c : k20_ch) {
				if (k20_c == '\n') {
					System.out.printf("[%s]***\n", k20_s.toString());
					k20_s.delete(0, k20_s.length());
				} else {
					k20_s.append(k20_c);
				}
			}
			
			k20_LineCnt++;
		}
		System.out.printf("[%s]***\n", k20_s.toString());
		k20_br.close();
	}
}
