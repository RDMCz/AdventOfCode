package aoc2021;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class d9p2 {
    
    static int[][] cave;
    static int[][] used;
    static int len;
    static int len2;    
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d9p2");
        len = input.length;
        len2 = input[0].length();
        
        cave = new int[len][len2];
        used = new int[len][len2];
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                cave[i][j] = Character.getNumericValue(input[i].charAt(j));
            }
        }
        
        List<Integer> sizes = new ArrayList<>();
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                
                boolean low = true;
                int crnt = cave[i][j];                
                if (low && i != 0 && cave[i-1][j] <= crnt) low = false; //up                
                if (low && j != 0 && cave[i][j-1] <= crnt) low = false; //left               
                if (low && j != len2 - 1 && cave[i][j+1] <= crnt) low = false; //right                
                if (low && i != len - 1 && cave[i+1][j] <= crnt) low = false; //down             
                
                if (low) {                     
                    sizes.add(Seek(i,j));                    
                }
            }            
        }          
        
        Collections.sort(sizes);
        int basins = sizes.size();
        int result = 1;
        for (int i = 1; i <= 3; i++) {
            result *= sizes.get(basins-i);            
        }
                
        System.out.println(result);              
    }
    
    public static int Seek(int i, int j) {
        
        int result = 1;
        int crnt = cave[i][j];        
        used[i][j] = 1;                
        
        //up
        if (i != 0 && used[i-1][j] == 0 && cave[i-1][j] != 9 && cave[i-1][j] > crnt) result += Seek(i-1, j);            
        //left
        if (j != 0 && used[i][j-1] == 0 && cave[i][j-1] != 9 && cave[i][j-1] > crnt) result += Seek(i, j-1);
        //right
        if (j != len2 - 1 && used[i][j+1] == 0 && cave[i][j+1] != 9 && cave[i][j+1] > crnt) result += Seek(i, j+1);
        //down
        if (i != len - 1 && used[i+1][j] == 0 && cave[i+1][j] != 9 && cave[i+1][j] > crnt) result += Seek(i+1, j);       
            
        return result;
    }

}
