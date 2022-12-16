package aoc2021;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

public class d14p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d14p1");
        int len = input.length;
        int codeLen = input[0].length();
        
        HashMap<String, Integer> map = new HashMap<>();
        
        for (int i = 1; i < codeLen; i++) {
            String line = input[0];
            String pair = (line.charAt(i-1) + "") + (line.charAt(i) + "");
            if (map.containsKey(pair)) {
                map.put(pair, map.get(pair) + 1);
            }
            else {
                map.put(pair, 1);
            }                   
        }
        
        final int steps = 10;
        //System.out.println("Template: " + map);
        for (int step = 0; step < steps; step++) {
            
            HashMap<String, Integer> temp = new HashMap<>();
            
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
            
            //System.out.println("After step "+(step+1)+": "+temp);
            map = temp;                
        }
        
        HashMap<Character, Integer> occurences = new HashMap<>();
        
        for (String pair : map.keySet()) {
            char ch1 = pair.charAt(0);   
            int qty = map.get(pair);
            if (occurences.containsKey(ch1)) {
                occurences.put(ch1, occurences.get(ch1) + qty);
            }            
            else {
                occurences.put(ch1, qty);
            }
        }
        
        System.out.println(occurences);
        
        List<Integer> values = new ArrayList<>();
        
        for (int value : occurences.values()) {
            values.add(value);
        }
        
        Collections.sort(values);
        
        System.out.println("Možná řešení:");
        
        int big = values.get(values.size() - 1);
        int small = values.get(0);
        
        System.out.println(big - (small + 1));
        System.out.println(big - small);
        System.out.println((big + 1) - small);
    }

}
