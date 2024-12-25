package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d13p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d13p2");
        
        boolean part1 = false;
        List<Integer> inXs = new ArrayList<>();
        List<Integer> inYs = new ArrayList<>();
        List<String> instructions = new ArrayList<>();
        
        boolean inSwitch = true;
        int maxX = 0;
        int maxY = 0;
        
        // Zjisti dimenze papíru, zpracuj instrukce
        for (String line : input) {
            if (line.equals("")) {
                inSwitch = false;
                continue;
            }
            if (inSwitch) {
                String[] parts = line.split(",");
                int x = Integer.parseInt(parts[0]);
                int y = Integer.parseInt(parts[1]);
                if (x > maxX) maxX = x;
                if (y > maxY) maxY = y;
                inXs.add(x);
                inYs.add(y);
            }
            else {
                instructions.add(line.split(" ")[2]);
            }                        
        }
        
        maxX++;
        maxY++;
        
        // Vytvoř pole reprezentující papír, zakresli tečky
        boolean[][] paper = new boolean[maxY][maxX];
        int dots = inXs.size();
        for (int i = 0; i < dots; i++) {
            paper[inYs.get(i)][inXs.get(i)] = true;
        }
        
        // Proveď instrukce
        for (String comm : instructions) {
            String[] parts = comm.split("=");
            String axis = parts[0];
            int value = Integer.parseInt(parts[1]);
            
            if (axis.equals("y")) {
                
                for (int i = value; i < maxY; i++) {
                    for (int j = 0; j < maxX; j++) {
                        if (paper[i][j]) {
                            int lenFromAxis = i - value;
                            paper[i - 2 * lenFromAxis][j] = true;
                        }
                    }
                }
                
                maxY = value;
            }            
            else if (axis.equals("x")) {
                
                for (int i = 0; i < maxY; i++) {
                    for (int j = value; j < maxX; j++) {
                        if (paper[i][j]) {
                            int lenFromAxis = j - value;
                            paper[i][j - 2 * lenFromAxis] = true;
                        }
                    }
                }
                
                maxX = value;
            }
            if (!part1) {
                int result = 0;
                for (int i = 0; i < maxY; i++) {
                    for (int j = 0; j < maxX; j++) {
                        if (paper[i][j]) result++;
                    }                    
                }
                System.out.println("Part 1: " + result);
                part1 = true;
            }
        }
        
        System.out.println("Part 2:");
        // Vykresli
        for (int i = 0; i < maxY; i++) {
            for (int j = 0; j < maxX; j++) {
                char ch = (paper[i][j]) ? '#' : ' ';
                System.out.print(ch);
            }
            System.out.println();
        }
        
    }    
}