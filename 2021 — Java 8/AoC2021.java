package aoc2021;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;

public class AoC2021 {
    
    public static void main(String[] args) throws Exception {
        
    }
    
    public static String[] loadFile(String filename) throws Exception {
        
        String cesta = "D:\\Kod\\NetBeans\\AoC2021\\zadani\\"+filename+".txt";
        Path path = Paths.get(cesta);
        
        File file = new File(cesta);
        Scanner sc = new Scanner(file);        
        
        int lines = (int)Files.lines(path).count();
        String[] rtrn = new String[lines];
        for (int i = 0; i < lines; i++) {
            rtrn[i] = sc.nextLine();
        }
        
        return rtrn;
    }

}
