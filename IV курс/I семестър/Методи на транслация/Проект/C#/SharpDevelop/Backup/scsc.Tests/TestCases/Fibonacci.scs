using System;

class Program
{	
	int fib(int n) {
		int a;
		int b;
		int i;
		
		a = 0;
		b = 1;
		i = 0;
		
		while (i < n) {
			int temp;
			temp = a;
			a = b;
			b = temp + b;
			i++;
		}
		
		return a;
	}
	
	int main() // entry point
	{
		int i;
		int m;
		i = 0;
		
		while (i < 15) {
			System.Console.WriteLine(fib(i));
			i++;
		}
		
		return 0;
	}
}