#ifndef __CONCAT_STRING_LIST_H__
#define __CONCAT_STRING_LIST_H__

#include "main.h"


class ConcatStringList {
public:
	class ReferencesList; // forward declaration
	class DeleteStringList; // forward declaration
	class DeleteStringListRef;

public:
	static ReferencesList refList;
	static DeleteStringList delStrList;
	static DeleteStringListRef delStrListRef;

	class CharALNode {
	public:
		string CharArrayList;
		CharALNode* nextNode;
	public:
		CharALNode(const char* s, CharALNode* nextNode) {
			this->CharArrayList = "";
			int i = 0;
			while (s[i] != '\0') {
				this->CharArrayList += s[i];
				i++;
			}
			this->nextNode = nextNode;
			//delete[] s; // sửa lại k để delete chỗ này, đế ở vị trí sub với reverse
		}
	};
	CharALNode* head;
	CharALNode* tail;
	bool isDump;
	int lenS;
public:
	ConcatStringList(const char* s) {
		CharALNode* newNode = new CharALNode(s, nullptr);
		head = newNode;
		tail = newNode;
		lenS = newNode->CharArrayList.length();
		refList.addNode(newNode, 2,true);
		refList.QuickSort();
		refList.move0ToTail();
		isDump = false;
	}
	//default constructor (just added)
	ConcatStringList() : head(nullptr), tail(nullptr), lenS(0), isDump(false) {};
	//ConcatStringList(const ConcatStringList& other) : head(other.head), tail(other.tail), lenS(other.lenS) {};
	int length() const {
		return lenS;
	}
	char get(int index) const {
		if (index > lenS - 1 || index < 0) throw out_of_range("Index of string is invalid!");
		int tmpIndex;
		CharALNode* tmpNode = head;
		tmpIndex = head->CharArrayList.length() - 1;
		while (index > tmpIndex) {
			tmpNode = tmpNode->nextNode;
			tmpIndex += tmpNode->CharArrayList.length();
		}
		int result;
		result = tmpNode->CharArrayList.length() - (tmpIndex - index) - 1;
		return tmpNode->CharArrayList[result];
	}
	int indexOf(char c) const {
		CharALNode* tmpNode = head;
		int index = 0, i = 0;
		while (tmpNode != tail->nextNode) {
			while (i < tmpNode->CharArrayList.length()) {
				if (tmpNode->CharArrayList[i] == c) return index;
				else {
					i++;
					index++;
				}
			}
			i = 0;
			tmpNode = tmpNode->nextNode;
		}
		return -1;
	}
	std::string toString() const {
		string result = "";
		CharALNode* tmpNode = head;
		while (tmpNode != tail->nextNode) {
			result += tmpNode->CharArrayList;
			tmpNode = tmpNode->nextNode;
		}
		return result;
	}
	ConcatStringList concat(const ConcatStringList& otherS) const {
		ConcatStringList* result = new ConcatStringList();
		result->head = this->head;
		result->tail = this->tail;
		result->lenS = this->lenS;
		result->tail->nextNode = otherS.head;
		result->tail = otherS.tail;
		result->lenS += otherS.lenS;
		refList.addNode(result->head, 1,false);
		refList.addNode(result->tail, 1,false);
		refList.QuickSort();
		refList.move0ToTail();
		//cout << &(*result)<<endl;
		delStrListRef.addDeleted(result);
		return *result;
		// do again
	}
	ConcatStringList subString(int from, int to) const {
		if (from < 0 || from >= lenS || to <= 0 || to > lenS) throw out_of_range("Index of string is invalid!");
		if (from >= to) throw logic_error("Invalid range");
		CharALNode* tmpNode = head;
		int lenS = tmpNode->CharArrayList.length() - 1;
		ConcatStringList* newList;
		// cộng lenS với lenS kế sao cho lenS > from


		while (lenS < from) {
			tmpNode = tmpNode->nextNode;
			lenS += tmpNode->CharArrayList.length();
		}
		// Nếu lenS < to -1 (ko lấy to) => cộng vào char từ from đến lenS tạo Node đầu tiên
		if (lenS < to - 1) {
			char* s = new char[lenS - from + 2];
			for (int i = 0; i <= lenS - from; i++) {
				s[i] = get(i + from);
			}
			s[lenS - from + 1] = '\0';
			newList = new ConcatStringList(s); // create a node with ref = 2 (added in refList)
			refList.addNode(newList->head, -1,false); // reduce the ref by 1 cause of at least 2 node
			delete[] s;
		}
		// Nếu lenS >= to -1 => cộng từ from đến to và return vì from và to ở cùng 1 node
		else {
			char* s = new char[to - from + 1];
			for (int i = 0; i < to - from; i++) {
				s[i] = get(i + from);
			}
			s[to - from] = '\0';
			newList = new ConcatStringList(s);
			//refList.QuickSort();
			//refList.move0ToTail();
			delete[] s;
			delStrListRef.addDeleted(newList);
			return *newList;
		}
		// cộng thêm cái node còn lại và update ref của tail
		tmpNode = tmpNode->nextNode;
		lenS += tmpNode->CharArrayList.length();
		while (lenS < to - 1) {
			char* s = new char[tmpNode->CharArrayList.length() + 1];
			for (int i = 0; i < tmpNode->CharArrayList.length(); i++)
				s[i] = tmpNode->CharArrayList[i];
			s[tmpNode->CharArrayList.length()] = '\0';
			/*ConcatStringList tmpList(s);
			*newList = (newList->concat(tmpList)); */// thay đổi để k tạo chuỗi trung gian
			CharALNode* newNode = new CharALNode(s, nullptr);
			newList->tail->nextNode = newNode;
			newList->tail = newNode;
			newList->lenS += newList->tail->CharArrayList.length();
			tmpNode = tmpNode->nextNode;
			lenS += tmpNode->CharArrayList.length();
			delete[] s;
		}
		//node cuối cùng sẽ từ đầu node đến to
		lenS = lenS - tmpNode->CharArrayList.length() + 1;
		char* s = new char[to - lenS + 1];
		for (int i = lenS, j = 0; i < to; i++, j++) {
			s[j] = get(i);
		}
		s[to - lenS] = '\0';
		CharALNode* newNode = new CharALNode(s, nullptr);
		newList->tail->nextNode = newNode;
		newList->tail = newNode;
		newList->lenS += newNode->CharArrayList.length();
		//ConcatStringList tmpList(s);
		//*newList = (newList->concat(tmpList));
		//refList.addNode(newList->head, 1);
		refList.addNode(newList->tail, 1,true); //dont need to add head cause of already added
		refList.QuickSort();
		refList.move0ToTail();
		delete[] s;
		delStrListRef.addDeleted(newList);
		return *newList;
	}
	ConcatStringList reverse() const {
		ConcatStringList* newL;
		CharALNode* tmpNode = this->head;
		int lenS = tmpNode->CharArrayList.length();
		char* s = new char[lenS + 1];
		for (int i = 0; i < lenS; i++) {
			s[i] = tmpNode->CharArrayList[lenS - i - 1];
		}
		s[lenS] = '\0';
		newL = new ConcatStringList(s); // added head by 2 and update lenS
		refList.addNode(newL->head, -1,false); //reduce by 1 => dont need to add again
		tmpNode = tmpNode->nextNode;
		delete[] s;
		bool add = true;
		if (head == tail) add = false; //only reverse 1 node=> has already in refNode => add = false
		while (tmpNode != tail->nextNode) {
			lenS = tmpNode->CharArrayList.length();
			char* s = new char[lenS + 1];
			for (int i = 0; i < lenS; i++) {
				s[i] = tmpNode->CharArrayList[lenS - i - 1];
			}
			s[lenS] = '\0';
			//add before head
			CharALNode* newNode = new CharALNode(s, newL->head);
			newL->head = newNode;
			newL->lenS += newNode->CharArrayList.length();
			//ConcatStringList* nextL = new ConcatStringList(s);
			//*newL = (nextL->concat(*newL));
			tmpNode = tmpNode->nextNode;
			delete[] s;
		}
		refList.addNode(newL->head, 1,add); // 1 node, increase head by 1
		refList.QuickSort();
		refList.move0ToTail();
		delStrListRef.addDeleted(newL);
		return *newL;
	}
	~ConcatStringList() {
		if (isDump) {
			this->head = nullptr;
			this->tail = nullptr;
			lenS = 0;
			//this = nullptr;
		}
		else {
			refList.addNode(head, -1,false);
			refList.addNode(tail, -1,false);
			refList.QuickSort();
			refList.move0ToTail();
			delStrList.addDeleted(this);
			delStrList.removeNode();
			head = nullptr;
			tail = nullptr;
			lenS = 0;
			refList.clear();
		}
		//cout << endl << refList.size() << endl;
		//cout << refList.refCountsString() << endl;
		//cout << delStrList.size()<<endl;
		//cout << delStrList.totalRefCountsString() << endl;
		//test (remember to delete)
		//this = nullptr;
	} // làm tiếp

public:
	class ReferencesList {
	public:
		class refNode
		{
		public:
			CharALNode* node;
			int numRef;
			refNode* nextRef;
			refNode(CharALNode* node, int numRef, refNode* nextRef) :
				node(node), numRef(numRef), nextRef(nextRef) {};
		};
		refNode* head;
		refNode* tail;
		int count;
		//constructor
		ReferencesList() : head(nullptr), tail(nullptr), count(0) {};
		//
		void clear() {
			refNode* tmp = head;
			if (head->numRef == 0) {
				for (int i = 0; i < count; i++) {
					head = tmp->nextRef;
					delete tmp;
					tmp = head;
				}
				count = 0;
				tail = nullptr;
				delStrListRef.removeNode();
			}
			else return;
		}
		//function
		void addNode(CharALNode* othernode, int numRef, bool add) {
			refNode* temp = head;
			// if node has already been in list //add= false
			if (!add) {
				for (int i = 1; i <= count; i++) {
					if (temp->node == othernode) {
						temp->numRef += numRef;
						return;
					}
					temp = temp->nextRef;
				}
				//return;
			}
			// not in list yet
			refNode* newRef = new refNode(othernode, numRef, nullptr);
			// has at least 1 node => add in tail
			if (count) {
				tail->nextRef = newRef;
				tail = newRef;
				count++;
			}
			else {
				head = newRef;
				tail = newRef;
				count++;
			}
		}
		//add at tail refNode => sp Quick Sort
		void AddRefNode(refNode* otherRefNode) {
			if (count) {
				this->tail->nextRef = otherRefNode;
				this->tail = otherRefNode;
			}
			else {
				this->head = otherRefNode;
				this->tail = otherRefNode;
			}
			this->count++;
		}
		void QuickSort() {
			if (this->head == this->tail)
			{
				return;
			}// if only has 1 element => do nothing
			ReferencesList* refList1 = new ReferencesList();
			ReferencesList* refList2 = new ReferencesList();
			refNode* tag;
			refNode* temp;

			tag = this->head; // separate head to a tag
			this->head = this->head->nextRef; //update head
			tag->nextRef = nullptr;
			while (this->head != nullptr) {
				temp = this->head;
				this->head = this->head->nextRef;
				temp->nextRef = nullptr;
				if (temp->numRef < tag->numRef) refList1->AddRefNode(temp);
				else refList2->AddRefNode(temp);
			}
			refList1->QuickSort(); //recursion
			refList2->QuickSort();
			// link L1 and L2 to tag
			if (refList1->count) {
				refList1->tail->nextRef = tag;
				this->head = refList1->head;
			}
			else {
				this->head = tag;
			}
			tag->nextRef = refList2->head;
			if (refList2->count) this->tail = refList2->tail;
			else this->tail = tag;
			delete refList1; // cause of useless refList 1 and 2
			delete refList2;
		}
		void move0ToTail() {
			refNode* tmp = head;
			int totalRefcount = 0;
			while (tmp != nullptr) {
				totalRefcount += tmp->numRef;
				tmp = tmp->nextRef;
			}
			if (totalRefcount) tmp = head;
			else return;
			while (tmp != nullptr) {
				if (tmp->numRef == 0) {
					head = tmp->nextRef; // move head
					tmp->nextRef = nullptr; //isolation tmp;
					tail->nextRef = tmp; //link tail->tmp;
					tail = tmp; //move tail;
					tmp = head;
				}
				else break;
			}
		}
	public:
		int size() const {
			return this->count;
		}
		int refCountAt(int index) const {
			if (index < 0 || index >= count) throw out_of_range("Index of references list is invalid!");
			refNode* tmp = this->head;
			for (int i = 1; i <= index; i++) {
				tmp = tmp->nextRef;
			}
			return tmp->numRef;
		}
		std::string refCountsString() const {
			string result = "RefCounts[";
			refNode* tmp = this->head;
			while (tmp != nullptr) {
				string numRef = to_string(tmp->numRef);
				result += (numRef);
				if (tmp->nextRef != nullptr) {
					result += ",";
				}
				else {
					result += "]";
					return result;
				}
				tmp = tmp->nextRef;
			}
			result += "]";
			return result;
		}
		/*int refCountWithNode(CharALNode* node) {
			refNode* tmp = head;
			for (int i = 0; i < count; i++) {
				if (tmp->node == node) return tmp->numRef;
				tmp = tmp->nextRef;
			}
		}*/
		int* refCountWithNode1(CharALNode* node) {
			refNode* tmp = head;
			for (int i = 0; i < count; i++) {
				if (tmp->node == node) return &(tmp->numRef);
				tmp = tmp->nextRef;
			}
		}
	};

