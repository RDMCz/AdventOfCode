package aoc2021;

public class d9p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d9p1");
        int len = input.length;
        int len2 = input[0].length();
        
        int[][] cave = new int[len][len2];
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                cave[i][j] = Character.getNumericValue(input[i].charAt(j));
            }
        }
        
        int result = 0;
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < len2; j++) {
                
                boolean low = true;
                int crnt = cave[i][j];
                //System.out.println(crnt);
                
                //if (crnt == 9) low = false;
                
                //up
                if (low && i != 0 && cave[i-1][j] <= crnt) {
                    low = false;
                    //System.out.println("up "+cave[i-1][j]);
                }
                
                //left
                if (low && j != 0 && cave[i][j-1] <= crnt) {
                    low = false;
                    //System.out.println("left "+cave[i][j-1]);
                }
                
                //right
                if (low && j != len2 - 1 && cave[i][j+1] <= crnt) {
                    low = false;
                    //System.out.println("right "+cave[i][j+1]);
                }
                
                //down
                if (low && i != len - 1 && cave[i+1][j] <= crnt) {
                    low = false;
                    //System.out.println("down "+cave[i+1][j]);
                }
                
                if (low) result += crnt + 1;
            }            
        }
        
        System.out.println(result);
        
    }

}
