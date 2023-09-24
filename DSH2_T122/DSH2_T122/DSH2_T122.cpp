#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <conio.h>
#include <time.h>


char hash_pw[100];
char hash_pw_login[100];
char email[100];
char pw[100];
char user_name[100][100];
char user_pw[100][100];
char user_cred[100][100];
int acc = -1;

struct manga {
    char title[100];
    char author[100];
    char genre[100];
    double rating;
    int chapter;
    int price;
    struct manga* prev;
    struct manga* next;
} *head = NULL, *tail = NULL;

struct transaction {
    char name[100];
    char password[100];
    char credentials[100];
    char title[100];
    int chapter;
    int price;
    char date[20];
    char status[20];
    struct transaction *prev;
    struct transaction *next;
} *head2 = NULL, *tail2 = NULL;


void manga_list(){
    printf("%-3s%-30s%-30s%-20s%-10s%-10s%-10s\n", "No", "Title", "Author", "Genre", "Rating", "Chapter", "Price");
    printf("============================================================================================================\n");
    struct manga* curr = head;
    int i = 1;
    while(curr != NULL){
        printf("%-3d%-30s%-30s%-20s%-10.1lf%-10d%-10d\n", i, curr->title, curr->author, curr->genre, curr->rating, curr->chapter, curr->price);
        curr = curr->next;
        i++;
    }
    printf("============================================================================================================\n");
    printf("Press enter to continue...");
    getchar();
}

void order_manga(){
	printf("%-3s%-30s%-30s%-20s%-10s%-10s%-10s\n", "No", "Title", "Author", "Genre", "Rating", "Chapter", "Price");
    printf("============================================================================================================\n");
    struct manga* curr = head;
    int i = 1;
    while(curr != NULL){
        printf("%-3d%-30s%-30s%-20s%-10.1lf%-10d%-10d\n", i, curr->title, curr->author, curr->genre, curr->rating, curr->chapter, curr->price);
        curr = curr->next;
        i++;
    }
    printf("============================================================================================================\n");
    
    char title[100];
    printf("Input manga title (0 to cancel):");
    scanf("%[^\n]", title);
    getchar();
    
	curr = head;
	while(curr != NULL && strcmp(curr->title, title) != 0){
		curr = curr->next;
	}
	
	if(strcmp(curr->title, title) == 0){
    	int chapter;
    	printf("Input manga chapter (%d - %d):", 1, curr->chapter);
    	scanf("%d", &chapter);
    	getchar();
    	
    	time_t t = time(NULL);
	    struct tm *tm = localtime(&t);
	    char date_string[11];
	    strftime(date_string, sizeof(date_string), "%Y-%m-%d", tm);
	    
	    int price;
	    printf("Input manga price (%d):", curr->price);
    	scanf("%d", &price);
    	getchar();

		FILE *fp = fopen("transaction.txt", "a");
    	fprintf(fp, "%s#%s#%s#%s#%d#%d#%s#%s\n", user_name[acc], user_pw[acc], user_cred[acc], title, chapter, price, date_string, "ongoing");
	    fclose(fp);
		
		printf("Order succesfully made\nPress enter to continue...\n");
		getchar();
		
	}else{
		printf("manga not found\n");
		getchar();
	}
}

void shop_menu(){
	int inp;
	
	char title[100], author[100], genre[100];
    double rating;
    int chapter, price;
	
	FILE* fp = fopen("manga.txt", "r");
	while(!feof(fp)){
        fscanf(fp, "%[^#]#%[^#]#%lf#%[^#]#%d#%d\n", &title, &author, &rating, &genre, &chapter, &price);
        struct manga* new_manga = (struct manga*) malloc(sizeof(struct manga));
	    strcpy(new_manga->title, title);
	    strcpy(new_manga->author, author);
	    strcpy(new_manga->genre, genre);
	    new_manga->rating = rating;
	    new_manga->chapter = chapter;
	    new_manga->price = price;
	    new_manga->next = NULL;
	    
	    if(head == NULL){
	        head = tail = new_manga;
	        new_manga->prev = NULL;
	    }else{
	        tail->next = new_manga;
	        new_manga->prev = tail;
	        tail = new_manga;
	    }
    }
    fclose(fp);
	do{
		printf("MangaShop 221\n=============\n1. Manga list\n2. Order manga\n3. Logout\n>> ");
		scanf("%d", &inp);
		getchar();
		
		switch(inp){
			case 1:
				manga_list();
				break;
			case 2:
				order_manga();
				break;
		}
	}while(inp != 3);
}


