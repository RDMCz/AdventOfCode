package aoc2021;

import java.util.Arrays;

public class d8p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d8p2");
        int len = input.length;
        
        String[][] output = new String[len][];
        String[][] patterns = new String[len][];
        
        for (int i = 0; i < len; i++) {       
            String[] parts = input[i].split(" \\| ");
            patterns[i] = parts[0].split(" ");
            output[i] = parts[1].split(" ");            
        }
        
        int result = 0;
        
        for (int i = 0; i < len; i++) {            
            
            String[] numbers = new String[10];
            
            // 1 4 7 8
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 2) numbers[1] = code;
                else if (codeLen == 4) numbers[4] = code;
                else if (codeLen == 3) numbers[7] = code;
                else if (codeLen == 7) numbers[8] = code;                
            }   
                        
            // 3
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 5) {
                    if (code.contains(numbers[1].charAt(0) + "") && code.contains(numbers[1].charAt(1) + "")) {
                        numbers[3] = code;
                    }
                }
            }            
            
            String seg24 = numbers[4];
            seg24 = seg24.replace(numbers[1].charAt(0) + "", "");
            seg24 = seg24.replace(numbers[1].charAt(1) + "", "");
            
            // 5            
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 5) {
                    if (!code.equals(numbers[3]) && code.contains(seg24.charAt(0) + "") && code.contains(seg24.charAt(1) + "")) {
                        numbers[5] = code;
                    }
                }
            }
                        
            // 2
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 5) {
                    if (!code.equals(numbers[3]) && !code.equals(numbers[5])) {
                        numbers[2] = code;
                    }
                }
            }
            
            String seg4 = (numbers[3].contains(seg24.charAt(0) + "")) ? seg24.charAt(0) + "" : seg24.charAt(1) + "";
            
            // 0
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 6) {                    
                    if (!code.contains(seg4)) {
                        numbers[0] = code;
                    }
                }
            }            
            
            // 9
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 6) {
                    if (!code.equals(numbers[0]) && code.contains(numbers[1].charAt(0) + "") && code.contains(numbers[1].charAt(1) + "")) {
                        numbers[9] = code;
                    }
                }
            }
            
            // 6
            for (int j = 0; j < 10; j++) {
                String code = patterns[i][j];
                int codeLen = code.length();
                if (codeLen == 6) {
                    if (!code.equals(numbers[0]) && !code.equals(numbers[9])) {
                        numbers[6] = code;
                    }
                }
            }
                        
            char[][] numbersSorted = new char[10][];
            
            for (int j = 0; j < 10; j++) {
                char[] chars = numbers[j].toCharArray();
                Arrays.sort(chars);
                numbersSorted[j] = chars;
            }            
            
            int value = 0;
            int multiplier = 1000;
            
            for (int j = 0; j < 4; j++) {
                char[] chars = output[i][j].toCharArray();
                Arrays.sort(chars);                
                for (int k = 0; k < 10; k++) {
                    if (Arrays.equals(numbersSorted[k], chars)) {
                        value += k * multiplier;
                    }
                }
                multiplier /= 10;
            }            
            
            result += value;
        }
        
        System.out.println(result);
    }

}
