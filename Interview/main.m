//
//  main.m
//  Interview
//
//  Created by 田洋 on 2019/9/24.
//  Copyright © 2019 田洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

#pragma mark -----树
//定义一个树的节点
typedef struct node{
    int data;
    struct node *left;
    struct node *right;
}Node;
//定义一个树根
//typedef struct用法，可以省略上面的名字
typedef struct {
    Node *root;
}Tree;
//创建树🌲

//如果不是空树的话我们可以给一个约束条件
//我们规定这个树的父节点小于右儿子又大于左儿子 也就是
//左儿子 < 父节点 < 右儿子。
//我们先按照这样去约束
void treeInsert(Tree *tree, int value){
    Node *node = (Node *)malloc(sizeof(Node));
    node -> data = value;
    node -> left = NULL;
    node -> right = NULL;
    if (tree -> root == NULL) {//空树的话node就作为树根
        tree -> root = node;
    }else{//不是空树
        
//        从树根开始查找
        Node *temp = tree ->root;
        while (temp != NULL) {
         
            if (value < temp ->data) {//小于就进左儿子
                if (temp -> left == NULL) {
                    temp -> left = (Node *)node;//安插成功
                    return;
                }else{
//                    不为空，继续循环查找插入位置
                    temp = temp -> left;
                }
            }else{//右儿子
                if (temp -> right == NULL) {
                    temp -> right = node;
                    return;
                }else{
                    temp = temp ->right;
                }
            }
        }
    }
    return;
}
// 1、先序遍历：先序遍历是先输出根节点，再输出左子树，最后输出右子树
// 2、中序遍历：中序遍历是先输出左子树，再输出根节点，最后输出右子树。
// 3、后序遍历：后序遍历是先输出左子树，再输出右子树，最后输出根节点。
//层序遍历，利用队列，根节点入队，左右节点依次入队，先进先出，从根节点开始逐层遍历
//前序，中序，后序遍历，利用栈

//树的遍历,中序遍历
void traverseTreeNoRecursion(Node *node){
    Node *stack[30], *p;
    int top = -1;
    if (node != NULL)
    {
        p = node;
        while (top > -1 || p != NULL)
        { /* 扫描p的所有左节点并入栈 */
            while (p != NULL)
            {
                top++;
                stack[top] = p;
                p = p->left;
            }
            if (top > -1)
            { /* 出栈并访问该节点 */
                p = stack[top];
                top--;
                printf("%d ", p->data);
                /* 扫描p的右孩子 */
                p = p->right;
            }
        }
        printf("\n");
    }
}

//递归法： 先序、中序和后序，实际上是指的根节点在子节点的先中后

void traverseTree(Node *node){
    
    if (node != NULL) {
//        printf("%d",node ->data);//先序
        traverseTree(node ->left);
        printf("%d",node ->data);//中序，能够从小到大依次输出
        traverseTree(node ->right);
//        printf("%d",node ->data);//后序
    }
}

//二叉树的翻转
void mirror(Node *root){
    if (root == NULL) {
        return;
    }
    Node *tempNode = root ->left;
    root ->left = root -> right;
    root ->right = tempNode;
//    翻转左子树
    mirror(root ->left);
//    翻转右子树
    mirror(root ->right);
}

//二叉树的最大深度
int maxDepth(Node *root){
//    递归，待求解的问题能够分解为相同问题的一个子问题
//    截止条件要判断好
//    总结：在循环调用中，递归语句前面的函数都是按顺序执行，递归语句后面的函数都是逆序执行（也就是在最后一个循环的语句反而最先被调用），就是这么简单。

    if (root == NULL) {
        return 0;
    }
    
    int maxLeft = maxDepth(root ->left), maxRight = maxDepth(root ->right);
    if (maxLeft > maxRight) {
        return 1 + maxLeft;
    }else{
        return 1 + maxRight;
    }
}

//二叉树叶子节点的数量（叶子节点指一棵树上所有终端节点，即没有子节点的节点称叶子节点；节点就包括根节点，中间节点，叶子节点）
int leafNodeNum(Node *root){
    if (root == NULL) {
        return 0;
    }
    
    if (root ->left == NULL && root ->right == NULL) {
        return 1;
    }
    
    return leafNodeNum(root ->left) + leafNodeNum(root ->right);
}
#pragma mark -----链表

struct student {
    int score;
    struct student *next;
};
//声明结构体变量，struct student *next;麻烦，所以起别名typedef，之后声明变量就可以LinkList *node;
typedef struct student LinkList;

