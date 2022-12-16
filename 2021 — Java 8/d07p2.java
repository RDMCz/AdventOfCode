package aoc2021;

public class d7p2 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d7p2");
        
        long crabCountL = input[0].chars().filter(ch -> ch == ',').count() + 1;
        int crabCount = Math.toIntExact(crabCountL);
        
        String[] parts = input[0].split(",");
        
        int[] crabsRaw = new int[crabCount];
        int min = Integer.MAX_VALUE;
        int max = 0;
        
        for (int i = 0; i < crabCount; i++) {
            int temp = Integer.parseInt(parts[i]);
            crabsRaw[i] = temp;
            if (temp > max) max = temp;
            if (temp < min) min = temp;
        }
        
        int len = max - min + 1;
        
        int[] crabs = new int[len];
        
        for (int i = 0; i < crabCount; i++) {
            int temp = crabsRaw[i];
            crabs[temp]++;
        }
        
        int[] costs = new int[len];
        
        for (int i = min; i <= max; i++) {
            int cost = 0;
            for (int j = 0; j < len; j++) {                
                int temp = 0;
                int distance = Math.abs(i - j);                
                for (int k = 0; k < distance; k++) {
                    temp += k + 1;
                }                
                temp *= crabs[j];
                cost += temp;
            }
            costs[i] = cost;
        }
        
        int cheapest = Integer.MAX_VALUE;
        
        for (int i = 0; i < len; i++) {
            int temp = costs[i];
            //System.out.println(i+" "+temp);
            if (temp < cheapest) cheapest = temp;
        }
        
        System.out.println(cheapest);
    }

}
