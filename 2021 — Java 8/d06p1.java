package aoc2021;

public class d6p1 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d6p1");
        int inputLen = input[0].length();

        int[] fish = new int[9];

        for (int i = 0; i < inputLen; i++) {
            if (i % 2 != 0) {
                continue;
            }
            int num = Character.getNumericValue(input[0].charAt(i));
            fish[num]++;
        }
        
        final int days = 80;
        for (int i = 0; i < days; i++) {
            
            int temp[] = new int[9];
            
            for (int j = 8; j >= 1; j--) {
                temp[j-1] = fish[j];
            } 
            temp[6] += fish[0];
            temp[8] += fish[0];
            
            fish = temp;
        }
        
        int sum = 0;
        for (int i = 0; i < 9; i++) {
            //System.out.println(i+" - "+fish[i]);
            sum += fish[i];
        }
        System.out.println(sum);
    }

}
