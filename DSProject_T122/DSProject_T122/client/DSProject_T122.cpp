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
//char name_acc[100];

struct user{
    char name[100];
    char pw[100];
    int tokens;
    struct user* next;
    struct user* prev;
}*head, *tail, *user_acc;

struct transaction{
    char sender[100];
    char receiver[100];
    int amount;
    int hash;
    char date[100];    
    struct transaction* next;
    struct transaction* prev;
}*head2, *tail2;


long long deposit_hashing(char recipient[], char sender[], char formattedTime[]){
    int len1 = strlen(formattedTime);
    int len2 = strlen(recipient);
    int len3 = strlen(sender);
    
    long long key = 0;
    
    for(int i = 0; i<len1; i++){
    	key += (formattedTime[i] * (i+1));
	}
	for(int i = 0; i<len2; i++){
    	key += (recipient[i] * (i+1));
	}
	for(int i = 0; i<len3; i++){
    	key += (sender[i] * (i+1));
	}
	return key;
}

void withdraw_menu(){
	int withdraw;
	printf("Enter Withdraw Amount [0 to cancel]: ");
	scanf("%d", &withdraw);
	getchar();

	if(withdraw != 0){
		if(withdraw > user_acc->tokens){
			printf("You don't Have Enough Money\n");
		}else{
			time_t currentTime;
		    time(&currentTime);
		    struct tm* timeInfo = localtime(&currentTime);
		    char formattedTime[50];
		    strftime(formattedTime, sizeof(formattedTime), "%a %b %d %H:%M:%S %Y", timeInfo);
			
			char sender[100] = {};
			strcpy(sender, user_acc->name);
			char recipient[100] = "WD";
			long long hash = deposit_hashing(recipient, sender, formattedTime);
			
			char str[100];
			sprintf(str, "%s#%s#%d#%lld#%s", sender, recipient, withdraw, hash, formattedTime);
			
			FILE* fp = fopen("../database/transactions.txt", "a");
		    fprintf(fp, "%s\n", str);
		    fclose(fp);
		    
		    user_acc->tokens -= withdraw;
		    
		    printf("Transaction Created with Hash: %lld\n\nBlue Token(s) Added to Transactions!\n", hash);
		    getchar();
		}
	}
}

void deposit_menu(){
	int deposit;
	printf("Enter Deposit Amount [0 to Cancel]: ");
	scanf("%d", &deposit);
	getchar();
	
	time_t currentTime;
    time(&currentTime);
    struct tm* timeInfo = localtime(&currentTime);
    char formattedTime[50];
    strftime(formattedTime, sizeof(formattedTime), "%a %b %d %H:%M:%S %Y", timeInfo);
	
	char sender[100] = "DP";
	char recipient[100] = {};
	strcpy(recipient, user_acc->name);
	long long hash = deposit_hashing(recipient, sender, formattedTime);
	
	char str[100];
	sprintf(str, "%s#%s#%d#%lld#%s", sender, recipient, deposit, hash, formattedTime);
	
	FILE* fp = fopen("../database/transactions.txt", "a");
    fprintf(fp, "%s\n", str);
    fclose(fp);
    
    printf("Transaction Created with Hash: %lld\n\nBlue Token(s) Added to Transactions!\n", hash);
    getchar();
}


void funds_menu(){
	int inp;
	do{
		printf("Blue Tokens: %d\n1. Deposit\n2. Withdraw\n3. Back\n>> ", user_acc->tokens);
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				deposit_menu();
				break;
			case 2:
				withdraw_menu();
				break;
		}
	}while(inp != 3);
}

void ongoing_transactions(){
	FILE* fp = fopen("../database/transactions.txt", "r");
	
	while(!feof(fp)){
		char sender[100], receiver[100], date[100];
		int amount, hash;
		struct transaction *curr = (transaction*)malloc(sizeof(transaction));
    	fscanf(fp, "%[^#]#%[^#]#%d#%d#%[^\n]\n", &sender, &receiver, &amount, &hash, &date);
    	strcpy(curr->sender, sender);
    	strcpy(curr->receiver, receiver);
    	strcpy(curr->date, date);
    	curr->hash = hash;
    	curr->amount = amount;
    	curr->next = curr->prev = NULL;	
    	if(head2 == NULL){
    		head2 = tail2 = curr;
		}else{
			tail2->next = curr;
			curr->prev = tail2;
			tail2 = curr;
		}
		printf("%s %s %d %d %s\n", curr->sender, curr->receiver, curr->amount, curr->hash, curr->date);
	}
    fclose(fp);
}

void view_transactions(){
	int inp;
	do{
		printf("1. Ongoing Transactions\n2. Finalized Transactions\n3. Back\n>>");
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				ongoing_transactions();
				break;
			case 2:
//				finalized_transactions();
				break;
		}
	}while(inp != 3);
}

