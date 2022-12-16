package aoc2021;

public class d1p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d1p1");
        
        int crnt;
        int prev = -1;
        int result = 0;
        
        for (String item : input) {
            crnt = Integer.parseInt(item);
            if (prev != -1) {
                if (crnt > prev) result++;
            }
            prev = crnt;
        }
        
        System.out.println(result);
    }

}
