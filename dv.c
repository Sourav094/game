/*###############################################
# Name : Nataraju A B
#        Assistant Professor,
#			Dept. of ECE, AIT, Bangalore
############################################### */



#include<stdio.h>

struct node
{
	int dist[20]; 
	int from[20]; 
}rt[10]; 

int main()
{
	int dist_mat[20][20]; 
	int n, i, j, k, count=0, src, dest; 

	printf("\nEnter the number of nodes : "); 
	scanf("%d", &n); 

	printf("\nEnter the cost/distance matrix :\n"); 
	for(i=0; i<n; i++) // from
	{
		for(j=0; j<n; j++) // to
		{
			scanf("%d", &dist_mat[i][j]); 
			dist_mat[i][i]=0; 
			rt[i].dist[j]=dist_mat[i][j]; 
			rt[i].from[j]=j; 
		}
	}

	/* 	Determine the Shortest router from each and every node to all 
		other nodes in the network	

		The following loop perform the merger of routing table with neighbours to 	
		form the complete routing table (route to all the nodes in the network)
	*/
	do
	{  
		count=0; 
		for(i=0; i<n; i++) // from
		{
			for(j=0; j<n; j++) // to 
			{
				for(k=0; k<n; k++) // via (or) next hop
				{	
					if(rt[i].dist[j]>dist_mat[i][k]+rt[k].dist[j])
					{
						rt[i].dist[j]=rt[i].dist[k]+rt[k].dist[j];
						rt[i].from[j]=k; 
						count++; 
					}
				}
			}
		}
	} while(count != 0); 

	for(i=0; i<n; i++)
	{
		printf("\nRouting table for router %d :\nDest\tNextHop\tDist\n", i+1); 
	for(j=0; j<n; j++)
		printf("%d\t%d\t%d\n", j+1, rt[i].from[j]+1, rt[i].dist[j]); 
	}

	printf("\nEnter source and destination : "); 
	scanf("%d%d", &src, &dest); 
	src--; 	
	dest--; 
	printf("Shortest path : \n Via router : %d\n Shortest distance : %d \n",  
		rt[src].from[dest]+1, rt[src].dist[dest]); 
	return 0; 
}

#if 0
	printf("\nInitial Routing table is.... \n"); 
	printf("Dest\tNextHop\tDist\n"); 
	
	for(i=0; i<n; i++)
	{
		for(j=0; j<n; j++)
			printf("%d\t", dist_mat[i][j]); 
		printf("\n"); 
	}
//	getch(); 
#endif
