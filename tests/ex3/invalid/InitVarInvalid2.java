class Main {
	public static void main(String[] a) {
		System.out.println(3);
	}
}

class Simple {
	int fun(boolean x) {
		int x;
		boolean a;
		boolean b;
		int[] arr;
		Simple simple;
		Simple simple2;
		simple2 = new Simple();
		if (2 < 3) {
			{
				x = 5;

				while (x < 7)					{
						simple = new Simple();

						if (x < 3) {
							a = false;
						} else {
							a = true;
						}

						b = a && true;

					}


				a = true;

				while (x < 7)					{
						simple = new Simple();

						a = false;

						if (x < 3) {
							b = a && true;
						} else {
							a = true;
						}

						b = a && true;

					}


				if (x < 3) {
					{
						simple = new Simple();

						b = a && true;

					}
				} else {
					{
						simple = new Simple();

						a = true;

					}
				}

			}
		} else {
			{
				a = true;

				if (a) {
					{
						arr = new int[5];

						simple = new Simple();

					}
				} else {
					{
						arr = new int[7];

					}
				}

				if (a) {
					{
						arr = new int[7];

						simple = new Simple();

					}
				} else {
					{
						arr = new int[7];

						simple = new Simple();

					}
				}

				simple2 = simple;

				x = 5;

				x = arr[x];

			}
		}
		a = true;
		arr = new int[7];
		arr[x] = simple2.fun(a);
		return x;
	}

}