void enter_sendmoney(){
	user *curr = head;
	int i = 1;
	while(curr != NULL){
		printf("%d. %s\n", i, curr->name);
		curr = curr->next;
		i++;
	}
	
	char uname[100];
	printf("Enter Username [0 to Cancel]: ");
	scanf("%[^\n]", uname);
	getchar();
	
	curr = head;
	while(curr != NULL){
		if(strcmp(curr->name, uname) == 0){
			break;
		}else{
			curr = curr->next;
		}
	}
	
	if(strcmp(curr->name, uname) == 0){
		int tokens;
		printf("Your Blue Tokens: %d\nEnter Amount to Send [0 to Cancel]:", curr->tokens);
		scanf("%d", &tokens);
		getchar();
		
		time_t currentTime;
	    time(&currentTime);
	    struct tm* timeInfo = localtime(&currentTime);
	    char formattedTime[50];
	    strftime(formattedTime, sizeof(formattedTime), "%a %b %d %H:%M:%S %Y", timeInfo);
		
		char sender[100] = {};
		strcpy(sender, user_acc->name);
		char recipient[100] = {};
		strcpy(recipient, uname);
		long long hash = deposit_hashing(recipient, sender, formattedTime);
		
		char str[100];
		sprintf(str, "%s#%s#%d#%lld#%s", sender, recipient, tokens, hash, formattedTime);
		
		FILE* fp = fopen("../database/transactions.txt", "a");
	    fprintf(fp, "%s\n", str);
	    fclose(fp);
	    
	    printf("Transaction Created with Hash: %lld\n\nBlue Token(s) Added to Transactions!\n", hash);
	    getchar();
	}else{
		printf("Username Not Found! Press Enter to Try Again\n");
		getchar();
	}
}

void send_money(){
	int inp;
	do{
		user *curr = head;
		int i = 1;
		while(curr != NULL){
			printf("%d. %s\n", i, curr->name);
			curr = curr->next;
			i++;
		}
		printf("1. Prev\n2. Next\n3. Enter Username\n4. Back\n>>");
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				//prev_sendmoney();
				break;
			case 2:
				//next_sendmoney();
				break;
			case 3:
				enter_sendmoney();
				break;
		}
	}while(inp != 4);
}

void transactions_menu(){
	int inp;
	do{
		printf("1. View Transactions\n2. Send Money\n3. Back\n>>", user_acc->tokens);
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				view_transactions();
				break;
			case 2:
				send_money();
				break;
		}
	}while(inp != 3);
}

void change_password(){
	char str[100];
	char str2[100];
	char str3[100];
	
	printf("Enter your Old Password [0 to Cancel]:");
	scanf("%s", &str);
	getchar();
	
	if(strcmp(str, user_acc->pw) == 0){
		printf("Enter your New Password [0 to Cancel]: ");
		scanf("%s", &str2);
		getchar();
		
		printf("Repeat the New Password [0 to Cancel]:");
		scanf("%s", &str3);
		getchar();
		
		if(strcmp(str2, str3) != 0){
			printf("Passwords Doesn't Match! Press Enter to Continue");
		}else{
			printf("Password Updated!");
			strcpy(user_acc->pw, str);
		}
	}else{
		printf("Incorrect Password! Press Enter to Continue");
		getchar();
	}
}

void account_menu(){
	int inp;
	do{
		printf("1. Change Password\n2. Back\n>>", user_acc->tokens);
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				change_password();
				break;
		}
	}while(inp != 2);
}

void main_menu(char str[100]){
	int inp;
	do{
		printf("Welcome %s\n\n", str);
		printf("1. Funds\n2. Transactions\n3. My Account\n4. Log Out\n>> ");
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				funds_menu();
				break;
			case 2:
				transactions_menu();
				break;
			case 3:
				account_menu();
				break;
		}
	}while(inp != 4);
}

void register_client(){
	printf("Register\n");
	char username[100];
	do{
		printf("Enter Username [0 to Cancel] >> ");
		scanf("%[^\n]", username);
		getchar();
		if(strlen(username)<8 || strlen(username)>25){
			printf("Username's Length Must be Between 8 and 25 Characters Long! Press Enter to Try Again\n\n");
			getchar();
		}
	} while(strlen(username)<8 || strlen(username)>25);
	
	char password[100];
	do{
		printf("Enter Password [0 to Cancel] >> ");
		fflush(stdout);
		
		char c;
		int i = 0;
		while ((c = getch()) != '\r') {
			if (c == '\b') {
				if (i > 0) {
					password[--i] = '\0';
					printf("\b \b");
				}
			} else {
				password[i++] = c;
				printf("*");
			}
		}
		password[i] = '\0';
		printf("\n");
		
		if(strcmp(password, "0") == 0 || strlen(password)<10){
			printf("Password Must be At Least 10 Characters Long, Press Enter to Try Again\n\n");
			getchar();
		}
	} while (strcmp(password, "0") == 0 || strlen(password)<10);
	
	printf("\nRegistration successful! Your username is '%s' and your password is '%s'\n", username, password);
	
	FILE* fp = fopen("../database/accounts.txt", "a");
    fprintf(fp, "%s#%s#%d\n", username, password, 0);
    fclose(fp);
}


void login_client(){
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
//        printf("%s %s %d\n", name[acc], pw[acc], tokens[acc]);
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
		main_menu(user_acc->name);
	}
    
}

int main(){
	int inp;
	printf("Blockchain\n");
	do{
		printf("1. Log In\n2. Register\n3. Exit\n>> ");
		scanf("%d",&inp);
		getchar();
		switch(inp){
			case 1:
				login_client();
				break;
			case 2:
				register_client();
				break;
		}
	}while(inp!=3);
	return 0;
}

