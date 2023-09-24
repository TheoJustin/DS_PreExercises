#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <ctype.h>
#include <time.h>

char name[100][100];
char pw[100][100];
int tokens[100];
int account;

struct user{
    char name[100];
    char pw[100];
    int tokens;
    struct user* next;
    struct user* prev;
}*head, *tail, *user_acc;

void main_menu(){
	
}

void login_miner(){
	char str_pw[100];
	char str_name[100];
	printf("Login\n");
	printf("Enter Username [0 to go Back] >> ");
	scanf("%[^\n]", str_name);
	getchar();
	printf("Enter Password [0 to go Back] >> ");
	scanf("%[^\n]", str_pw);
	getchar();
	
	FILE* fp;
    fp = fopen("../database/accounts.txt", "r");
    int acc = 0, valid = 0;
    while(!feof(fp)){
    	struct user* new_user = (struct user*)malloc(sizeof(struct user));
        fscanf(fp, "%[^#]#%[^#]#%d\n", &name[acc], &pw[acc], &tokens[acc]);
	    strcpy(new_user->name, name[acc]);
	    strcpy(new_user->pw, pw[acc]);
	    new_user->tokens = tokens[acc];
	    new_user->next = NULL;
	    new_user->prev = NULL;
	
	    if(head == NULL){
	        head = new_user;
	        tail = new_user;
	    }else{
	        tail->next = new_user;
	        new_user->prev = tail;
	        tail = new_user;
	    }
        if(strcmp(name[acc], str_name) == 0 && strcmp(pw[acc], str_pw) == 0){
        	valid = 1;
			user_acc = new_user;
		}
        acc++;
    }
    fclose(fp);
    if(valid == 0){
    	printf("Username Not Found! Press Enter to Continue");
    	getchar();
	}else{
		main_menu();
	}
    
}

int main(){
	int inp;
	printf("Blue Miner\n");
	do{
		printf("1. Log In\n2. Exit\n>> ");
		scanf("%d",&inp);
		getchar();
		switch(inp){
			case 1:
				login_miner();
				break;
		}
	}while(inp!=2);
	return 0;
}
