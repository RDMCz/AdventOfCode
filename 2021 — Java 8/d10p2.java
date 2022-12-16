package aoc2021;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Stack;

public class d10p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d10p2");
        int len = input.length;
        
        Stack<Character> chunx;
        boolean done;
        List<Long> scores = new ArrayList<>();
                
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
                        if (c != chunx.pop()) done = true;                        
                }
                if (done) break;                
            }
            
            if (!done) {
                Collections.reverse(chunx);
                long score = 0;
                for (char c : chunx) {
                    score *= 5;
                    score += (c == ')') ? 1 : (c == ']') ? 2 : (c == '}') ? 3 : 4;                    
                }
                scores.add(score);
            }            
        }

        Collections.sort(scores);
        long result = scores.get(scores.size() / 2);
        
        System.out.println(result);        
    }

}