	class DeleteStringList {
	public:
		class deletedS {
		public:
			CharALNode* head;
			CharALNode* tail;
			int* numRefH;
			int* numRefT;
			bool deletedHeadTail;
			deletedS* nextDeletedS;
			deletedS(CharALNode* head, CharALNode* tail, deletedS* nextDeletedS) :
				head(head), tail(tail), nextDeletedS(nextDeletedS), deletedHeadTail(false) {
				numRefH = (refList.refCountWithNode1(head));
				numRefT = (refList.refCountWithNode1(tail));
			};
		};
		deletedS* headDeleted;
		deletedS* tailDeleted;
		int count;
		DeleteStringList() : headDeleted(nullptr), tailDeleted(nullptr), count(0) {};

		//function
		void addDeleted(ConcatStringList* stringList) {
			deletedS* newNode = new deletedS(stringList->head, stringList->tail, nullptr);
			if (count) {
				this->tailDeleted->nextDeletedS = newNode;
				this->tailDeleted = newNode;
			}
			else {
				this->headDeleted = newNode;
				this->tailDeleted = newNode;
			}
			count++;
		}
		void removeNode() {
			deletedS* tmp = this->headDeleted;
			while (tmp != nullptr) {
				if (*tmp->numRefH == 0 && *tmp->numRefT==0) {
					//check head tail has already been deleted => just remove node
					if (tmp->deletedHeadTail) {
						deletedS* tmp2 = tmp;
						tmp = tmp->nextDeletedS;
						removeDeletedS(tmp2);
					}
					//check before delete head, tail that others string has head tail having the same address with current string
					//=> assign deletedHeadTail = true;
					else {
						checkDeleted(tmp);
						CharALNode* tmpNode = tmp->head;

						// delete nodes between head and tail
						if (tmp->head == tmp->tail) { // has 1 element
							delete tmp->head;
							tmp->tail = nullptr;
						}
						else {
							tmpNode = tmpNode->nextNode;
							while (tmpNode != tmp->tail) {
								CharALNode* tmpNode2 = tmpNode->nextNode;
								delete tmpNode;
								tmpNode = tmpNode2;
							}
							//delete head tail
							delete tmp->head;
							delete tmp->tail;

						}

						//delete Node from deletedList
						deletedS* tmp2 = tmp;
						tmp = tmp->nextDeletedS;
						removeDeletedS(tmp2);
					}
				}
				else tmp = tmp->nextDeletedS;
			}
		}
		void removeDeletedS(deletedS* node) {

			//1 node
			if (count == 1) {
				delete headDeleted;
				tailDeleted = nullptr;
				headDeleted = nullptr;
				count--;
				return;
			}
			//2 node and deleted at head
			if (node == headDeleted) {
				headDeleted = node->nextDeletedS;
				delete node;
				count--;
				return;
			}
			//
			deletedS* tmp = headDeleted;
			while (tmp->nextDeletedS != node) tmp = tmp->nextDeletedS;
			// remove tail
			if (node == tailDeleted) {
				tmp->nextDeletedS = nullptr;
				tailDeleted = tmp;
			}
			// others
			else {
				tmp->nextDeletedS = node->nextDeletedS;
			}
			delete node;
			//node = nullptr;
			count--;
		}
		void checkDeleted(deletedS* node) {
			deletedS* tmp = headDeleted;
			while (tmp != nullptr) {
				if (tmp == node) tmp = tmp->nextDeletedS;
				else {
					if (tmp->head == node->head || tmp->tail == node->head || tmp->head == node->tail || tmp->tail == node->tail) {
						tmp->deletedHeadTail = true;
						tmp = tmp->nextDeletedS;
					}
					else tmp = tmp->nextDeletedS;
				}
			}
		}
	public:
		int size() const {
			return count;
		}
		std::string totalRefCountsString() const {
			deletedS* tmp = headDeleted;
			//ConcatStringList::ReferencesList::refNode* tmpRef = refList.head;
			int total = 0;
			string result = "TotalRefCounts[";
			while (tmp != nullptr) {
				if (tmp->head == tmp->tail) total = *(tmp->numRefH);
				else total = *(tmp->numRefH) + *(tmp->numRefT);
				result += to_string(total);
				if (tmp->nextDeletedS != nullptr) {
					result += ",";
					tmp = tmp->nextDeletedS;
				}
				else {
					result += "]";
					return result;
				}
			}
			result += "]";
			return result;

		}
	};

	class DeleteStringListRef {
	public:
		class DumpString {
		public:
			ConcatStringList* str;
			DumpString* nextStr;
			DumpString(ConcatStringList* other, DumpString* nextStr) :
				str(other), nextStr(nextStr) {};
			~DumpString() {
				delete this->str;
			}
		};
		DumpString* head;
		DumpString* tail;
		int count;
		DeleteStringListRef() : head(nullptr), tail(nullptr), count(0) {};
		//function
		void removeNode() {
			DumpString* tmp = head;
			if (count) {
				while (tmp != nullptr) {
					tmp->str->isDump = true;
					DumpString* tmp2 = tmp->nextStr;
					delete tmp;
					tmp = tmp2;
				}
				count = 0;
			}
		}
		void addDeleted(ConcatStringList* stringList) {
			DumpString* newNode = new DumpString(stringList, nullptr);
			//newNode->str->isDump = true;
			if (count) {
				this->tail->nextStr = newNode;
				this->tail = newNode;
			}
			else {
				this->head = newNode;
				this->tail = newNode;
			}
			count++;
		}

	};
};


#endif // __CONCAT_STRING_LIST_H__