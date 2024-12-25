package aoc2021;

import java.util.ArrayList;
import java.util.List;

public class d3p2 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d3p2");
        
        int genC, scrC, gen = -1, scr = -1;        
        int len = input[0].length();
        
        char genF, scrF;
        
        List<String> genL = new ArrayList<>();
        List<String> scrL = new ArrayList<>();
        
        for (String item : input) {            
            genL.add(item);                 
            scrL.add(item);                 
        }        
        
        for (int i = 0; i < len; i++) {
            
            genC = 0;
            scrC = 0;
            for (String item : genL) {            
                if (item.charAt(i) == '1') genC++; else genC--;                  
            }
            for (String item : scrL) {            
                if (item.charAt(i) == '1') scrC++; else scrC--;                  
            }
            
            genF = (genC >= 0) ? '1' : '0';
            scrF = (scrC < 0) ? '1' : '0';            
            
            final int ii = i;
            final char genFF = genF;
            final char scrFF = scrF;
            
            genL.removeIf((String item) -> item.charAt(ii) != genFF);
            scrL.removeIf((String item) -> item.charAt(ii) != scrFF);
            
            if (genL.size() == 2) {
                int temp1 = Integer.parseInt(genL.get(0),2);
                int temp2 = Integer.parseInt(genL.get(1),2);
                gen = (temp1 > temp2) ? temp1 : temp2;
            }
            
            if (scrL.size() == 2) {
                int temp1 = Integer.parseInt(scrL.get(0),2);
                int temp2 = Integer.parseInt(scrL.get(1),2);
                scr = (temp1 > temp2) ? temp1 : temp2;
            }
            
            if (genL.size() == 1) gen = Integer.parseInt(genL.get(0),2);
            if (scrL.size() == 1) scr = Integer.parseInt(scrL.get(0),2);
        }        
        
        int result = gen * scr;
        System.out.println(result);
    }

}