void update_manga(){
    printf("%-3s%-30s%-30s%-20s%-10s%-10s%-10s\n", "No", "Title", "Author", "Genre", "Rating", "Chapter", "Price");
    printf("============================================================================================================\n");
    struct manga* curr = head;
    int i = 1;
    while(curr != NULL){
        printf("%-3d%-30s%-30s%-20s%-10.1lf%-10d%-10d\n", i, curr->title, curr->author, curr->genre, curr->rating, curr->chapter, curr->price);
        curr = curr->next;
        i++;
    }
    printf("============================================================================================================\n");
    
    int idx;
    printf("Enter manga index (%d - %d, 0 to return): ", 1, i-1);
    scanf("%d", &idx);
    getchar();
    
    curr = head;
    i = 1;
    while(curr != NULL && idx != i){
        curr = curr->next;
        i++;
    }
    
    char title[100], author[100], genre[100];
    double rating;
    int chapter, price;
	
    do{
        printf("Enter manga title (10 - 50 characters, 0 to cancel): ");
        scanf("%[^\n]", title);
        getchar();
    }while(strlen(title) < 10 || strlen(title) > 50);

    do{
        printf("Enter manga author (5 - 50 characters, 0 to cancel): ");
        scanf("%[^\n]", author);
        getchar();
    }while(strlen(author) < 5 || strlen(author) > 50);

    do{
        printf("Enter manga rating (0.1 - 5.0, 0 to cancel): ");
        scanf("%lf", &rating);
        getchar();
    }while(rating < 0.1 || rating > 5.0);

    do{
        printf("Enter manga genre (action, horror, romance, shounen, seinen [case sensitive], 0 to cancel): ");
        scanf("%[^\n]", genre);
        getchar();
    }while(strcmp(genre, "action") != 0 && strcmp(genre, "horror") != 0 && strcmp(genre, "romance") != 0 && strcmp(genre, "shounen") != 0 && strcmp(genre, "seinen") != 0);

    do{
        printf("Enter manga chapter (min 1, 0 to cancel): ");
        scanf("%d", &chapter);
        getchar();
    }while(chapter < 1);

    do{
        printf("Enter manga price (min 10000 max 1000000, 0 to cancel): ");
        scanf("%d", &price);
        getchar();
    }while(price < 10000 || price > 1000000);
    
    strcpy(curr->title, title);
    strcpy(curr->author, author);
    strcpy(curr->genre, genre);
    curr->rating = rating;
    curr->chapter = chapter;
    curr->price = price;
    
}


void add_manga(){
    char title[100], author[100], genre[100];
    double rating;
    int chapter, price;
	
    do{
        printf("Enter manga title (10 - 50 characters, 0 to cancel): ");
        scanf("%[^\n]", title);
        getchar();
    }while(strlen(title) < 10 || strlen(title) > 50);

    do{
        printf("Enter manga author (5 - 50 characters, 0 to cancel): ");
        scanf("%[^\n]", author);
        getchar();
    }while(strlen(author) < 5 || strlen(author) > 50);

    do{
        printf("Enter manga rating (0.1 - 5.0, 0 to cancel): ");
        scanf("%lf", &rating);
        getchar();
    }while(rating < 0.1 || rating > 5.0);

    do{
        printf("Enter manga genre (action, horror, romance, shounen, seinen [case sensitive], 0 to cancel): ");
        scanf("%[^\n]", genre);
        getchar();
    }while(strcmp(genre, "action") != 0 && strcmp(genre, "horror") != 0 && strcmp(genre, "romance") != 0 && strcmp(genre, "shounen") != 0 && strcmp(genre, "seinen") != 0);

    do{
        printf("Enter manga chapter (min 1, 0 to cancel): ");
        scanf("%d", &chapter);
        getchar();
    }while(chapter < 1);

    do{
        printf("Enter manga price (min 10000 max 1000000, 0 to cancel): ");
        scanf("%d", &price);
        getchar();
    }while(price < 10000 || price > 1000000);
    
    FILE* fp = fopen("manga.txt", "a");
    fprintf(fp, "%s#%s#%lf#%s#%d#%d\n", title, author, rating, genre, chapter, price);
    fclose(fp);
    
    struct manga* new_manga = (struct manga*) malloc(sizeof(struct manga));
    strcpy(new_manga->title, title);
    strcpy(new_manga->author, author);
    strcpy(new_manga->genre, genre);
    new_manga->rating = rating;
    new_manga->chapter = chapter;
    new_manga->price = price;
    new_manga->next = NULL;
    
    if(head == NULL){
        head = tail = new_manga;
        new_manga->prev = NULL;
    }else{
        tail->next = new_manga;
        new_manga->prev = tail;
        tail = new_manga;
    }
    
    printf("Successfully added a new manga.\n");
    printf("Press enter to continue...");
    getchar();
}

