#ifndef __CONCAT_STRING_TREE_H__
#define __CONCAT_STRING_TREE_H__

#include "main.h"


static int ID = 0;
enum balanceFactor { EH, LH, RH };
class ConcatStringTree {
public:
    class ParentsTree;
    class Node {
    public:
        int leftLength; //the length of left node , this is key
        int length; //length of node = leftLengt + rightLength
        int id;
        string data;
        Node* left;
        Node* right;
        ParentsTree* AVL_tree;
        // normal init
        Node(const string& data) : leftLength(0), length(int(data.length())), data(data), left(nullptr), right(nullptr), id(++ID) {
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
            //this->AVL_tree->insertAVL(this);
        };
        // concat init
        Node(Node* node, Node* otherNode) : //what is default string in C++11 ? it is "", isn't it ?
            leftLength(node->length), length(int(node->length + otherNode->length)), left(node), right(otherNode), id(++ID) {
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
        };
        // sub init
        Node(Node* otherNode, int from, int to) {
            if (!otherNode->left && !otherNode->right) {
                this->left = nullptr;
                this->right = nullptr;
                this->data = "";
                for (int i = from; i < to; i++) this->data += otherNode->data[i];
                this->leftLength = 0;
                this->length = this->data.length();
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            if (to > otherNode->leftLength && from < otherNode->leftLength) {
                this->left = new Node(otherNode->left, from, otherNode->leftLength);
                this->right = new Node(otherNode->right, 0, to - otherNode->leftLength);
                this->leftLength = otherNode->leftLength - from;
                this->length = to - from;
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            if (to <= otherNode->leftLength) {
                this->left = new Node(otherNode->left, from, to);
                this->right = nullptr;
                this->leftLength = to - from;
                this->length = to - from;
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            this->left = nullptr;
            this->right = new Node(otherNode->right, from - otherNode->leftLength, to - otherNode->leftLength);
            this->leftLength = 0;
            this->length = to - from;
            this->id = ++ID;
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
            return;
        }
        // reverse init
        Node(Node* otherNode) {
            string reverseData = "";
            if (!otherNode->left && !otherNode->right) {
                for (int i = otherNode->length - 1; i >= 0; i--) reverseData += otherNode->data[i];
                this->data = reverseData;
            }
            if (otherNode->right) this->left = new Node(otherNode->right);
            else this->left = nullptr;
            if (otherNode->left) this->right = new Node(otherNode->left);
            else this->right = nullptr;
            this->length = otherNode->length;
            this->leftLength = ((this->left == nullptr) ? 0 : this->left->length);
            this->id = ++ID;
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
        }

        ~Node() {
            delete (this->AVL_tree);
        }
    };
    Node* node;

public:
    void insert(Node*& parent, Node*& child) {
        if (child) child->AVL_tree->insertAVL(parent);
        else return;
        insert(child, child->left);
        insert(child, child->right);
    }
    ConcatStringTree(const char* s) {
        string data = "";
        data = s;
        this->node = new Node(data);
        this->node->AVL_tree->insertAVL(this->node);
    }
    ConcatStringTree(const ConcatStringTree* S, const ConcatStringTree* otherS) {
        this->node = new Node(S->node, otherS->node);
        //this->insert(this->node, this->node);
        this->node->AVL_tree->insertAVL(this->node);
        this->node->left->AVL_tree->insertAVL(this->node);
        this->node->right->AVL_tree->insertAVL(this->node);
    }
    ConcatStringTree(const ConcatStringTree* S, int from, int to) {
        this->node = new Node(S->node, from, to);
        this->insert(this->node, this->node);
    }
    ConcatStringTree(const ConcatStringTree* S) {
        this->node = new Node(S->node);
        this->insert(this->node, this->node);
    }
    int length() const {
        return node->length;
    }
    char getRec(int index, Node* node) {
        if (node->left == nullptr && node->right == nullptr) {
            return node->data[index];
        }
        if (index < node->leftLength) return getRec(index, node->left);
        else return getRec(index - node->leftLength, node->right);
    }
    char get(int index) {
        if (index < 0 || index >= node->length) throw out_of_range("Index of string is invalid!");
        return getRec(index, node);
    }
    int indexOfRec(char c, Node* node, int ans) {
        if (node == nullptr) return -1;
        if (node->left == nullptr && node->right == nullptr) {
            for (int i = 0; i < node->length; i++) {
                if (node->data[i] == c) return ans + i;
            }
            return -1;
        }
        int index = indexOfRec(c, node->left, ans);
        if (index == -1) return indexOfRec(c, node->right, ans + node->leftLength);
        return index;
    }
    int indexOf(char c) {
        return indexOfRec(c, node, 0);
    }
    string toStringPreOrderRec(Node* node) const {
        if (node == nullptr) return "";
        string ans = "";
        if (node != this->node) ans += ";";
        ans += ("(LL=" + to_string(node->leftLength) + ",L=" + to_string(node->length) + ","
            + ((node->left || node->right) ? "<NULL>" : ("\"" + node->data + "\"")) + ")"
            + toStringPreOrderRec(node->left)
            + toStringPreOrderRec(node->right));
        return ans;
    }
    string toStringPreOrder() const {
        return "ConcatStringTree[" + toStringPreOrderRec(node) + "]";

    }
    string toStringRec(Node* node) const {
        if (node == nullptr) return "";
        if (node->left == nullptr && node->right == nullptr) {
            return node->data;
        }
        return toStringRec(node->left) + toStringRec(node->right);
    }
    string toString() const {
        return "ConcatStringTree[\"" + toStringRec(this->node) + "\"]";
    }
    ConcatStringTree concat(const ConcatStringTree& otherS) const {
        return ConcatStringTree(this, &otherS);
    }
    ConcatStringTree subString(int from, int to) const {
        if (from < 0 || from >= this->node->length ||  to > this->node->length  || to < 0  ) throw out_of_range("Index of string is invalid!");
        if (from >= to) throw logic_error("Invalid range!");
        return ConcatStringTree(this, from, to);
    }
    ConcatStringTree reverse() const {
        return ConcatStringTree(this);
    }
    //
    int getParTreeSize(const string& query) const {
        int len = query.length();
        Node* tmp = this->node;
        for (int i = 0; i < len; i++) {
            if (query[i] == 'l') {
                if (tmp->left) tmp = tmp->left;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else if (query[i] == 'r') {
                if (tmp->right) tmp = tmp->right;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else throw runtime_error("Invalid character of query");
        }
        return tmp->AVL_tree->size();
    }
    string getParTreeStringPreOrder(const string& query) const {
        int len = query.length();
        Node* tmp = this->node;
        for (int i = 0; i < len; i++) {
            if (query[i] == 'l') {
                if (tmp->left) tmp = tmp->left;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else if (query[i] == 'r') {
                if (tmp->right) tmp = tmp->right;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else throw runtime_error("Invalid character of query");
        }
        return tmp->AVL_tree->toStringPreOrder();
    }

    /*void deleteParentNode(int& removeId, Node*& child) {
        if (child) child->AVL_tree->deleteAVL(removeId);
        else return;
        deleteParentNode(removeId, child->left);
        deleteParentNode(removeId, child->right);
    }*/

    void clear(Node*& node, Node*& parent) {
        if (!node) return;
        /*if (node->AVL_tree->size() == 0) {
            clear(node->left);
            clear(node->right);
            delete node;
            node = nullptr;
        }
        else return;*/
        node->AVL_tree->deleteAVL(parent->id);
        if (node->AVL_tree->size() == 0) {
            clear(node->left, node);
            clear(node->right, node);
            delete node;
            node = nullptr;
        }
        else return;
    }
    ~ConcatStringTree() {
        //this->deleteParentNode(this->node->id, this->node);
        this->clear(this->node, this->node);
    }
    class ParentsTree {
    public:

        //int maxId;
        class ParentNode {
        public:
            //Node** parent;
            int* id; //this is key
            ParentNode* left;
            ParentNode* right;
            balanceFactor bl;
            ParentNode(Node*& parent) :
                id(&(parent->id)), left(nullptr), right(nullptr), bl(EH) {}
        };
        ParentNode* root;
        int count;
        //int maxId;
    public:
        /*ParentsTree() {
            this->root = nullptr;
            maxId = 0;
        }*/
        ~ParentsTree() {};
        ParentsTree() {
            this->root = nullptr;
            this->count = 0;
            //maxId = root->id;
        }
        ParentNode* rotateRight(ParentNode*& root) {
            ParentNode* tmp = root->left;
            root->left = tmp->right;
            tmp->right = root;
            return tmp;
        }
        ParentNode* rotateLeft(ParentNode*& root) {
            ParentNode* tmp = root->right;
            root->right = tmp->left;
            tmp->left = root;
            return tmp;
        }
        ParentNode* leftBalance(ParentNode*& root, bool& taller) {
            //lol
            if (root->left->bl == LH) {
                root->bl = EH;
                root->left->bl = EH;
                root = rotateRight(root);
                taller = false;
                return root;
            }
            //rol
            ParentNode* rightOfLeftTree = root->left->right;
            if (rightOfLeftTree->bl == LH) {
                root->bl = RH;
                root->left->bl = EH;
            }
            else if (rightOfLeftTree->bl == EH) {
                root->bl = EH;
                root->left->bl = EH;
            }
            else {
                root->bl = EH;
                root->left->bl = LH;
            }
            rightOfLeftTree->bl = EH;
            root->left = rotateLeft(root->left);
            root = rotateRight(root);
            taller = false;
            return root;
        }
        ParentNode* rightBalance(ParentNode*& root, bool& taller) {
            //ror
            if (root->right->bl == RH) {
                root->bl = EH;
                root->right->bl = EH;
                root = rotateLeft(root);
                taller = false;
                return root;
            }
            //lor
            ParentNode* leftOfRightTree = root->right->left;
            if (leftOfRightTree->bl == LH) {
                root->bl = EH;
                root->right->bl = RH;
            }
            else if (leftOfRightTree->bl == EH) {
                root->bl = EH;
                root->right->bl = EH;
            }
            else {
                root->bl = LH;
                root->right->bl = EH;
            }
            leftOfRightTree->bl = EH;
            root->right = rotateRight(root->right);
            root = rotateLeft(root);
            taller = false;
            return root;
        }
        ParentNode* insertAVLRec(ParentNode*& newParentNode, ParentNode*& root, bool& taller) {
            if (root == nullptr) {
                root = newParentNode;
                taller = true;
                return root;
            }
            if (*(newParentNode->id) < *(root->id)) {
                root->left = insertAVLRec(newParentNode, root->left, taller);
                if (taller) {
                    if (root->bl == LH) root = leftBalance(root, taller);
                    else if (root->bl == EH) root->bl = LH;
                    else {
                        root->bl = EH;
                        taller = false;
                    }
                }
                return root;
            }
            else {
                root->right = insertAVLRec(newParentNode, root->right, taller);
                if (taller) {
                    if (root->bl == RH) root = rightBalance(root, taller);
                    else if (root->bl == EH) root->bl = RH;
                    else {
                        root->bl = EH;
                        taller = false;
                    }
                }
                return root;
            }
            return root;
        }
        void insertAVL(Node*& newParent) {
            bool taller = false;
            ParentNode* newParentNode = new ParentNode(newParent);
            root = insertAVLRec(newParentNode, root, taller);
            count++;
            //this->maxId++;
        }
        ParentNode* rightBalanceDel(ParentNode*& root, bool& shorter) {
            if (root->bl == LH) {
                root->bl = EH;
                return root;
            }
            if (root->bl == EH) {
                root->bl = RH;
                shorter = false;
                return root;
            }
            if (root->bl == RH) {
                //lor
                if (root->right->bl == LH) {
                    ParentNode* leftOfRightTree = root->right->left;
                    if (leftOfRightTree->bl == LH) {
                        root->bl = EH;
                        root->right->bl = RH;
                    }
                    else if (leftOfRightTree->bl == EH) {
                        root->bl = EH;
                        root->right->bl = EH;
                    }
                    else {
                        root->bl = LH;
                        root->right->bl = EH;
                    }
                    leftOfRightTree->bl = EH;
                    root->right = rotateRight(root->right);
                    root = rotateLeft(root);
                    //shorter = false;
                }
                else if (root->right->bl == RH) {
                    root->bl = EH;
                    root->right->bl = EH;
                    root = rotateLeft(root);
                    //shorter = false;
                }
                else {
                    root->bl = RH;
                    root->right->bl = LH;
                    root = rotateLeft(root);
                    shorter = false;
                }
            }
            return root;
        }
        ParentNode* leftBalanceDel(ParentNode*& root, bool& shorter) {
            if (root->bl == RH) {
                root->bl = EH;
                return root;
            }
            if (root->bl == EH) {
                root->bl = LH;
                shorter = false;
                return root;
            }
            if (root->bl == LH) {
                //lor
                if (root->left->bl == RH) {
                    ParentNode* rightOfLeftTree = root->left->right;
                    if (rightOfLeftTree->bl == RH) {
                        root->bl = EH;
                        root->left->bl = LH;
                    }
                    else if (rightOfLeftTree->bl == EH) {
                        root->bl = EH;
                        root->left->bl = EH;
                    }
                    else {
                        root->bl = RH;
                        root->left->bl = EH;
                    }
                    rightOfLeftTree->bl = EH;
                    root->left = rotateLeft(root->left);
                    root = rotateRight(root);
                    //shorter = false;
                }
                else if (root->left->bl == LH) {
                    root->bl = EH;
                    root->left->bl = EH;
                    root = rotateRight(root);
                    //shorter = false;
                }
                else {
                    root->bl = LH;
                    root->left->bl = RH;
                    root = rotateRight(root);
                    shorter = false;
                }
            }
            return root;
        }
        ParentNode* deleteAVLRec(int& removeId, ParentNode*& root, bool& shorter, bool& success) {
            if (root == nullptr) {
                shorter = false;
                success = false;
                return nullptr;
            }
            if (removeId < *(root->id)) {
                root->left = deleteAVLRec(removeId, root->left, shorter, success);
                if (shorter) {
                    root = rightBalanceDel(root, shorter);
                }
            }
            else if (removeId > *(root->id)) {
                root->right = deleteAVLRec(removeId, root->right, shorter, success);
                if (shorter) {
                    root = leftBalanceDel(root, shorter);
                }
            }
            else {
                ParentNode* tmp = root;
                if (!root->right) {
                    root = root->left;
                    success = true;
                    shorter = true;
                    delete tmp;
                    return root;
                }
                if (!root->left) {
                    root = root->right;
                    success = true;
                    shorter = true;
                    delete tmp;
                    return root;
                }
                tmp = root->left;
                while (tmp->right) tmp = tmp->right;
                root->id = tmp->id;
                root->left = deleteAVLRec(*(tmp->id), root->left, shorter, success);
                if (shorter) {
                    root = rightBalanceDel(root, shorter);
                }
            }
            return root;
        }
        void deleteAVL(int& removeId) {
            bool shorter = false;
            bool success = false;
            root = deleteAVLRec(removeId, root, shorter, success);
            //if (this->maxId == removeId) this->maxId -- ;
            if (success) count--;
        }
        //
        int size() const {
            return this->count;
        }
        string toStringPreOrderRec(ParentNode* root) const {
            if (root == nullptr) return "";
            string ans = "";
            if (root != this->root) ans += ";";
            ans += ("(id=" + to_string(*(root->id)) + ")"
                + toStringPreOrderRec(root->left)
                + toStringPreOrderRec(root->right));
            return ans;
        }
        string toStringPreOrder() const {
            return ("ParentsTree[" + toStringPreOrderRec(this->root) + "]");
        }
    };
};

class ReducedConcatStringTree; // forward declaration

class HashConfig {
private:
    int p;
    double c1, c2;
    double lambda;
    double alpha;
    int initSize;
    friend class ReducedConcatStringTree;

    //additional infor
    friend class LitStringHash;
public:
    HashConfig(int p, double c1, double c2, double lambda, double alpha, int initSize) :
        p(p), c1(c1), c2(c2), lambda(lambda), alpha(alpha), initSize(initSize)
    {};
    ~HashConfig() {};
    HashConfig() {
        p = initSize = 1;
        c1 = c2 = lambda = alpha = 1;
    };
};
class LitString {
public:
    string s;
    int ptrCount;
    LitString(string s) {
        this->s = s;
        this->ptrCount = 1;
    }
};
enum STATUS_TYPE { NIL, NON_EMPTY, DELETED };
class LitStringHash {
public:
    LitString** arr; //arr contains ptr to a litString, it mean arr[i] contain address of a litString
    STATUS_TYPE* status;
    HashConfig hashConfig;
    int lastIndexInsert;
    int count;
    int originSize;
public:
    ~LitStringHash() {
    };
    LitStringHash(const HashConfig& hashConfig) {
        this->hashConfig = hashConfig;
        this->status = new STATUS_TYPE[this->hashConfig.initSize];
        this->arr = new LitString * [this->hashConfig.initSize];
        for (int i = 0; i < this->hashConfig.initSize; i++) {
            arr[i] = nullptr;
            status[i] = NIL;
        }
        lastIndexInsert = -1;
        count = 0;
        originSize = hashConfig.initSize;
    }
    void giveMem() {
        if (count == 0 && !arr && !status && lastIndexInsert == -1) {
            hashConfig.initSize = originSize;
            arr = new LitString * [hashConfig.initSize];
            status = new STATUS_TYPE[hashConfig.initSize];
            for (int i = 0; i < hashConfig.initSize; i++) {
                arr[i] = nullptr;
                status[i] = NIL;
            }
        }
    }
    int getLastInsertedIndex() const {
        return lastIndexInsert;
    }
    string toString() const {
        string ans = "LitStringHash[(" + ((this->arr[0]) ? ("litS=\"" + this->arr[0]->s + "\"") : "") + ")";
        for (int i = 1; i < this->hashConfig.initSize; i++) {
            ans += ";(" + ((this->arr[i]) ? ("litS=\"" + this->arr[i]->s + "\"") : "") + ")";
        }
        ans += "]";
        return ans;
    }
    int h(string& s) {
        /*int mul = 1;
        int sum = 0;
        int len = s.length();
        for (int i = 0; i < len; i++) {
            sum += s[i] * mul;
            mul = mul * this->hashConfig.p;
        }
        return (sum % (this->hashConfig.initSize));*/
        //overflow
        int mul = 1;
        int sum = 0;
        int len = s.length();
        int size = this->hashConfig.initSize;
        for (int i = 0; i < len; i++) {
            sum += (s[i] * mul) % size;
            mul = (mul * this->hashConfig.p)%size;
        }
        return (sum % (this->hashConfig.initSize));
    }
    int hp(string& s, int i) {
        //overflow
        int has = h(s);
        int size = hashConfig.initSize;
        long long int ans = has + ((long long int)(this->hashConfig.c1 * i + this->hashConfig.c2 * i * i))%size;
        return ans % (this->hashConfig.initSize);
        /*int ans = h(s);
        ans = ans + int(this->hashConfig.c1 * i + this->hashConfig.c2 * i * i);
        return ans % (this->hashConfig.initSize);*/
    }
    //insert and search and remove
    //repaid rehashing (done)
    int reHashString(string s) {
        int i = 0;
        while (i < this->hashConfig.initSize) {
            int slot = hp(s, i);
            if (!arr[slot] && (status[slot] == NIL || status[slot] == DELETED)) {
                return slot;
            }
            i++;
        }
        throw runtime_error("No possible slot");
    }
    void reHashing() { //co sua
        if (count * 1.0000 > hashConfig.initSize * hashConfig.lambda) {
            int newSize = int(this->hashConfig.initSize * this->hashConfig.alpha);
            LitString** exArr = arr;
            STATUS_TYPE* exStatus = status;
            int exSize = this->hashConfig.initSize;
            arr = new LitString * [newSize];
            status = new STATUS_TYPE[newSize];
            this->hashConfig.initSize = newSize; //change config.size DONT change count or LastInsert
            for (int i = 0; i < newSize; i++) {
                arr[i] = nullptr;
                status[i] = NIL;
            }
            int newLastIndexInsert = lastIndexInsert;
            for (int i = 0; i < exSize; i++) {
                if (exArr[i]) {
                    //int slot = getKey(exArr[i]->s);
                    int slot = reHashString(exArr[i]->s);
                    arr[slot] = exArr[i]; //change arrr
                    status[slot] = NON_EMPTY; //change status, DON'T change count
                    if (i == lastIndexInsert) newLastIndexInsert = slot; //change lastIndexInsert
                }
            }
            lastIndexInsert = newLastIndexInsert;
            delete[] exArr; // just delete all elements in arr, not delete ptr litString*
            delete[] exStatus;
        }
    }
    //repair => while do (check on programing code) (not check yet, repaired) 
    int search(string& s) {
        int i = 0;
        if (count == 0) return -1;
        do {
            int slot = this->hp(s, i);
            if (this->status[slot] == NIL) return -1;
            if (this->status[slot] == DELETED);
            else if (this->status[slot] == NON_EMPTY && this->arr[slot]->s == s) return slot;
            i++;
        } while (i < this->hashConfig.initSize);
        return -1;
    }
    //repair getKey => add and rehashing after that and update new LastInsert(done) => giveMem if count == 0(done)
    //if s has already been in hash => DON'T update LastInsert (done)
    int getKey(string& s) {
        giveMem();
        int availableSlot = search(s);
        if (availableSlot != -1) {
            this->arr[availableSlot]->ptrCount++; //Dont change anything
            return availableSlot;
        }
        //not found => if arr[slot] = nullptr => insert => lastInsert = newSlot
        int i = 0;
        while (i < hashConfig.initSize) {
            int slot = hp(s, i);
            if (arr[slot] == nullptr && (status[slot] == NIL || status[slot] == DELETED)) {
                count++; //change count
                LitString* newLitString = new LitString(s);
                arr[slot] = newLitString; //change arr
                status[slot] = NON_EMPTY; //change status, DONT change config
                lastIndexInsert = slot; //change lastInser
                reHashing(); //will change lastInsert
                return lastIndexInsert;
            }
            i++;
        }
        throw runtime_error("No possible slot");
    }
    //repair => while do (check on programing code) 
    void remove(string& s) {
        int i = 0;
        if (count == 0) return;
        do {
            int slot = this->hp(s, i);
            if (this->status[slot] == NIL) {
                return;
            }
            if (this->status[slot] == NON_EMPTY && this->arr[slot]->s == s) {
                if (this->arr[slot]->ptrCount == 1) {
                    this->status[slot] = DELETED;
                    delete arr[slot];
                    arr[slot] = nullptr;
                    count--;
                }
                else this->arr[slot]->ptrCount--;
                return;
            }
            i++;
        } while (i < this->hashConfig.initSize);
    }
};
class ReducedConcatStringTree /* */ {
public:
    class ParentsTree;
    class Node {
    public:
        int leftLength; //the length of left node , this is key
        int length; //length of node = leftLengt + rightLength
        int id;
        LitString* data;
        Node* left;
        Node* right;
        ParentsTree* AVL_tree;
        // normal init
        Node(const string& data, LitString* litS) : leftLength(0), length(int(data.length())), data(litS), left(nullptr), right(nullptr), id(++ID) {
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
            //this->AVL_tree->insertAVL(this);
        };
        // concat init
        Node(Node* node, Node* otherNode) : //what is default string in C++11 ? it is "", isn't it ?
            leftLength(node->length), length(int(node->length + otherNode->length)), data(nullptr), left(node), right(otherNode), id(++ID) {
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
        };
        // sub init (create newNode => hash)
        Node(Node* otherNode, int from, int to, LitStringHash* litStringHash) {
            if (!otherNode->left && !otherNode->right) {
                this->left = nullptr;
                this->right = nullptr;
                string newS = "";
                for (int i = from; i < to; i++) newS += otherNode->data->s[i];
                if (newS == otherNode->data->s) {
                    this->data = otherNode->data; // check tc : s1 = "HELLO", S2 = "ELLO", S3 = s1.sub(1,5) => count = 2
                    this->data->ptrCount++;
                }
                else {
                    int dataKey = litStringHash->getKey(newS);
                    this->data = litStringHash->arr[dataKey];
                }
                this->leftLength = 0;
                this->length = this->data->s.length();
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            if (to > otherNode->leftLength && from < otherNode->leftLength) {
                this->left = new Node(otherNode->left, from, otherNode->leftLength, litStringHash);
                this->right = new Node(otherNode->right, 0, to - otherNode->leftLength, litStringHash);
                this->leftLength = otherNode->leftLength - from;
                this->length = to - from;
                this->data = nullptr;
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            if (to <= otherNode->leftLength) {
                this->left = new Node(otherNode->left, from, to, litStringHash);
                this->right = nullptr;
                this->leftLength = to - from;
                this->length = to - from;
                this->data = nullptr;
                this->id = ++ID;
                if (id > 10000000) throw overflow_error("Id is overflow!");
                this->AVL_tree = new ParentsTree();
                return;
            }
            this->left = nullptr;
            this->right = new Node(otherNode->right, from - otherNode->leftLength, to - otherNode->leftLength, litStringHash);
            this->leftLength = 0;
            this->length = to - from;
            this->data = nullptr;
            this->id = ++ID;
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
            return;
        }
        // reverse init
        Node(Node* otherNode, LitStringHash* litStringHash) {
            string reverseData = "";
            if (!otherNode->left && !otherNode->right) { // is litString
                for (int i = otherNode->length - 1; i >= 0; i--) reverseData += otherNode->data->s[i];
                int dataKey = litStringHash->getKey(reverseData);
                this->data = litStringHash->arr[dataKey];
            }
            if (otherNode->right) this->left = new Node(otherNode->right, litStringHash);
            else this->left = nullptr;
            if (otherNode->left) this->right = new Node(otherNode->left, litStringHash);
            else this->right = nullptr;
            this->length = otherNode->length;
            this->leftLength = ((this->left == nullptr) ? 0 : this->left->length);
            this->data = nullptr;
            this->id = ++ID;
            if (id > 10000000) throw overflow_error("Id is overflow!");
            this->AVL_tree = new ParentsTree();
        }

        ~Node() {
            //delete data;
            delete (this->AVL_tree); //has already delete data => only need to delete AVL tree
        }
    };
    Node* node;
    LitStringHash* litStringHash;
public:
    void insert(Node*& parent, Node*& child) {
        if (child) child->AVL_tree->insertAVL(parent);
        else return;
        insert(child, child->left);
        insert(child, child->right);
    }
    ReducedConcatStringTree(const char* s, LitStringHash* litStringHash) {
        this->litStringHash = litStringHash;
        string data = "";
        data = s;
        int datakey = litStringHash->getKey(data);
        this->node = new Node(data, litStringHash->arr[datakey]);
        this->node->AVL_tree->insertAVL(this->node);
    }
    ReducedConcatStringTree(const ReducedConcatStringTree* S, const ReducedConcatStringTree* otherS, LitStringHash* litStringHash) {
        this->litStringHash = litStringHash;
        this->node = new Node(S->node, otherS->node);
        this->node->AVL_tree->insertAVL(this->node);
        this->node->left->AVL_tree->insertAVL(this->node);
        this->node->right->AVL_tree->insertAVL(this->node);
    }
    ReducedConcatStringTree(const ReducedConcatStringTree* S, int from, int to, LitStringHash* litStringHash) {
        this->litStringHash = litStringHash;
        this->node = new Node(S->node, from, to, this->litStringHash);
        this->insert(this->node, this->node);
    }
    ReducedConcatStringTree(const ReducedConcatStringTree* S, LitStringHash* litStringHash) {
        this->litStringHash = litStringHash;
        this->node = new Node(S->node, litStringHash);
        this->insert(this->node, this->node);
    }
    int length() const {
        return node->length;
    }
    char getRec(int index, Node* node) {
        if (node->left == nullptr && node->right == nullptr) {
            return node->data->s[index];
        }
        if (index < node->leftLength) return getRec(index, node->left);
        else return getRec(index - node->leftLength, node->right);
    }
    char get(int index) {
        if (index < 0 || index >= node->length) throw out_of_range("Index of string is invalid!");
        return getRec(index, node);
    }
    int indexOfRec(char c, Node* node, int ans) {
        if (node == nullptr) return -1;
        if (node->left == nullptr && node->right == nullptr) {
            for (int i = 0; i < node->length; i++) {
                if (node->data->s[i] == c) return ans + i;
            }
            return -1;
        }
        int index = indexOfRec(c, node->left, ans);
        if (index == -1) return indexOfRec(c, node->right, ans + node->leftLength);
        return index;
    }
    int indexOf(char c) {
        return indexOfRec(c, node, 0);
    }
    string toStringPreOrderRec(Node* node) const {
        if (node == nullptr) return "";
        string ans = "";
        if (node != this->node) ans += ";";
        ans += ("(LL=" + to_string(node->leftLength) + ",L=" + to_string(node->length) + ","
            + ((node->left || node->right) ? "<NULL>" : ("\"" + node->data->s + "\"")) + ")"
            + toStringPreOrderRec(node->left)
            + toStringPreOrderRec(node->right));
        return ans;
    }
    string toStringPreOrder() const {
        return "ConcatStringTree[" + toStringPreOrderRec(node) + "]";

    }
    string toStringRec(Node* node) const {
        if (node == nullptr) return "";
        if (node->left == nullptr && node->right == nullptr) {
            return node->data->s;
        }
        return toStringRec(node->left) + toStringRec(node->right);
    }
    string toString() const {
        return "ConcatStringTree[\"" + toStringRec(this->node) + "\"]";
    }
    ReducedConcatStringTree concat(const ReducedConcatStringTree& otherS) const {
        return ReducedConcatStringTree(this, &otherS, this->litStringHash);
    }
    ReducedConcatStringTree subString(int from, int to) const {
        if (from < 0 || from >= this->node->length || to > this->node->length || to < 0) throw out_of_range("Index of string is invalid!");
        if (from >= to) throw logic_error("Invalid range!");
        return ReducedConcatStringTree(this, from, to, this->litStringHash);
    }
    ReducedConcatStringTree reverse() const {
        return ReducedConcatStringTree(this, this->litStringHash);
    }
    //
    int getParTreeSize(const string& query) const {
        int len = query.length();
        Node* tmp = this->node;
        for (int i = 0; i < len; i++) {
            if (query[i] == 'l') {
                if (tmp->left) tmp = tmp->left;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else if (query[i] == 'r') {
                if (tmp->right) tmp = tmp->right;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else throw runtime_error("Invalid character of query");
        }
        return tmp->AVL_tree->size();
    }
    string getParTreeStringPreOrder(const string& query) const {
        int len = query.length();
        Node* tmp = this->node;
        for (int i = 0; i < len; i++) {
            if (query[i] == 'l') {
                if (tmp->left) tmp = tmp->left;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else if (query[i] == 'r') {
                if (tmp->right) tmp = tmp->right;
                else throw runtime_error("Invalid query: reaching NULL");
            }
            else throw runtime_error("Invalid character of query");
        }
        return tmp->AVL_tree->toStringPreOrder();
    }

    //void deleteParentNode(int& removeId, Node*& child) {
    //    if (child) child->AVL_tree->deleteAVL(removeId);
    //    else return;
    //    deleteParentNode(removeId, child->left);
    //    deleteParentNode(removeId, child->right);
    //}

    void clear(Node*& node, Node*& parent) {
        if (!node) return;
        node->AVL_tree->deleteAVL(parent->id);
        if (node->AVL_tree->size() == 0) {
            if (node->data) litStringHash->remove(node->data->s); // delete data if not null (leaf) and delete node after that
            clear(node->left, node);
            clear(node->right, node);
            delete node; //it means delete AVL also (in ~Node())
            node = nullptr;
        }
        else return;
    }
    ~ReducedConcatStringTree() {
        //this->deleteParentNode(this->node->id, this->node);
        this->clear(this->node, this->node);
        if (this->litStringHash->count == 0) {
            delete[] this->litStringHash->arr;
            this->litStringHash->arr = nullptr; // dont delete Hash, after delete S check if count == 0 => delete data of Hash
            delete[] this->litStringHash->status; //delete status, arr, change count (no need), change last = -1, DONT CHANGE config
            this->litStringHash->status = nullptr;
            this->litStringHash->lastIndexInsert = -1; // have just delete data so let it equal to -1
        }
    }
    class ParentsTree {
    public:

        //int maxId;
        class ParentNode {
        public:
            //Node** parent;
            int* id; //this is key
            ParentNode* left;
            ParentNode* right;
            balanceFactor bl;
            ParentNode(Node*& parent) :
                id(&(parent->id)), left(nullptr), right(nullptr), bl(EH) {}
        };
        ParentNode* root;
        int count;
        //int maxId;
    public:
        /*ParentsTree() {
            this->root = nullptr;
            maxId = 0;
        }*/
        ~ParentsTree() {};
        ParentsTree() {
            this->root = nullptr;
            this->count = 0;
            //maxId = root->id;
        }
        ParentNode* rotateRight(ParentNode*& root) {
            ParentNode* tmp = root->left;
            root->left = tmp->right;
            tmp->right = root;
            return tmp;
        }
        ParentNode* rotateLeft(ParentNode*& root) {
            ParentNode* tmp = root->right;
            root->right = tmp->left;
            tmp->left = root;
            return tmp;
        }
        ParentNode* leftBalance(ParentNode*& root, bool& taller) {
            //lol
            if (root->left->bl == LH) {
                root->bl = EH;
                root->left->bl = EH;
                root = rotateRight(root);
                taller = false;
                return root;
            }
            //rol
            ParentNode* rightOfLeftTree = root->left->right;
            if (rightOfLeftTree->bl == LH) {
                root->bl = RH;
                root->left->bl = EH;
            }
            else if (rightOfLeftTree->bl == EH) {
                root->bl = EH;
                root->left->bl = EH;
            }
            else {
                root->bl = EH;
                root->left->bl = LH;
            }
            rightOfLeftTree->bl = EH;
            root->left = rotateLeft(root->left);
            root = rotateRight(root);
            taller = false;
            return root;
        }
        ParentNode* rightBalance(ParentNode*& root, bool& taller) {
            //ror
            if (root->right->bl == RH) {
                root->bl = EH;
                root->right->bl = EH;
                root = rotateLeft(root);
                taller = false;
                return root;
            }
            //lor
            ParentNode* leftOfRightTree = root->right->left;
            if (leftOfRightTree->bl == LH) {
                root->bl = EH;
                root->right->bl = RH;
            }
            else if (leftOfRightTree->bl == EH) {
                root->bl = EH;
                root->right->bl = EH;
            }
            else {
                root->bl = LH;
                root->right->bl = EH;
            }
            leftOfRightTree->bl = EH;
            root->right = rotateRight(root->right);
            root = rotateLeft(root);
            taller = false;
            return root;
        }
        ParentNode* insertAVLRec(ParentNode*& newParentNode, ParentNode*& root, bool& taller) {
            if (root == nullptr) {
                root = newParentNode;
                taller = true;
                return root;
            }
            if (*(newParentNode->id) < *(root->id)) {
                root->left = insertAVLRec(newParentNode, root->left, taller);
                if (taller) {
                    if (root->bl == LH) root = leftBalance(root, taller);
                    else if (root->bl == EH) root->bl = LH;
                    else {
                        root->bl = EH;
                        taller = false;
                    }
                }
                return root;
            }
            else {
                root->right = insertAVLRec(newParentNode, root->right, taller);
                if (taller) {
                    if (root->bl == RH) root = rightBalance(root, taller);
                    else if (root->bl == EH) root->bl = RH;
                    else {
                        root->bl = EH;
                        taller = false;
                    }
                }
                return root;
            }
            return root;
        }
        void insertAVL(Node*& newParent) {
            bool taller = false;
            ParentNode* newParentNode = new ParentNode(newParent);
            root = insertAVLRec(newParentNode, root, taller);
            count++;
            //this->maxId++;
        }
        ParentNode* rightBalanceDel(ParentNode*& root, bool& shorter) {
            if (root->bl == LH) {
                root->bl = EH;
                return root;
            }
            if (root->bl == EH) {
                root->bl = RH;
                shorter = false;
                return root;
            }
            if (root->bl == RH) {
                //lor
                if (root->right->bl == LH) {
                    ParentNode* leftOfRightTree = root->right->left;
                    if (leftOfRightTree->bl == LH) {
                        root->bl = EH;
                        root->right->bl = RH;
                    }
                    else if (leftOfRightTree->bl == EH) {
                        root->bl = EH;
                        root->right->bl = EH;
                    }
                    else {
                        root->bl = LH;
                        root->right->bl = EH;
                    }
                    leftOfRightTree->bl = EH;
                    root->right = rotateRight(root->right);
                    root = rotateLeft(root);
                    //shorter = false;
                }
                else if (root->right->bl == RH) {
                    root->bl = EH;
                    root->right->bl = EH;
                    root = rotateLeft(root);
                    //shorter = false;
                }
                else {
                    root->bl = RH;
                    root->right->bl = LH;
                    root = rotateLeft(root);
                    shorter = false;
                }
            }
            return root;
        }
        ParentNode* leftBalanceDel(ParentNode*& root, bool& shorter) {
            if (root->bl == RH) {
                root->bl = EH;
                return root;
            }
            if (root->bl == EH) {
                root->bl = LH;
                shorter = false;
                return root;
            }
            if (root->bl == LH) {
                //lor
                if (root->left->bl == RH) {
                    ParentNode* rightOfLeftTree = root->left->right;
                    if (rightOfLeftTree->bl == RH) {
                        root->bl = EH;
                        root->left->bl = LH;
                    }
                    else if (rightOfLeftTree->bl == EH) {
                        root->bl = EH;
                        root->left->bl = EH;
                    }
                    else {
                        root->bl = RH;
                        root->left->bl = EH;
                    }
                    rightOfLeftTree->bl = EH;
                    root->left = rotateLeft(root->left);
                    root = rotateRight(root);
                    //shorter = false;
                }
                else if (root->left->bl == LH) {
                    root->bl = EH;
                    root->left->bl = EH;
                    root = rotateRight(root);
                    //shorter = false;
                }
                else {
                    root->bl = LH;
                    root->left->bl = RH;
                    root = rotateRight(root);
                    shorter = false;
                }
            }
            return root;
        }
        ParentNode* deleteAVLRec(int& removeId, ParentNode*& root, bool& shorter, bool& success) {
            if (root == nullptr) {
                shorter = false;
                success = false;
                return nullptr;
            }
            if (removeId < *(root->id)) {
                root->left = deleteAVLRec(removeId, root->left, shorter, success);
                if (shorter) {
                    root = rightBalanceDel(root, shorter);
                }
            }
            else if (removeId > *(root->id)) {
                root->right = deleteAVLRec(removeId, root->right, shorter, success);
                if (shorter) {
                    root = leftBalanceDel(root, shorter);
                }
            }
            else {
                ParentNode* tmp = root;
                if (!root->right) {
                    root = root->left;
                    success = true;
                    shorter = true;
                    delete tmp;
                    return root;
                }
                if (!root->left) {
                    root = root->right;
                    success = true;
                    shorter = true;
                    delete tmp;
                    return root;
                }
                tmp = root->left;
                while (tmp->right) tmp = tmp->right;
                root->id = tmp->id;
                root->left = deleteAVLRec(*(tmp->id), root->left, shorter, success);
                if (shorter) {
                    root = rightBalanceDel(root, shorter);
                }
            }
            return root;
        }
        void deleteAVL(int& removeId) {
            bool shorter = false;
            bool success = false;
            root = deleteAVLRec(removeId, root, shorter, success);
            //if (this->maxId == removeId) this->maxId -- ;
            if (success) count--;
        }
        //
        int size() const {
            return this->count;
        }
        string toStringPreOrderRec(ParentNode* root) const {
            if (root == nullptr) return "";
            string ans = "";
            if (root != this->root) ans += ";";
            ans += ("(id=" + to_string(*(root->id)) + ")"
                + toStringPreOrderRec(root->left)
                + toStringPreOrderRec(root->right));
            return ans;
        }
        string toStringPreOrder() const {
            return ("ParentsTree[" + toStringPreOrderRec(this->root) + "]");
        }
    };
};



#endif // __CONCAT_STRING_TREE_H__