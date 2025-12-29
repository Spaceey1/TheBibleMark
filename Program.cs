const ulong fnvBasis = 14695981039346656037;
const ulong fnvPrime = 1099511628211;
using StreamReader reader = new("bible.txt");
string text = reader.ReadToEnd();
DateTime start = DateTime.Now;
ulong result = fnvBasis;
foreach(char character in text){ //FNV-1a
	result *= fnvPrime;
	result ^= (ulong)character;
}
DateTime end = DateTime.Now;
if (result != 10133926911463709249){ //yes i hardcoded it
	Console.WriteLine("Benchmark failed!");
	return 1;
}
int timeMicroseconds = (end - start).Milliseconds;
Console.WriteLine($"Biblemark took {timeMicroseconds}ms\nYour final score is: {(1f/(float)timeMicroseconds)*1000000}");
return 0;