void delete_manga(){
	printf("%-3s%-30s%-30s%-20s%-10s%-10s%-10s\n", "No", "Title", "Author", "Genre", "Rating", "Chapter", "Price");
    printf("============================================================================================================\n");
    struct manga* curr = head;
    int i = 1;
    while(curr != NULL){
        printf("%-3d%-30s%-30s%-20s%-10.1lf%-10d%-10d\n", i, curr->title, curr->author, curr->genre, curr->rating, curr->chapter, curr->price);
        curr = curr->next;
        i++;
    }
    printf("============================================================================================================\n");
    
	char str_title[100];
	printf("Enter manga title (0 to cancel): ");
	scanf("%[^\n]", str_title);
	getchar();
	
	curr = head;
	while(curr!=NULL && strcmp(curr->title, str_title) != 0){
		curr = curr->next;
	}
	
	if(strcmp(curr->title, str_title)==0){
		if(head == tail && curr == head){
			free(head);
			head = NULL;
		}else if(curr == head){
			head = head->next;
			curr->next = NULL;
			free(curr);
		}else if(curr == tail){
			tail = tail->prev;
			curr->prev = NULL;
			free(curr);
		}else{
			curr->prev->next = curr->next;
			curr->next->prev = curr->prev;
			free(curr);
		}
		printf("Manga deleted successfuly\nPress enter to continue...\n");
		getchar();
	}else{
		printf("Manga not found\n");
		getchar();		
	}
}

void view_order(){
    struct transaction* curr = head2;
    int i = 1;
    
    printf("%-3s%-20s%-20s%-20s%-10s%-10s%-20s%-10s\n", "No", "Name", "Title", "Chapter", "Price", "Date", "Status", "Credentials");
    printf("========================================================================================================================\n");
    
    while (curr != NULL) {
        printf("%d %s %s %d %d %s %s %s\n", i, curr->name, curr->title, curr->chapter, curr->price, curr->date, curr->status, curr->credentials);
        curr = curr->next;
        i++;
    }

    printf("========================================================================================================================\n");
    printf("Press enter to continue...");
    getchar();
}

void process_order(){
	struct transaction* curr = head2;
    int i = 1;
    
    printf("%-3s%-20s%-20s%-20s%-10s%-10s%-20s%-10s\n", "No", "Name", "Title", "Chapter", "Price", "Date", "Status", "Credentials");
    printf("========================================================================================================================\n");
    
    while (curr != NULL) {
        printf("%d %s %s %d %d %s %s %s\n", i, curr->name, curr->title, curr->chapter, curr->price, curr->date, curr->status, curr->credentials);
        curr = curr->next;
        i++;
    }

    printf("========================================================================================================================\n");
    
	char yn;
	printf("Are you sure you want to process the order for theo@yahoo.com? (Y to proceed || N to cancel): ");
    scanf("%c", &yn);
    getchar();
    
    if(yn == 'Y'){
    	if(head2 == tail2){
    		free(head2);
    		head2 = NULL;
		}else{
    		curr = head2;
    		head2 = head2->next;
    		free(curr);
    		head2->prev = NULL;
		}
	}
}