//创建链表
LinkList* creat1(int n){
    LinkList *head, *node, *end;//定义头节点，普通节点，尾部节点；
//    头节点
    head = (LinkList *)malloc(sizeof(LinkList));
//    尾结点
    end = head;//若是空链表则头尾节点一样
    for (int i = 0 ; i < n; i++) {
//        节点
        node = (LinkList *)malloc(sizeof(LinkList));
        node -> score = i;
        end -> next = node;
        end = node;
    }
    end ->next = NULL;
 
    return head;
}
//修改
void change (LinkList *list, int n, int score){
//    下面为查找第n个节点的过程
    LinkList *node = list;
    int i = 0;
    while (i < n && node != NULL) {
        node = node ->next;
        i++;
    }
//    查找到要修改的节点为此节点
    if (node != NULL) {
        node ->score = score;
    }else{
        printf("节点不存在");
    }
}
//删除某个位置节点
void delete(LinkList *list, int n){
    LinkList *node = list, *preNode = NULL;
    int i = 0;
    while (i < n && node != NULL) {
        
        preNode = node;
        node = node-> next;
        i++;
    }
    
    if (node != NULL) {
        preNode ->next = node -> next;
        free(node);
    }else {
        printf("节点不存在");
    }
}

//插入一个节点
void insertNode(LinkList *list, int n, LinkList *newNode){
    
    LinkList *node = list, *preNode = NULL;
    int i = 0;
    while (i < n && node != NULL) {
        preNode = node;
        node = node -> next;
        i++;
    }
    if (node != NULL) {
        preNode -> next = newNode;
        newNode -> next = node;
    }else {
        printf("不存在节点");
    }
}

//倒置链表顺序
void reverse(LinkList *list){
    LinkList *head, *node, *preNode, *nextNode;
    head = list;
    node = head -> next;
    head ->next = NULL;
    preNode = NULL;
    
    while (node) {
        nextNode = node -> next;
        node -> next = preNode;
        preNode = node;
        node = nextNode;
    }
    
//   此时node为NULL,将头节点指向原链表最后一个元素
    head ->next = preNode;
}
//用递归方法翻转链表(我是觉得行不通，因为有一个特殊的操作就是头结点是不改变的，所以不行，下面就是拔头结点的data0也调换位置输出了)
LinkList * reverse1(LinkList *list){
    LinkList *head = list;
    if (head == NULL || head ->next == NULL) {
        return head;
    }
    
    LinkList *newList = reverse1(head ->next);
    
    LinkList *tempNode = head ->next;
    tempNode ->next = head;
    head ->next = NULL;
    
    return newList;
}

//遍历链表
void traverseList (LinkList *list){
    LinkList *node = list;
    if (node == NULL) {
        printf("链表为空");
    }
    
    while (node ->next != NULL) {
         
        node = node ->next;
        printf("%d, ",node -> score);
    }
}

#pragma mark -----排序

// 这三种排序方法都将数组分为已排序部分和未排序部分
/**
     冒泡排序 :
     最值出现在末尾；
     第一趟从五个数中找出最大值，第二趟从四个数中找出最大值，四趟
     第一趟需要两两比较四次，第二趟需要两两比较三次 、、、
 */
