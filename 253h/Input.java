class Input
{
    public static void main(String args[])
    {
        Terminal t = new Terminal();
        String input1 = "^h^c^iDDD^r^rPPPP^d^bD^r^rD^rP^19P^d^bD^r^rD^rPPPP^d^bD^r^rD^rP^d^bDDD^r^rP";
        String input2 = "^h^c^i^04^^^13/ Y^d^b  /   Y^u^d^d^l^l^l^l^l^l^l^l^l^r^r^l^l^d<^48>^l^l^d/^b^o Y^d^r^r^66/^b  Y^b^d   Y /^d^l^lv^d^b===========^i^94O123456789^94A=======^u^u^u^u^u^u^l^lY^o^b^r/";
        run(t, input1);
        run(t, input2);
    }


    public static void run(Terminal t, String input1)
    {
        int i = 0;
        while (i < input1.length()){
            if (input1.substring(i, i+1).equals("^")) {
                if (Character.isDigit(input1.charAt(i+1))) {
                    t.parse(input1.substring(i, i+3));
                    i += 3;
                }
               else {
                    t.parse(input1.substring(i, i+2));
                    i += 2;
                }
            }
            else {
                t.parse(input1.substring(i, i+1));
                i ++;
            }
        }

        t.display();
    }
}
