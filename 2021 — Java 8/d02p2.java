package aoc2021;

public class d2p2 {

    public static void main(String[] args) throws Exception {

        String[] input = AoC2021.loadFile("d2p2");

        String[] parts;
        String comm;
        int val;
        
        int dep = 0;
        int hor = 0;
        int aim = 0;
        
        for (String item : input) {
            
            parts = item.split(" ");
            comm = parts[0];
            val = Integer.parseInt(parts[1]);
            if ("forward".equals(comm)) {
                hor += val;
                dep += aim * val;
            }
            else {
                if ("up".equals(comm)) val *= -1;
                aim += val;
            }
        }
        
        int result = dep * hor;
        System.out.println(result);
    }

}
