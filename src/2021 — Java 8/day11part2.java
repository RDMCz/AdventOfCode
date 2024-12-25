package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d11p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d11p2");
        int len = input.length;
        int len2 = input[0].length();
        
        Dumbo[][] grid = new Dumbo[len][len2];
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                grid[i][j] = new Dumbo(Character.getNumericValue(input[i].charAt(j)));
            }
        }
        
        List<Dumbo> dumbos = new ArrayList<>();
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                
                Dumbo d = grid[i][j];
                
                if (i != 0) {
                    if (j != 0) d.adjanced.add(grid[i-1][j-1]);
                    d.adjanced.add(grid[i-1][j]);
                    if (j != len2 - 1) d.adjanced.add(grid[i-1][j+1]);
                } 
                if (i != len - 1) {
                    if (j != 0) d.adjanced.add(grid[i+1][j-1]);
                    d.adjanced.add(grid[i+1][j]);
                    if (j != len2 - 1) d.adjanced.add(grid[i+1][j+1]);
                }
                if (j != 0) d.adjanced.add(grid[i][j-1]);
                if (j != len2 - 1) d.adjanced.add(grid[i][j+1]);     
                
                dumbos.add(d);
            }
        }    
        
        int result;
        
        for (int i = 0 ;; i++) {
            int flashes = 0;
            for (Dumbo d : dumbos) {
                d.increase();
            }
            for (Dumbo d : dumbos) {
                if (d.energy == 10) {
                    d.energy = 0;   
                    flashes++;
                }
            }  
            if (flashes == 100) {
                result = i + 1;
                break;
            }
        }               
        
        System.out.println(result);
    }
}
