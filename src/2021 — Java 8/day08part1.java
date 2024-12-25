package aoc2021;

public class d8p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d8p1");
        int len = input.length;
        
        String[][] output = new String[len][];
        
        for (int i = 0; i < len; i++) {
            output[i] = input[i].split(" \\| ")[1].split(" ");            
        }
        
        int count = 0;
        
        for (int i = 0; i < len; i++) {
            for (int j = 0; j < 4; j++) {
                String code = output[i][j];
                int codeLen = code.length();
                if (codeLen >= 2 && codeLen <= 4 || codeLen == 7) {
                    count++;
                }
            }            
        }
        
        System.out.println(count);
        
    }

}
