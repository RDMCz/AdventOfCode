package aoc2021;

import java.util.Stack;

public class d10p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d10p1");
        int len = input.length;
        
        Stack<Character> chunx;
        boolean done;
        
        int score = 0;
        
        for (int i = 0; i < len; i++) {
            chunx = new Stack<>();
            done = false;
            char[] line = input[i].toCharArray();
            for (int j = 0; j < line.length; j++) {
                char c = line[j];
                switch (c) {
                    case '(':
                        chunx.push(')');
                        break;
                    case '[':
                        chunx.push(']');
                        break;
                    case '{':
                        chunx.push('}');
                        break;
                    case '<':
                        chunx.push('>');
                        break;
                    default:
                        if (c != chunx.pop()) {
                            score += (c == ')') ? 3 : (c == ']') ? 57 : (c == '}') ? 1197 : 25137;
                            done = true;
                        }
                }
                if (done) break;
            }
        }
        
        System.out.println(score);
        
    }

}
