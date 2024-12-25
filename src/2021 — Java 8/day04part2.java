package aoc2021;

public class d4p2 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d4p2");

        String[] draws = input[0].split(",");

        int bingosLen = (input.length - 1) / 6;

        String[][][] bingos = new String[bingosLen][][];

        for (int i = 0; i < bingosLen; i++) {
            String[][] bingo = new String[5][];
            for (int j = 0; j < 5; j++) {
                bingo[j] = new String[5];
                for (int k = 0; k < 5; k++) {
                    String num = input[(2 + i * 6) + j].substring(k * 3, k * 3 + 2);
                    bingo[j][k] = (num.charAt(0) == ' ') ? Character.toString(num.charAt(1)) : num;
                }
            }
            bingos[i] = bingo;
        }

        int[][] matches = new int[bingosLen][];
        for (int i = 0; i < bingosLen; i++) {
            matches[i] = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        }

        int[][][] marked = new int[bingosLen][][];
        for (int i = 0; i < bingosLen; i++) {
            int[][] temp = new int[5][];
            for (int j = 0; j < 5; j++) {
                temp[j] = new int[]{0, 0, 0, 0, 0};
            }
            marked[i] = temp;
        }

        //boolean winner = false;
        int winnerBingo = -1;
        int lastDraw = -1;

        int winners = 0;
        int[] winnerBingos = new int[bingosLen];
        for (int i = 0; i < bingosLen; i++) {
            winnerBingos[i] = 0;
        }

        for (String draw : draws) {
            for (int i = 0; i < bingosLen; i++) {
                if (winnerBingos[i] == 1) {
                    continue;
                }
                for (int j = 0; j < 5; j++) {
                    for (int k = 0; k < 5; k++) {
                        if (draw.equals(bingos[i][j][k])) {
                            matches[i][j]++;
                            matches[i][5 + k]++;
                            marked[i][j][k] = 1;
                            if (matches[i][j] == 5 || matches[i][5 + k] == 5) {

                                winners++;
                                winnerBingos[i] = 1;
                                winnerBingo = i;
                                lastDraw = Integer.parseInt(draw);
                                break;
                            }
                        }
                    }
                    if (winners == bingosLen) {
                        break;
                    }
                }
                if (winners == bingosLen) {
                    break;
                }
            }
            if (winners == bingosLen) {
                break;
            }
        }

        int sum = 0;

        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                if (marked[winnerBingo][i][j] == 0) {
                    sum += Integer.parseInt(bingos[winnerBingo][i][j]);
                }
            }
        }

        System.out.println(sum + " * " + lastDraw);
        int result = sum * lastDraw;
        System.out.println(result);
    }

}
