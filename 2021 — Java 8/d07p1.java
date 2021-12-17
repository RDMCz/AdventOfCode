package aoc2021;

public class d7p1 {
    
    public static void main(String[] args) throws Exception {
        
        String[] input = AoC2021.loadFile("d7p1");
        
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
                cost += (Math.abs(i - j)) * crabs[j];
            }
            costs[i] = cost;
        }
        
        int cheapest = Integer.MAX_VALUE;
        
        for (int i = 0; i < len; i++) {
            //System.out.println(i+" "+costs[i]);
            int temp = costs[i];
            if (temp < cheapest) cheapest = temp;
        }
        
        System.out.println(cheapest);
    }

}
