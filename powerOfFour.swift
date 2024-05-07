
//  powerOfFour.swift
//
//  Created by Spencer Scarlett
//  Created on 2024-05-06
//  Version 1.0
//  Copyright (c) Spencer Scarlett. All rights reserved.
//
//  Assignment power of four + max number


import Foundation

// input and output file paths
let inputFile = "input.txt"
let outputFile = "output.txt"

do {
    // open input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // open output file for writing
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }

    // read content from input file
    let inputData = input.readDataToEndOfFile()

    // convert input data to string
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }

    // split input string into lines
    let lines = inputString.components(separatedBy: .newlines)
    var intArray = [Int]()
    var outputString = ""

    // process each line from input
    for line in lines {
        // check if line is a valid integer
        if let intValue = Int(line) { 
        // add integer to array
            intArray.append(intValue)
            // check if integer is power of four
            let result = isPowerOfFour(intValue)
            if result == 1 {
                 // power of four, base case
                outputString += "\(intValue) is a power of four.\n"
            } else if result == 0 {
                // not power of four, anyone else really
                outputString += "\(intValue) is not a power of four.\n"
            } else {
                // invalid input, for 0 inputs mainly
                outputString += "\(intValue) is not a power of four and is an invalid input.\n"
            }
        } else {
             // not a valid integer
            outputString += "\(line) is not a valid integer.\n"
        }
    }

    // check if any valid integers were found
    if !intArray.isEmpty {
        // find maximum value
        let max = findMax(intArray, intArray.count, 0)
        // output maximum value
        outputString += "Maximum value from input file: \(max)\n"
    } else {
        // no valid integers found
        outputString += "No valid integers found in the input file.\n"
    }

    // write output string to output file
    output.write(Data(outputString.utf8))
    // closing input and output files
    input.closeFile()
    output.closeFile()
    // done message
    print("Done program")

} catch {
    // catch and print any errors
    print("An error occurred: \(error)") 
}

// function to check if a number is a power of four
func isPowerOfFour(_ n: Int) -> Int {
    // if input is non-positive, return -1
    if n <= 0 { return -1 }
    // base case: 1 is a power of four
    if n == 1 { return 1 }
    // if not divisible by 4, not a power of four
    if n % 4 != 0 { return 0 }
    // recursively check next quotient
    return isPowerOfFour(n / 4)
}

// function to find the maximum value in an array
func findMax(_ arr: [Int], _ size: Int, _ index: Int) -> Int {
    // base case last element
    if index == size - 1 { return arr[index] }
    // find max in rest of array
    let maxRest = findMax(arr, size, index + 1)
    // compare current element with max of rest
    return max(arr[index], maxRest)
}