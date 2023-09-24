#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

struct user{
	char seed[100];
	char source[100];
	int quality;
	int price;
	char id[100];
	struct user *next;
	struct user *prev;
}*head[20], *tail[20];

int coins = 10000;
int inv = 0;

int hashing(char id[100]){
	int len = strlen(id);
	int key = 0;
	for(int i = 0; i<len; i++){
		key += id[i];
	}
	return key%20;
}

void buy_seed() {
    printf("Your money: %d\n", coins);
    inv++;
    
    char seed_name[50];
    int validate = 0;
	do{
        printf("Input seed name [min 2 words]: ");
        scanf("%[^\n]", seed_name);
        getchar();
        int len = strlen(seed_name);
		for(int i = 0; i<len; i++){
			if(seed_name[i] == ' '){
				validate = 1;
			}	
		}
    }while (strlen(seed_name) < 3 || validate == 0);
    
    char source[10];
    do{
        printf("Input source [forest|field] (case insensitive): ");
        scanf("%[^\n]", source);
        getchar();
    }while(strcmpi(source, "forest") != 0 && strcmpi(source, "field") != 0);
    
    int quality;
    if(strcmpi(source, "forest") == 0){
    	quality = rand() % 51;
	}else{
		quality = rand() % 50;
		quality += 51;
	}
	int x = 122;
	int y = rand() % 30;
	int price = quality * (x+y) + 1000;
    
    int rand1 = rand() % 10;
    int rand2 = rand() % 10;
    int rand3 = rand() % 10;
    char id[100];
    if(strcmpi(source, "forest") == 0){
    	sprintf(id, "FO%d%d%d", rand1, rand2, rand3);
	}else{
    	sprintf(id, "FI%d%d%d", rand1, rand2, rand3);
	}
	
	if(coins >= price){
    	printf("Successfully bought %s\n", seed_name);
    	coins -= price;
		printf("Current coin: %d\n", coins);
		printf("Press enter to continue\n");
		getchar();
		
		int key = hashing(id);
		
		struct user *node = (user*)malloc(sizeof(user));
		node->next = node->prev = NULL;
		strcpy(node->id, id);
		strcpy(node->seed, seed_name);
		strcpy(node->source, source);
		node->price = price;
		node->quality = quality;
		if(head[key] == NULL){
			head[key] = tail[key] = node;
		}else{
			tail[key]->next = node;
			node->prev = tail[key];
			tail[key] = node;
		}
	}else{
		printf("You don't have enough money to make this transaction\n");
		printf("Press enter to continue\n");
		getchar();
	}
	

}

void view_inventory(){
	if(inv == 0){
		printf("Your inventory is empty, consider to buy some seed first.\n");
		printf("Press enter to continue\n");
		getchar();
	}else{
		char sources[100];
		printf("Input source [forest|field|all] (case insensitive):");
		scanf("%s", &sources);
		getchar();
//		printf("sources : %s", sources);
		if(strcmpi("forest", sources) == 0){
			for(int j = 0; j<20; j++){
				user *curr = head[j];
				while(curr != NULL){
					if(strcmpi(curr->source, "forest") == 0){
						printf("%s %s %s %d %d\n", curr->id, curr->seed, curr->source, curr->quality, curr->price);
					}
					curr = curr->next;
				}
			}
		}else if(strcmpi("field", sources) == 0){
			for(int j = 0; j<20; j++){
				user *curr = head[j];
				while(curr != NULL){
					if(strcmpi(curr->source, "field") == 0){
						printf("%s %s %s %d %d\n", curr->id, curr->seed, curr->source, curr->quality, curr->price);
					}
					curr = curr->next;
				}
			}
		}else if(strcmpi("all", sources) == 0){
			for(int j = 0; j<20; j++){
				user *curr = head[j];
				while(curr != NULL){
					printf("%s %s %s %d %d\n", curr->id, curr->seed, curr->source, curr->quality, curr->price);
					curr = curr->next;
				}
			}
		}
	}
}

void plant_harvest(){
	if(inv == 0){
		printf("Your inventory is empty, consider to buy some seed first.\n");
		printf("Press enter to continue\n");
		getchar();
	}else{
		for(int j = 0; j<20; j++){
			user *curr = head[j];
			while(curr != NULL){
				printf("%s %s %s %d %d\n", curr->id, curr->seed, curr->source, curr->quality, curr->price);
				curr = curr->next;
			}
		}
		
		char str[100];
		printf("Input seed ID to plant and harvest [case sensitive]: ");
		scanf("%s", str);
		getchar();
		
		int valid = 0, profit;
		for(int j = 0; j<20; j++){
			user *curr = head[j];
			while(curr != NULL){
				if(strcmp(curr->id, str) == 0){
					valid = 1;
					profit = curr->price + curr->quality * (rand()%30);
					coins += profit;
					
					if(head[j] == tail[j]){
						free(head[j]);
						head[j] = NULL;
					}else if(curr == head[j]){
						head[j] = head[j]->next;
						head[j]->prev = NULL;
						free(curr);
						curr = NULL;
					}else if(curr == tail[j]){
						tail[j] = tail[j]->prev;
						tail[j]->next = NULL;
						free(curr);
						curr = NULL;
					}else{
						curr->next->prev = curr->prev;
						curr->prev->next = curr->next;
						free(curr);
						curr = NULL;
					}
				}
				curr = curr->next;
			}
		}
		inv--;
		
		if(valid == 0){
			printf("Seeds with id %s could not be found in your inventory\nPress enter to continue...\n", str);
			getchar();
		}else{
			printf("Successfully planted and harvested %s\nProfit: %d\nCurrent coin: %d\nPress enter to continue...\n", str, profit, coins);
			getchar();
		}
	}
}

int main(){
	int inp;
    srand(time(NULL));
	do{
		printf("Hayday\n");
		printf("1. Buy seed plant\n2. View Inventory\n3. Plant and harvest\n4. Exit\n>> ");
		scanf("%d", &inp);
		getchar();
		
		switch(inp){
			case 1:
				buy_seed();
				break;
			case 2:
				view_inventory();
				break;
			case 3:
				plant_harvest();
				break;
		}
		
	}while(inp != 4);
	
	return 0;
}
