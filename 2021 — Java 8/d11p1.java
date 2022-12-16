package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d11p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d11p1");
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
        
        int flashes = 0;
        final int steps = 100;
        
        for (int i = 0; i < steps; i++) {
            for (Dumbo d : dumbos) {
                d.increase();
            }
            for (Dumbo d : dumbos) {
                if (d.energy == 10) {
                    d.energy = 0;
                    flashes++;
                }
            }                       
        }
        
        System.out.println(flashes);        
    }
}

class Dumbo {
    
    int energy;
    List<Dumbo> adjanced;
    
    public Dumbo(int energy) {
        this.energy = energy;
        this.adjanced = new ArrayList<>();
    }
    
    public void increase() {
        if (energy == 10) return;
        energy++;
        if (energy == 10) {
            for (Dumbo d : adjanced) {
                d.increase();
            }
        }
    }    
}