void admin_menu(){
	int inp;
	
	char title[100], author[100], genre[100];
    double rating;
    int chapter, price;
	
	FILE* fp = fopen("manga.txt", "r");
	while(!feof(fp)){
        fscanf(fp, "%[^#]#%[^#]#%lf#%[^#]#%d#%d\n", &title, &author, &rating, &genre, &chapter, &price);
        struct manga* new_manga = (struct manga*) malloc(sizeof(struct manga));
	    strcpy(new_manga->title, title);
	    strcpy(new_manga->author, author);
	    strcpy(new_manga->genre, genre);
	    new_manga->rating = rating;
	    new_manga->chapter = chapter;
	    new_manga->price = price;
	    new_manga->next = new_manga->prev = NULL;
	    
	    if(head == NULL){
	        head = tail = new_manga;
	    }else{
	        tail->next = new_manga;
	        new_manga->prev = tail;
	        tail = new_manga;
	    }
    }
    fclose(fp);
    
    char name[100], pass[100], cred[100], date[100], status[100];
    fp = fopen("transaction.txt", "r");
	while(!feof(fp)){
    	fscanf(fp, "%[^#]#%[^#]#%[^#]#%[^#]#%d#%d#%[^#]#%[^\n]\n", &name, &pass, &cred, &title, &chapter, &price, &date, &status);
	    struct transaction *new_node = (struct transaction *)malloc(sizeof(struct transaction));
		strcpy(new_node->name, name);
		strcpy(new_node->password, pass);
		strcpy(new_node->credentials, cred);
		strcpy(new_node->title, title);
		new_node->chapter = chapter;
		new_node->price = price;
		strcpy(new_node->date, date);
		strcpy(new_node->status, status);
		new_node->next = new_node->prev = NULL;
		
		if(head2 == NULL){
	        head2 = tail2 = new_node;
	    }else{
	        tail2->next = new_node;
	        new_node->prev = tail2;
	        tail2 = new_node;
	    }
    }
    fclose(fp);
	
	do{
		printf("MangaShop 221\n=============\n1. Add Manga\n2. Update manga\n3. Delete manga\n4. Manga list\n5. Process order\n6. View order\n7. Logout\n>> ");
		scanf("%d", &inp);
		getchar();
		
		switch(inp){
			case 1:
				add_manga();
				break;
			case 2:
				update_manga();
				break;
			case 3:
				delete_manga();
				break;
			case 4:
				manga_list();
				break;
			case 5:
				process_order();
				break;
			case 6:
				view_order();
				break;
		}
	}while(inp != 7);
	
	
	fp = fopen("manga.txt", "w");
	manga *curr = head;
	while(curr != NULL){
    	fprintf(fp, "%s#%s#%lf#%s#%d#%d\n", curr->title, curr->author, curr->rating, curr->genre, curr->chapter, curr->price);
    	curr = curr->next;
	}
    fclose(fp);
	
}


void hashing_pw(char pw[100]){
	int len = strlen(pw);
	for(int i = 0; i<len; i++){
		pw[i] = (pw[i] + 10)/2;
	}
	
	strcpy(hash_pw, pw);
}


void login_menu(){
	acc = -1;
	FILE* fp = fopen("user.txt", "r");

    char str[100];
    printf("Enter your email (enter 0 to return): ");
    scanf("%[^\n]", str);
    getchar();
    
	char str2[100];
    printf("Enter your password (enter 0 to return):");
    scanf("%[^\n]", str2);
	getchar();
	
	hashing_pw(str2);
	strcpy(hash_pw_login, hash_pw);
	
	int s = 0;
//	printf("%s %s\n", hash_pw_login, str);
    while(!feof(fp)){
        fscanf(fp, "%[^#]#%[^#]#%[^\n]\n", &user_name[s], &user_pw[s], &user_cred[s]);
//		printf("%s %s %s\n", user_name[s], user_pw[s], user_cred[s]);
		if(strcmp(user_name[s], str) == 0 && strcmp(hash_pw_login, user_pw[s]) == 0){
			acc = s;
//			printf("\n%d\n", acc);
		}
        s++;
    }
    fclose(fp);
    
    if(acc != -1){
    	if(acc == 0){
    		admin_menu();
		}else{
    		shop_menu();
		}
	}else{
		printf("Wrong credentials\nPress enter to continue...\n");
		getchar();
	}
	
}

void register_menu(){
    int valid = 0;

    int len;
    do{
        printf("Enter your email [email format || press 0 to cancel]: ");
        scanf("%[^\n]", email);
        getchar();
        if(strcmp(email, "0") == 0){
            return;
        }

        char* at = strchr(email, '@');
        char* dotcom = strstr(email, ".com");
        if(at != NULL && dotcom != NULL){
            valid = 1;
        }else{
            printf("Invalid email format. Please try again.\n");
        }
    }while(!valid);

    valid = 0;
    do{
        printf("Enter your password [8-20 characters & alphanumeric || press 0 to cancel]: ");
        int i = 0;
        char c;
        while(i < 20 && (c = getch()) != '\r'){
            if(c == '\b' && i > 0){
                i--;
                printf("\b \b");
            }else if(isalnum(c) && i < 20){
                pw[i] = c;
                i++;
                printf("*");
            }
        }
        pw[i] = '\0';
        printf("\n");
        len = strlen(pw);
        if(len >= 8 && len <= 20){
            valid = 1;
        }
    }while(!valid);
    
	hashing_pw(pw);
	FILE* fp = fopen("user.txt", "a");
    fprintf(fp, "%s#%s#%s\n", email, hash_pw, "customer");
    fclose(fp);
}



int main(){
	int inp;
	do{
		printf("MangaShop 221\n===========\n1. Login\n2. Register\n3. Exit\n>> ");
		scanf("%d", &inp);
		getchar();
		
		switch(inp){
			case 1:
				login_menu();
				break;
			case 2:
				register_menu();
				break;
		}
	}while(inp != 3);
	
	
	return 0;
}