void bublleSort(int arr[], int lenth){
    for (int i = 0; i < lenth ; i++) {//趟数
        for (int j = 0; j < lenth - i - 1; j++) {//比较次数
            if (arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
    for (int i = 0; i<lenth; i++) {
        printf("%d", arr[i]);
    }
    printf("\n");
}
/**
     选择排序 :
     最值出现在起始端；
     第一趟从五个数中找出最小值放在第一个位置
     第二趟从四个数中找出最小值放在第二个位置
 */
void selectSort(int *arr, int lenth){
    for (int i = 0 ; i < lenth ; i++) {
        
        for (int j = i; j < lenth; j++) {
            if (arr[i] > arr[j]) {
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
    }

    for (int i = 0; i<lenth; i++) {
        printf("%d", arr[i]);
    }
    printf("\n");
}
/**
    插入排序:
    插入排序将已排序部分定义在左端，将未排序部分元的第一个元素插入到已排序部分合适的位置。
*/

void insertSort(int *arr, int lenth){
//    插入排序是一种最简单直观的排序算法
//    插入排序将已排序部分定义在左端，将未排序部分元素的第一个元素插入到已排序部分合适的位置。
    int temp ;
    int j;
    int i;
    
    for (i = 1; i < lenth; i++) {
//        占个坑（变量的内存）
        temp = arr[i];
        for (j = i ; j >= 0; j--) {
            if (temp < arr[j - 1]) {
                arr[j] = arr[j - 1];//元素右移
            }else {
//                记录到了j的位置
                break;
            }
        }
//      j+1就是i之前的合适位置，插入就好了，其他的元素已经向右移动了
        arr[j] = temp;
    }
    
    for (int i = 0; i < lenth; i++) {
        printf("%d", arr[i]);
    }
    printf("\n");
    
}

/**
    折半查找
    已知一个有序数组, 和一个key, 要求从数组中找到key对应的索引位置
*/
int findKey(int * arr, int lenth, int key){
    
    int min = 0, max = lenth - 1, mid = 0;
    while (min <= max) {
        
        mid = (min + max) / 2;
        if (key > arr[mid]) {
            min = mid + 1;
        }else if (key < arr[mid]){
            max = mid - 1;
        }else{
            printf("key = %d对应的index位置是 = %d\n",key ,mid);
            return mid;
        }
    }
    
    return -1;
}

void test(int *arr, int lenth){
    
//    冒泡
    
//    选择
    
//    插入

    for (int i = 0; i < lenth; i++) {
         printf("%d", arr[i]);
     }
     printf("\n");
    
}

bool isPalindrome(int x){
    
    if (x <= 0) {
        return false;
    }
    
    int i = 0;
    int temp = x;
    unsigned int newNumber = 0;
    while (temp / 10 != 0 || temp % 10 != 0) {
        int ge = temp % 10;
        temp = (temp - ge) / 10;
        if (i == 0 && ge == 0) {
            return false;
        }
        newNumber = newNumber*10 + ge;
        i++;
    }
    if (newNumber == x) {
        return true;
    }
    return false;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        bool bn = isPalindrome(12321);
        printf("------:  %d\n",bn);
        
        // 这三种排序方法都将数组分为已排序部分和未排序部分
        /**
         冒泡排序 :
         最值出现在末尾；
         选择排序 :
         最值出现在起始端；
         插入排序:
         插入排序将已排序部分定义在左端，将未排序部分元素的第一个元素插入到已排序部分合适的位置。
         折半查找
         已知一个有序数组, 和一个key, 要求从数组中找到key对应的索引位置
         */
        int a[] = {1,6,3,9,2,5,12,10};
        test(a , 8);
        
        printf("------bublleSort\n");
//        bublleSort(a, 8);
//        printf("------select\n");
//        selectSort(a, 8);
//        printf("------insertSort\n");
//        insertSort(a, 8);
        printf("------find\n");
        int b[] = {1, 2, 3, 4, 5, 6, 7};
        findKey(b, 7, 3);
        /**
            总结：
             冒泡排序是选出最大的依次往右边放；
             选择排序是选出最小的依次往左边放；
             插入排序是拿当前位置的元素与之前左面排好序的元素进行排序找到位置插入；
         */
        Person *p = [Person new];
        p.name = @"田洋";
        [p test];
        
        LinkList *list = creat1(5);
        traverseList(list);
        printf("------\n");
        change(list, 1, 60);
        traverseList(list);
        printf("------\n");
        delete(list, 2);
        traverseList(list);
        printf("------\n");
        LinkList *node = (LinkList *)malloc(sizeof(LinkList));
        node -> score = 90;
        insertNode(list, 2, node);
        traverseList(list);
        
        printf("------\n翻转");
//        LinkList *newList = reverse1(list);
//        traverseList(newList);
        reverse(list);
        traverseList(list);
        printf("------\n");
        Tree tree;
        tree.root = NULL;
        
        int n ;
        printf("输入要插入树中的个数：\n");
        scanf("%d",&n);
        for (int i = 0; i < n; i++) {
            int temp;
            scanf("%d",&temp);
            treeInsert(&tree, temp);
        }
        traverseTreeNoRecursion(tree.root);
//        traverseTree(tree.root);
        printf("------\n");
        int depth = maxDepth(tree.root);
        printf("树的深度为%d",depth);
        printf("------\n");
        int leafNum = leafNodeNum(tree.root);
        printf("树的叶子节点总数为%d",leafNum);
        
    }
    return 0;
}


#pragma mark -----栈

typedef int ElemType;  //定义元素类型
struct StackSq         //定义栈结构类型
{
    ElemType* stack;   //存栈元素的数组指针
    int top;           //存栈顶元素的下标位置
    int MaxSize;       //存stack数组长度
};
//C 实现 "栈": 1，顺序存储结构 ：利用数组存储新值，同时记录数组此时栈顶元素的下标top，及最大容量maxsize，超过则需扩容
//            2，链接存储结构： 利用链表
//https://blog.csdn.net/wtfmonking/article/details/16989159

#pragma mark -----队列
//C 实现 "队列" 同样也分为顺序存储结构和链接存储结构

