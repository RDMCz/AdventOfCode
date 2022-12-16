package aoc2021;

public class d3p1 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d3p1");
        
        int check;
        
        int len = input[0].length();
        String finalNum = "";
        String ones = "";
        
        for (int i = 0; i < len; i++) {
            
            check = 0;
            for (String item : input) {            
                if (item.charAt(i) == '1') check++; else check--;                  
            }
            
            finalNum += (check > 0) ? "1" : "0";
            ones += "1";
        }               
        
        int gamma = Integer.parseInt(finalNum, 2);
        int max = Integer.parseInt(ones, 2);
        int epsilon = max - gamma;
        
        int result = gamma * epsilon;
        System.out.println(result);
    }

}
