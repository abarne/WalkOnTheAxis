import UIKit
import Foundation
/*
 Walk on the Axis:
 There are N+1 lights. Lights are placed at (0, 0), (1, 0), (2, 0) ... (N, 0). Initially all the lights are on. You want to turn off all of them one after one. You want to follow a special pattern in turning off the lights.
 You will start at (0, 0).First, you walk to the right most light that is on, turn it off. Then you walk to the left most light that is on, turn it off. Then again to the right most light that is on and so on. You will stop after turning off all lights. You want to know how much distance you walked in the process. Note that distance between (a,0) and (b,0) is |a-b|.
 Input
 The first line of the input contains an integer T denoting the number of test cases. Each test case has a single integer N on separate line.

 Output
 For each test case, output the distance you walked.
 Constraints
 · 1 ≤ T ≤ 10^5
 · 1 ≤ N ≤ 10^5

 Sample 1:
 Input:
 2
 1
 2

 Output:
 2
 5
 */

func distanceWalked(_ N : Int) -> Int {
    var distance = 0
    var arr : [Int] = []
    var left = false
    
    //create an array from 0...N
    for i in 0...N {
        arr.append(i)
    }
    
    //while alternating which lights to turn off, keep total distance traveled

    while arr.count > 0 {
        distance += abs(arr[0] - arr[arr.count-1])
        if left {
            arr.remove(at: 0)
        }else {
            arr.remove(at: arr.count - 1)
        }
        left.toggle()
    }
    
    return distance + N
}

print(distanceWalked(2)) //prints 5


func recursiveDistanceWalked(_ N : Int, _ flag: Bool = true) -> Int {
    if flag {
        return N + N + recursiveDistanceWalked(N-1, false)
    }
    if N == 0 {
        return N
    }
    return N + recursiveDistanceWalked(N-1, false)
}

print(recursiveDistanceWalked(2)) //prints 5


//Simple formula for distance travelled for N+1 number of lights, is
// N + N + (N-1) + (N-2)+ ... + 0
func simpleLoopDistanceWalked(_ N : Int) -> Int {
    var distance = N
    for i in 0...N {
        distance += i
    }
    return distance
}

print(simpleLoopDistanceWalked(2)) //print 5


//********************************************************************************************
//********************************************************************************************
/*
 Your Name is Mine
 
 In an attempt to control the rise in population, Archer was asked to come up with a plan. This time he is targeting marriages. Archer, being as intelligent as he is, came up with the following plan:
 A man with name M is allowed to marry a woman with name W, only if M is a subsequence of W or W is a subsequence of M.
 A is said to be a subsequence of B, if A can be obtained by deleting some elements of B without changing the order of the remaining elements.
 Your task is to determine whether a couple is allowed to marry or not, according to Archer's rule.
 Input
 The first line contains an integer T, the number of test cases. T test cases follow. Each test case contains two space separated strings M and W.
 Output
 For each test case print "YES" if they are allowed to marry, else print "NO".(quotes are meant for clarity, please don't print them)
 */


func yourNameIsMine(_ T : Int,_ names: [String]) {
    for (_, v) in names.enumerated(){
        let names = v.split(separator: " ")
        let name1 = String(names[0])
        let name2 = String(names[1])
        let pattern1 = createRegexPattern(name1)
        let pattern2 = createRegexPattern(name2)
        if useRegex(for: name1, pattern2) || useRegex(for: name2, pattern1) {
            print("YES")
        }else{
            print("NO")
        }
        
    }
    
}

func createRegexPattern(_ str : String) -> String {
    var pattern = ""
    
    for (offset, character) in str.enumerated() {
        if offset != 0 {
            pattern.append(".*")
        }
        pattern.append(character)
    }
   // print(pattern)
    return pattern
}


func useRegex(for text: String, _ pat : String) -> Bool {
    let regex = try! NSRegularExpression(pattern: pat, options: [.caseInsensitive])
    let range = NSRange(location: 0, length: text.count)
    let matches = regex.matches(in: text, options: [], range: range)
    return matches.first != nil
}


yourNameIsMine(3, ["john Johanna", "ira ira", "kayla Jayla"]) //Prints YES YES NO
