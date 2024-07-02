/*
* Ho Chi Minh City University of Technology
* Faculty of Computer Science and Engineering
* Initial code for Assignment 1
* Programming Fundamentals Spring 2022
* Author: Vu Van Tien
* Date: 15.02.2022
*/

//The library here is concretely set, students are not allowed to include any other libraries.
#ifndef studyInPink_h
#define studyInPink_h

#include <iostream>
#include <iomanip>
#include <cmath>
#include <string>
#include <fstream>
#include <sstream>

using namespace std;

////////////////////////////////////////////////////////////////////////
///STUDENT'S ANSWER BEGINS HERE
///Complete the following functions
///DO NOT modify any parameters in the functions.
////////////////////////////////////////////////////////////////////////

class Point {
private:
    int x;
    int y;
public:
    Point(int x = 0, int y = 0) {
        this->x = x;
        this->y = y; 
    }
    string toString() const { //describe Point
        string result;
        result = "<Point[" + to_string(x) + "," + to_string(y) + "]>";
        return result;
    }

    int distanceTo(const Point& otherPoint) const {
        double d;
        d = sqrt((x - otherPoint.x) * (x - otherPoint.x) + (y - otherPoint.y) * (y - otherPoint.y));
        return ceil(d);
    }
};

class Node {
private:
    Point point;
    Node* next;

    friend class Path;

public:
    Node(const Point& point = Point(0,0), Node* next = NULL) {
        this->point = point;
        this->next = next;
    }
    string toString() const { //describe Point in Node
        string result;
        result = "<Node[" + point.toString() + "]>";
        return result;
    }
};

class Path {
private:
    Node * head;
    Node * tail;
    int count;
    int length;

public:
    Path() {
        head = NULL;
        tail = NULL;
        count = 0;
        length = -1;
    }
    ~Path() {
        if (count) {
            Node* tmpNode = head;
            for (int i = 1; i <= count; i++) {
                head = head->next;
                delete tmpNode;
                tmpNode = head;
            }
        }
        count = 0;
        length = -1;
    }

    void addPoint(int x, int y) {
        Node* newNode = new Node(Point(x, y)); //next = Null
        if (count == 0) {
            tail = newNode;
            head = tail;
            length = 0;
        }
        else {
            length += tail->point.distanceTo(newNode->point);
            tail->next = newNode;
            tail = newNode;
        }
        count++;
    }
    string toString() const { //describe Point in Nodes in Path
        string result;
        result = "<Path[count:" + to_string(count) + ",length:" + to_string(length)+",[";
        Node* tmpNode = head;
        if (count) {
            for (int i = 1; i <= count; i++) {
                if (i != 1) result += ",";
                result += tmpNode->toString();
                if(i!=count) tmpNode = tmpNode->next;
            }
        }
        result += "]]>";
        return result;
    }
    Point getLastPoint() const {
        return tail->point;
    }
    int getLenPath() const {
        return this->length;
    }
};

class Character {
private:
    string name;
    Path * path;

public:
    Character(const string& name = "") {
        this->name = name;
        Path* newPath = new Path;
        this->path = newPath;
    }
    ~Character() {
        this->path->~Path();
    }

    string getName() const {
        return name;
    }
    void setName(const string& name) {
        this->name = name;
    }

    void moveToPoint(int x, int y) {
        path->addPoint(x, y);
    }
    string toString() const {
        string result;
        result = "<Character[name:" + name + ",path:" + path->toString() + "]>";
        return result;
    }

    Path* getPath() const {
        return path;
    }
    Point getCurrentPosition() const {
        return path->getLastPoint();
    }
};


bool rescueSherlock(
        const Character & chMurderer,
        const Character & chWatson,
        int maxLength,
        int maxDistance,
        int & outDistance
        ) {
    Path* pathMur = chMurderer.getPath();
    Path* pathWas = chWatson.getPath();
    Point lastPointOfMur = pathMur->getLastPoint();
    Point lastPointOfWas = pathWas->getLastPoint();
    if (pathWas->getLenPath() - pathMur->getLenPath() <= maxLength) {
        outDistance = lastPointOfMur.distanceTo(lastPointOfWas);
        if (outDistance <= maxDistance) return true;
    } else outDistance = -1;
    return false;
}

////////////////////////////////////////////////
///END OF STUDENT'S ANSWER
////////////////////////////////////////////////
#endif /* studyInPink_h */