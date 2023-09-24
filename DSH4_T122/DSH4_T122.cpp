#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int inv = 0;

struct Node{
	int price;
	char name[100];
	char type[100];
	char id[100];
	Node *left, *right;
}*root = NULL;

Node *createNode(int price, const char *name, const char *type, const char *id){
	Node *newNode = (Node *)malloc(sizeof(Node));
	newNode->price = price;
	strcpy(newNode->name, name);
	strcpy(newNode->type, type);
	strcpy(newNode->id, id);
	newNode->left = newNode->right = NULL;
	return newNode;
}

Node *insert(Node *root, int price, const char *name, const char *type, const char *id){
	if(root == NULL){
		return createNode(price, name, type, id);
	}else if(strcmp(id, root->id) < 0){
		root->left = insert(root->left, price, name, type, id);
	}else if(strcmp(id, root->id) > 0){
		root->right = insert(root->right, price, name, type, id);
	}
	
	return root;
}

Node *findPred(Node *root){
	Node *curr = root->left;
	while(curr->right != NULL){
		curr = curr->right;
	}
	return curr;
}

Node *deleteNode(Node *root, char id[]){
    if(root == NULL){
        return NULL;
    }else if(strcmp(id, root->id) < 0){
        root->left = deleteNode(root->left, id);
    }else if(strcmp(id, root->id) > 0){
        root->right = deleteNode(root->right, id);
    }else{
        if(root->left == NULL && root->right == NULL){
            free(root);
            root = NULL;
        }else if(root->right == NULL){
            Node *temp = root->left;
            free(root);
            return temp;
        }else if(root->left == NULL){
            Node *temp = root->right;
            free(root);
            return temp;
        }else{
            Node *pred = findPred(root);
            strcpy(root->id, pred->id);
            strcpy(root->name, pred->name);
            strcpy(root->type, pred->type);
            root->price = pred->price;
            root->left = deleteNode(root->left, pred->id);
        }
    }
    return root;
}

void inOrder(Node *root){
	if(root!=NULL){
		inOrder(root->left);
		printf("%s %s %s %d\n", root->id, root->name, root->type, root->price);
		inOrder(root->right);		
	}
}

void preOrder(Node *root){
	if(root!=NULL){
		printf("%s %s %s %d\n", root->id, root->name, root->type, root->price);
		preOrder(root->left);
		preOrder(root->right);		
	}
}

void postOrder(Node *root){
	if(root!=NULL){
		postOrder(root->left);
		postOrder(root->right);		
		printf("%s %s %s %d\n", root->id, root->name, root->type, root->price);
	}
}

Node *searchNode(Node *root, char str[]){
	if(root == NULL){
		return NULL;
	}else if(strcmp(str, root->id) > 0){
		return searchNode(root->right, str);
	}else if(strcmp(str, root->id) < 0){
		return searchNode(root->left, str);
	}else{
		return root;
	}
}

void showAll(){
	if(inv == 0){
		printf("No hero yet !\nPress enter to continue...\n");
		getchar();
	}else{
		int inp;
		do{
			printf("1. InOrder\n2. PreOrder\n3. PostOrder\n4. Back\n>> ");
			scanf("%d", &inp);
			getchar();
			switch(inp){
				case 1:
					inOrder(root);
					break;
				case 2:
					preOrder(root);
					break;
				case 3:
					postOrder(root);
					break;
			}
		}while(inp != 4);	
	}
}

void insert_hero(){ // done
	inv++;
	printf(" Insert new hero\n-----------------------\n");
	
	char name[100];
	do{
		printf("Input hero name [unique and minimum 5 chars]: ");
		scanf("%[^\n]", name);
		getchar();
	}while(strlen(name) < 5);

	char type[100];
	int valid = 0;
	do{
		printf("Input hero type [Magical | Physical] (case sensitive): ");
		scanf("%[^\n]", type);
		getchar();
		if(strcmp(type, "Magical") == 0){
			valid = 1;
		}else if(strcmp(type, "Physical") == 0){
			valid = 1;
		}
	}while(valid == 0);
		
	int price;
	do{
		printf("Input hero price [minimum 10000 maximum 32000]: ");
		scanf("%d", &price);
		getchar();
	}while(price<10000 || price>32000);
	
	char id[100];
	int x1 = rand()%10;
	int x2 = rand()%10;
	int x3 = rand()%10;
	sprintf(id, "HR%d%d%d", x1,x2,x3);
	
	
	root = insert(root, price, name, type, id);
	printf("Success !\nPress enter to continue...\n");
	getchar();
}

void searching(){
	if(inv == 0){
		printf("No hero yet !\nPress enter to continue...\n");
		getchar();
	}else{
		inOrder(root);
		char str[100];
		printf("Input hero ID to search ['0' to go back]: ");
		scanf("%s", str);
		getchar();
	
		Node *curr = searchNode(root, str);
		printf("%s %s %s %d\n", curr->id, curr->name, curr->type, curr->price);
	}
}

void delete_hero(){
	if(inv == 0){
		printf("No hero yet !\nPress enter to continue...\n");
		getchar();
	}else{
		inOrder(root);
		printf(" Input hero id to delete ['0 to go back']: ");
		char id[100];
		scanf("%s", id);
		getchar();
		inv--;
		deleteNode(root, id);
	}
}

void main_menu(){
	int inp;
	do{
		printf("Welcome to mobileGeLend,\n1. Show all heroes\n2. Search hero\n3. Insert new hero\n4. Delete hero\n5. Exit\n>>");
		scanf("%d", &inp);
		getchar();
		switch(inp){
			case 1:
				showAll();
				break;
			case 2:
				searching();
				break;
			case 3:
				insert_hero();
				break;
			case 4:
				delete_hero();
				break;	
		}
	}while(inp != 5);
}

int main(){
	main_menu();
	return 0;
}

