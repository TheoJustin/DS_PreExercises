#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct task{
	char taskname[100];
	int hour;
	int minute;
};

struct todo{
	char todoname[100];
	struct task tasks[100];
	int manytasks;
	todo *next;
}*head;

void add_todo(){
	char str[100];
	char str1[100] = "Learn";
	int inp = -1;
	do{
		printf("Input New Todo [Name More than 3 Characters]: ");
		scanf("%[^\n]", str);
		getchar();
		inp = strncmp(str, str1, 5);
	}while(inp != 0);
	
	struct todo *node = (todo *)malloc(sizeof(struct todo));
	node->next = NULL;
	strcpy(node->todoname, str);
	node->manytasks = 0;
	
	if(head == NULL){
		head = node;
	}else{
		node->next = head;
		head = node;
	}
}

void add_task(struct todo *curr){
	char str[100];
	do{
		printf("Input New Task List [Name More than 3 Characters]: ");
		scanf("%[^\n]", str);
		getchar();
	}while(strlen(str) <= 3);
	
	int hours;
	do{
		printf("Input New Hour(s) [0..23]: ");
		scanf("%d", &hours);
		getchar();
	}while(hours<0 || hours>23);
	
	int minutes;
	do{
		printf("Input New Minute(s) [0..59]: ");
		scanf("%d", &minutes);
		getchar();
	}while(minutes<0 || minutes>59);
	
	curr->tasks[curr->manytasks].hour = hours;
	curr->tasks[curr->manytasks].minute = minutes;
	strcpy(curr->tasks[curr->manytasks].taskname, str);
	
	curr->manytasks = curr->manytasks + 1;
	
	printf("Task List Successfully Created!\nEnter to Continue...\n");
	getchar();
}

void update_task(struct todo *curr){
	if(curr->manytasks != 0){
		printf("Select Index to Update [ %d..%d ]: ", 1, curr->manytasks);
		int options;
		do{
			scanf("%d", &options);
			getchar();
		}while(options<1 || options>curr->manytasks);
	
		char str[100];
		do{
			printf("Input New Task List [Name More than 3 Characters]: ");
			scanf("%[^\n]", str);
			getchar();
		}while(strlen(str) <= 3);
		
		int hours;
		do{
			printf("Input New Hour(s) [0..23]: ");
			scanf("%d", &hours);
			getchar();
		}while(hours<0 || hours>23);
		
		int minutes;
		do{
			printf("Input New Minute(s) [0..59]: ");
			scanf("%d", &minutes);
			getchar();
		}while(minutes<0 || minutes>59);
		
		curr->tasks[options-1].hour = hours;
		curr->tasks[options-1].minute = minutes;
		strcpy(curr->tasks[options-1].taskname, str);
	}
}

void done_task(struct todo *curr){
	if(curr->manytasks != 0){
		printf("Select Index to Delete [ %d..%d ]:", 1, curr->manytasks);
		int idx;
		scanf("%d", &idx);
		getchar();
		for(int i = idx-1; i<=curr->manytasks; i++){
			curr->tasks[i] = curr->tasks[i+1];
		}
		curr->manytasks--;
		printf("Task List Successfully Deleted!\nEnter to Continue...\n");
		getchar();
	}
}

void manage_todo2(){
	todo *curr = head;
	while(curr != NULL){
		printf("%s\n", curr->todoname);
		curr = curr->next;
	}
	
	char str[100];
	printf("\nSearch Todo Name: ");
	scanf("%[^\n]", str);
	getchar();
	
	curr = head;
	while(curr != NULL && strcmpi(curr->todoname, str)){
		printf("%s\n", curr->todoname);
		curr = curr->next;
	}
	
	if(strcmpi(curr->todoname, str) == 0){
		int options;
		do{
			system("cls");
			printf("%s\n===============\n\n", str);
			
			for(int i = 0; i<curr->manytasks; i++){
				printf("%d %s [%d hours %d minutes]\n", i+1, curr->tasks[i].taskname, curr->tasks[i].hour, curr->tasks[i].minute);
			}
			
			printf("\n");
			printf("1. Add New Task List\n2. Update Task List\n3. Done Task List\n0. Exit\n>> ");
			
			scanf("%d", &options);
			getchar();
			
			switch(options){
				case 1:
					add_task(curr);
					break;
				case 2:
					update_task(curr);
					break;
				case 3:
					done_task(curr);
					break;
			}
		}while(options != 0);
	}else{
		printf("No credentials matched\n");
	}
}

void delete_todo(){
	todo *curr = head;

	int leftidx, rightidx;
	if(head == NULL){
		printf("empty\n");
		getchar();
	}else{
		leftidx = rightidx = 1;
		while(curr != NULL){
			printf("%s\n", curr->todoname);
			curr = curr->next;
			rightidx++;
		}
		rightidx--;

	int options;
	printf("Select Index to Delete [ %d..%d ]: ", leftidx, rightidx);
	scanf("%d", &options);
	getchar();

	curr = head;

	if(options == 1){
		if(head == NULL){

		}else{
			todo *temp = head;
			head = head->next;
			free(temp);
			temp = NULL;
		}
	}else if(options == rightidx){
		todo *temp = head;
		while(temp->next->next != NULL){
			temp = temp->next;
		}
		todo *temp2 = temp->next;
		free(temp2);
		temp2 = NULL;
		temp->next = NULL;
	}else{
		int idx = 1;
		while(curr != NULL){
			if(idx+1 == options){
				todo *temp = curr->next;
				curr->next = curr->next->next;
				free(temp);
				temp = NULL;
				break;
			}
			curr = curr->next;
			idx++;
		}
	}
	}
	
}


void manage_todo(){
	int options = -1;
	do{
		system("cls");
		printf("+=======+\n| TO DO |\n+=======+\n");
		todo *curr = head;
		while(curr!=NULL){
			printf("%s\n", curr->todoname);
			curr = curr->next;
		}
		printf("1. Add New Todo\n2. Manage Todo\n3. Delete Todo\n0. Exit\n>> ");
		scanf("%d", &options);
		getchar();
		switch(options){
			case 1:
				add_todo();
				break;
			case 2:
				manage_todo2();
				break;
			case 3:
				delete_todo();
				break;
		}	
	}while(options != 0);
}

void view_todo(){
	system("cls");
	todo *curr = head;
	while(curr != NULL){
		printf("%s\n", curr->todoname);
		curr = curr->next;
	}
}

int main(){
	int options = -1;
	do{
		system("cls");
		printf("Noseon\n");
		printf("1. Manage Todo List\n2. View All Todo List\n0. Exit\n>>");
		scanf("%d", &options);
		getchar();
		switch(options){
			case 1:
				manage_todo();
				break;
			case 2:
				view_todo();
				break;
		}
	}while(options != 0);
	return 0;
}
