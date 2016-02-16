class Terminal
{
	private String screen[][];
	private int x_cursor;
	private int y_cursor;
	private int height;
	private int width;
	private boolean insert_mode = true;

	public Terminal(int h, int w, int x_cursor, int y_cursor)
	{
		this.screen = new String[h][w];
		this.height = h;
		this.width = w;
		this.x_cursor = x_cursor;
		this.y_cursor = y_cursor;
	}

	public Terminal()
	{
		this(10, 10, 0, 0);
	}

	public int range(int val, int max)
	{
		if (val < 0){
			return 0;
		}
		else if (val > max){
			return max;
		}
		else {
			return val;
		}
	}

	private void set_cursor(int x, int y)
	{
		x_cursor = range(x, width-1);
		y_cursor = range(y, height-1);
	}
	
	private void clean()
	{
		for (int y = 0; y < height; y++){
			for (int x = 0; x < width; x++){
				screen[y][x] = null;
			}
		}
	}

	private void write(String val)
	{
		screen[y_cursor][x_cursor] = val;
	}

	private void erase_row()
	{
		for (int i = x_cursor; i < width; i++)
			screen[y_cursor][i] = null;
	}

	private void shift_forward()
	{
		for (int x = width-1; x > x_cursor; x--) {
			screen[y_cursor][x] = screen[y_cursor][x-1];
		}
	}
	
	private void insert(String val)
	{
		if (insert_mode) shift_forward();
		write(val);
		set_cursor(x_cursor+1, y_cursor);
	}

	public void parse(String input)
	{
		if (input.substring(0, 1).equals("^")) {
			switch (input){
				case "^c":
					clean();
					break;
				case "^h":
					set_cursor(0, 0);
					break;
				case "^b":
					set_cursor(0, y_cursor);
					break;
				case "^d":
					set_cursor(x_cursor, y_cursor + 1);
					break;
				case "^u":
					set_cursor(x_cursor, y_cursor - 1);
					break;
				case "^l":
					set_cursor(x_cursor - 1, y_cursor);
					break;
				case "^r":
					set_cursor(x_cursor + 1, y_cursor);
					break;
				case "^e": 
					erase_row();
					break;
				case "^i":
					insert_mode = true;
					break;
				case "^o":
					insert_mode = false;
					break;
				case "^^":
					insert("^");
					break;
				default:
					set_cursor(Integer.parseInt(input.substring(2,3)),
							Integer.parseInt(input.substring(1, 2)));
					break;
			}
		} 
		else {
			insert(input);
		}
	}
	
	public void display()
	{
		for (int y = 0; y < height; y ++){
			for (int x = 0; x < width; x++){
				if (screen[y][x] != null) {
					System.out.print(screen[y][x]);
				}
				else {
					System.out.print(" ");
				}
			}
			System.out.print("\n");	
		}
	}
}
