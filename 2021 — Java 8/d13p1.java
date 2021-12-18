// Tenhle kód je pěkně nechutnej, funguje na první přehyb, pro více už ale (nejspíš) začne dávat špatné hodnoty

package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d13p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d13p1");
        
        List<PaperPoint> points = new ArrayList<>();
        List<String> folds = new ArrayList<>();
        int maxX = 0;
        int maxY = 0;
        boolean inputSwitch = true;
        
        for (String line : input) {
            if (line.equals("")) {
                inputSwitch = false;
                continue;
            }
            if (inputSwitch) {
                String[] parts = line.split(",");
                int x = Integer.parseInt(parts[0]);
                int y = Integer.parseInt(parts[1]);
                if (x > maxX) maxX = x;
                if (y > maxY) maxY = y;
                points.add(new PaperPoint(x,y));
            }
            else {                
                folds.add(line.split(" ")[2]);
            }                
        }
        
        int foldNumber = 0;
        
        for (String instruction : folds) {
            String[] parts = instruction.split("=");
            String axis = parts[0];            
            int value = Integer.parseInt(parts[1]);
            if (axis.equals("y")) {
                for (PaperPoint point : points) point.foldY(value, maxY);
                maxY = value - 1;                   
            }
            else {
                for (PaperPoint point : points) point.foldX(value, maxX);
                maxX = value - 1;
            }
            
            System.out.println("After fold " + (++foldNumber) + ":");
            int dots = countDots(points);
            System.out.println(dots + " dots are visible");
            
            break;
        }        
    }
    
    static int countDots(List<PaperPoint> points) {
        int dots = 0;
        
        List<PaperPoint> uniqPoints = new ArrayList<>();
        
        for (PaperPoint point : points) {
            boolean fresh = true;
            for (PaperPoint uPoint : uniqPoints) {
                if (point.x == uPoint.x && point.y == uPoint.y) {
                    fresh = false;
                    break;
                }
            }
            if (fresh) uniqPoints.add(point);
        }
        
        points = uniqPoints;
        return points.size();
    }
}

class PaperPoint {
    
    int x;
    int y;
    
    public PaperPoint(int x, int y) {
        this.x = x;
        this.y = y;
    }
    
    void foldY(int value, int maxY) {
        if (y <= value) return;
        y = maxY - y;
    }
    
    void foldX(int value, int maxX) {
        if (x <= value) return;
        x = maxX - x;
    }
} 