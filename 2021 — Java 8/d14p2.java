package aoc2021;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class d14p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d14p2");
        int len = input.length;
        int codeLen = input[0].length();
        
        HashMap<String, Long> map = new HashMap<>();
        
        for (int i = 1; i < codeLen; i++) {
            String line = input[0];
            String pair = (line.charAt(i-1) + "") + (line.charAt(i) + "");
            if (map.containsKey(pair)) {
                map.put(pair, map.get(pair) + 1);
            }
            else {
                map.put(pair, 1L);
            }                   
        }
        
        final int steps = 40;        
        for (int step = 0; step < steps; step++) {
            
            HashMap<String, Long> temp = new HashMap<>();
            
            for (int i = 2; i < len; i++) {
                
                String[] parts = input[i].split(" -> ");
                String pair = parts[0];
                String insert = parts[1];                
                
                for (String oldPair : map.keySet()) {                    
                    if (oldPair.equals(pair)) {
                        String newPair1 = pair.charAt(0) + insert;
                        if (temp.containsKey(newPair1)) {
                            temp.put(newPair1, temp.get(newPair1) + map.get(oldPair));
                        }
                        else {
                            temp.put(newPair1, map.get(oldPair));                            
                        }
                        String newPair2 = insert + pair.charAt(1);                        
                        if (temp.containsKey(newPair2)) {                            
                            temp.put(newPair2, temp.get(newPair2) + map.get(oldPair));
                        }
                        else {
                            temp.put(newPair2, map.get(oldPair));                           
                        }                        
                    }
                }                
            }
            
            map = temp;                
        }
        
        HashMap<Character, Long> occurences = new HashMap<>();
        
        for (String pair : map.keySet()) {
            char ch1 = pair.charAt(0);   
            long qty = map.get(pair);
            if (occurences.containsKey(ch1)) {
                occurences.put(ch1, occurences.get(ch1) + qty);
            }            
            else {
                occurences.put(ch1, qty);
            }
        }
                
        List<Long> values = new ArrayList<>();
        
        for (long value : occurences.values()) {
            values.add(value);
        }
        
        Collections.sort(values);
        
        System.out.println("Možná řešení:");
        
        long big = values.get(values.size() - 1);
        long small = values.get(0);
        
        System.out.println(big - (small + 1));
        System.out.println(big - small);
        System.out.println((big + 1) - small);
    }

}
