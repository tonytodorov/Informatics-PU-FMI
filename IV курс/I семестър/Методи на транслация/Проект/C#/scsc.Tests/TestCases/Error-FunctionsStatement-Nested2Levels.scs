using System;

class Program
{	
	int func1(int param1, int param2) {
		return param1 + param2;
	}
	
	int func2(int param1) {
		int x;
		x = func1(2,3);
		return x + param1;
	}
	
	int main() // entry point
	{
		int x;
		x = func2(); //expectederror "Броя на актуалните параметри не е равен на броя на формалните параметри"
		
		System.Console.Write(x);
		return 0;
	}
}