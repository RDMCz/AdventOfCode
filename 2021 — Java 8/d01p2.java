package aoc2021;

public class d1p2 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d1p2");

        int crnt, i0, i1, i2;
        int prev = -1;
        int result = 0;

        for (int i = 0; i < input.length - 2; i++) {
            i0 = Integer.parseInt(input[i]);
            i1 = Integer.parseInt(input[i + 1]);
            i2 = Integer.parseInt(input[i + 2]);
            crnt = i0 + i1 + i2;
            if (prev != -1) if (crnt > prev) result++;
            prev = crnt;
        }

        System.out.println(result);
    }

}
