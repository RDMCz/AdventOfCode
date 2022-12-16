package aoc2021;

public class d5p1 {

    public static void main(String[] args) throws Exception {

        String[] inputRaw = AoC2021.loadFile("d5p1");
        int len = inputRaw.length;

        int[][] input = new int[len][];

        for (int i = 0; i < len; i++) {
            String[] temp1 = inputRaw[i].split(" -> ");
            String[] part1 = temp1[0].split(",");
            String[] part2 = temp1[1].split(",");
            input[i] = new int[]{Integer.parseInt(part1[0]), Integer.parseInt(part2[0]), Integer.parseInt(part1[1]), Integer.parseInt(part2[1])};
        }

        int max = 0;

        for (int i = 0; i < len; i++) {
            for (int j = 0; j < 4; j++) {
                if (input[i][j] > max) {
                    max = input[i][j];
                }
            }
        }

        max += 1;
        System.out.println("max:" + max + "\n");

        int[][] sea = new int[max][];

        for (int i = 0; i < max; i++) {
            int[] temp = new int[max];
            for (int j = 0; j < max; j++) {
                temp[j] = 0;
            }
            sea[i] = temp;
        }

        for (int i = 0; i < len; i++) {

            int x1 = input[i][0];
            int x2 = input[i][1];
            int y1 = input[i][2];
            int y2 = input[i][3];

            if (x1 == x2) { // Vertical line                
                if (y1 < y2) {
                    for (int j = y1; j <= y2; j++) {
                        sea[j][x1]++;
                    }
                } else if (y2 < y1) {
                    for (int j = y2; j <= y1; j++) {
                        sea[j][x1]++;
                    }
                }
            }

            if (y1 == y2) { // Horizontal line
                if (x1 < x2) {
                    for (int j = x1; j <= x2; j++) {
                        sea[y1][j]++;
                    }
                } else if (x2 < x1) {
                    for (int j = x2; j <= x1; j++) {
                        sea[y1][j]++;
                    }
                }
            }

        }

        int result = 0;
        
        for (int i = 0; i < max; i++) {
            for (int j = 0; j < max; j++) {
                //System.out.print(sea[i][j]);
                if (sea[i][j] > 1) result++;
            }
            //System.out.println("");
        }        
        
        System.out.println("\n" + result);

    }

}
