/*
* Ho Chi Minh City University of Technology
* Faculty of Computer Science and Engineering
* Initial code for Assignment 1
* Programming Fundamentals Spring 2022
* Author: Vu Van Tien
* Date: 10.02.2022
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
bool checkValid(char* s, int n) {
    int len;
    for (len = 0; s[len] != '\0'; len++);
    if (len != n) return false;
    for (int i = 0; i < len; i++) {
        if (s[i] <= '9' && s[i] >= '0');
        else return false;
    }
    return true;
}

string notebook1(string ntb1) {
    fstream ifs(ntb1, ios_base::in);
    char buf[1024];
    int n1;
    string result = "0000000000";
    ifs.getline(buf, 12, '/');
    ifs.getline(buf, 12, '/');
    ifs.getline(buf, 4);
    if (checkValid(buf, 3)) n1 = atoi(buf);
    else return "0000000000";
    if (n1 < 1 || n1 >999) return "0000000000";
    else {
        for (int i = 0; i < n1; i++) {
            ifs.getline(buf, 2, ' ');
            result[atoi(buf)]++;
            if (result[atoi(buf)] > '9') result[atoi(buf)] -= 10;
        }
    }
    ifs.close();
    return result;
}
//=========================================
int numOf_s1_in_S(string s, string s1) {
    int i = -1, count = 0, len = s.length();
    while (i < len) {
        i = s.find(s1, i + 1);
        if (i == -1) break;
        else {
            count += 1;
        }
    }
    return count;
}
string notebook2(string ntb2) {
    fstream ifs(ntb2, ios_base::in);
    char buf[1024];
    long long int cntP = 0;
    int n2;
    ifs.getline(buf, 1024, '\n');
    if (checkValid(buf, 5)) {
        n2 = atoi(buf);
        if (n2 < 5 || n2>100) return "1111111111";
    }
    else return "1111111111";
    string s1 = "Pink", s2 = "pink";
    for (int i = 0; i < n2; i++) {
        ifs.getline(buf, 1024);
        string s;
        s = buf;
        cntP += numOf_s1_in_S(s, s1);
        cntP += numOf_s1_in_S(s, s2);
    }
    if (cntP <= 9999) cntP = cntP * cntP;
    else;
    if (cntP == 0) return "0999999999";
    while (cntP <= 999999999) {
        cntP = cntP * 10 + 9;
    }
    string result = to_string(cntP);
    return result;
}
//===============
bool isPrime(int n) {
    if (n < 2) return 0;
    else {
        if (n == 2) return 1;
        else {
            for (int i = 2; i <= sqrt(n); i++) {
                if (n % i == 0) return 0;
            }
        }
    }
    return 1;
}
int changeToPrime(int n) {
    if (isPrime(n)) return n;
    else return changeToPrime(n + 1);
}
int changeToFibo(int n) {
    if (n == 1 || n == 0) return 1;
    int i1 = 1, i2 = 1, i3 = i1 + i2;
    while (i3 < n) {
        i1 = i2;
        int tmp;
        tmp = i3;
        i3 = i3 + i2;
        i2 = tmp;
    }
    return i3;
}
string notebook3(string ntb3) {
    fstream ifs(ntb3, ios_base::in);
    char buf[1024];
    int arr[10][10];
    // input data to arr
    for (int row = 0; row < 10; row++) {
        for (int col = 0; col < 10; col++) {
            if (col == 9) ifs.getline(buf, 1024);
            else ifs.getline(buf, 1024, '|');
            arr[row][col] = atoi(buf);
            if (arr[row][col] < 0) arr[row][col] *= -1;
        }
    }
    // change to prime (above)
    for (int row = 0; row < 10; row++) {
        for (int col = row + 1; col < 10; col++) arr[row][col] = changeToPrime(arr[row][col]);
    }
    // chang to Fibo (below)
    for (int row = 9; row >= 0; row--) {
        for (int col = row - 1; col >= 0; col--) arr[row][col] = changeToFibo(arr[row][col]);
    }
    // arrange 3 last eles of each row from lowest to bigest
    for (int row = 0; row < 10; row++) {
        for (int col = 7; col < 9; col++) {
            for (int i = 7; i < 17 - col - 1; i++) {
                if (arr[row][i] > arr[row][i + 1]) {
                    int tmp;
                    tmp = arr[row][i];
                    arr[row][i] = arr[row][i + 1];
                    arr[row][i + 1] = tmp;
                }
            }
        }
    }
    //output result
    int max, index;
    string result = "";
    for (int row = 0; row < 10; row++) {
        max = arr[row][0];
        index = 0;
        for (int col = 0; col < 10; col++) {
            if (arr[row][col] >= max) {
                max = arr[row][col];
                index = col;
            }
        }
        result += to_string(index);
    }
    return result;
}
//=================
string g(string s1, string s2) {
    int plusResult, r = 0;
    string result = "";
    for (int i = 0; i < 10; i++) {
        plusResult = s1[i] + s2[i] - 48 * 2 + r;
        if (plusResult > 9) {
            r = plusResult / 10;
            plusResult = plusResult % 10;
        }
        else r = 0;
        result += to_string(plusResult);
    }
    return result;
}
string generateListPasswords(string pwd1, string pwd2, string pwd3) {
    string result = "";
    result += (pwd1 + ";" + pwd2 + ";" + pwd3 + ";");
    result += g(pwd1, pwd2) + ";" + g(pwd1, pwd3) + ";" + g(pwd2, pwd3) + ";";
    result += g(g(pwd1, pwd2), pwd3) + ";" + g(pwd1, g(pwd2, pwd3)) + ";" + g(g(pwd1, pwd2), g(pwd1, pwd3));
    return result;
}
//mission 2 : chase taxi
bool chaseTaxi(
    int arr[100][100],
    string points,
    string moves,
    string& outTimes,
    string& outCatchUps
) {
    //data of coordinate
    struct coordinates {
        int x;
        int y;
        int time;
    } arrOfCondinates[100 * 100];
    for (int row = 0; row < 100; row++) {
        for (int col = 0; col < 100; col++) arr[row][col] = -9;
    }
    // convert to ' ' cause sstream ignore ' ' => easy to get data
    int len = points.length();
    for (int i = 0; i < len; i++) {
        if (points[i] >= '0' && points[i] <= '9');
        else points[i] = ' ';
    }
    //get data
    stringstream tmp;
    int bufX, bufY;
    tmp << points;
    int numOfCondinates = 0; //index of arr, it's also the num of arrOfCondinates
    while (tmp >> bufX >> bufY) {
        arrOfCondinates[numOfCondinates].x = bufX;
        arrOfCondinates[numOfCondinates].y = bufY;
        numOfCondinates++;
    }
    // get time to the location of taxi
    int row = 0, col = 0;
    arr[0][0] = 0;
    for (int i = 0; i < moves.length(); i++) {
        if (moves[i] == 'U') {
            if (row - 1 < 100 && row - 1 >= 0) {
                arr[row - 1][col] = arr[row][col] + 9;
                row--;
            }
        }
        if (moves[i] == 'D') {
            if (row + 1 < 100 && row + 1 >= 0) {
                arr[row + 1][col] = arr[row][col] + 9;
                row++;
            }
        }
        if (moves[i] == 'R') {
            if (col + 1 < 100 && col + 1 >= 0) {
                arr[row][col + 1] = arr[row][col] + 9;
                col++;
            }
        }
        if (moves[i] == 'L') {
            if (col - 1 < 100 && col - 1 >= 0) {
                arr[row][col - 1] = arr[row][col] + 9;
                col--;
            }
        }
    }
    // time in each point
    int mahattan = 0;
    arrOfCondinates[0].time = 14 * (arrOfCondinates[0].x + arrOfCondinates[0].y);
    for (int i = 1; i < numOfCondinates; i++) {
        mahattan = abs(arrOfCondinates[i].x - arrOfCondinates[i - 1].x) + abs(arrOfCondinates[i].y - arrOfCondinates[i - 1].y);
        arrOfCondinates[i].time = arrOfCondinates[i - 1].time + 14 * mahattan;
    }
    // compare time taxi with time sherloc
    outTimes = "";
    outCatchUps = "";
    bool catchup = false;
    int index;
    for (index = 0; index < numOfCondinates; index++) {
        if (index) {
            outTimes += ";";
            outCatchUps += ";";
        }
        outTimes += to_string(arrOfCondinates[index].time);
        if (arr[arrOfCondinates[index].x][arrOfCondinates[index].y] >= arrOfCondinates[index].time) {
            catchup = true;
            outCatchUps += "Y";
            break;
        }
        else outCatchUps += "N";
    }
    for (index = index + 1; index < numOfCondinates; index++) {
        outTimes += ";-";
        outCatchUps += ";-";
    }
    return catchup;
}
//mision 3
string enterLaptop(string tag, string message) {
    fstream ifs(tag, ios_base::in);
    char buf[1024];
    int n3;
    string email, pwdl = "";
    ifs.getline(buf, 1024, ' ');
    ifs.getline(buf, 1024);
    email = buf;
    ifs.getline(buf, 1024, ' ');
    ifs.getline(buf, 1024, ' ');
    n3 = atoi(buf);
    for (int i = 0; i < n3; i++) {
        pwdl += message;
    }
    return email + ";" + pwdl;
}

////////////////////////////////////////////////
///END OF STUDENT'S ANSWER
////////////////////////////////////////////////
#endif /* studyInPink_h */
