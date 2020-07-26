import java.util.Scanner;
public class Test {
		
	public static  int lcsLength(char []x,char []y,int [][]b)
	{
		int m=x.length;
		int n=y.length;
		int [][]c=new int[m+1][n+1];
		for(int i=0;i<m;i++)	
			c[i][0]=0;
		for(int i=0;i<n;i++)
			c[0][i]=0;
		for(int i=0;i<m;i++)
			for(int j=0;j<n;j++) {
				if(x[i]==y[j]) {
					c[i][j]=c[i-1][j-1]+1;
					b[i][j]=1;
				}
				else if(c[i-1][j]>=c[i][j-1])
				{
					c[i][j]=c[i-1][j];
					b[i][j]=2;
				}
				else {
					c[i][j]=c[i][j-1];
					b[i][j]=3;
				}
			}
		return c[m][n]+1;
	}
	
	public static void main(String[] args) {
		int [][]b =new int [100][100];
		String x,y;
		
		char []a = {'a','b','c'};
		System.out.println(String.valueOf(a));
		while(true) {
		Scanner sc = new Scanner(System.in);
		System.out.print("input string x: ");
		x=sc.nextLine();
		System.out.print("input string y: ");
		y=sc.nextLine();
		int res=lcsLength(x.toCharArray(), y.toCharArray(), b);
		System.out.println(res);
		}
	}
}
