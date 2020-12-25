//
//  mlTests.swift
//  mlTests
//
//  Created by mac_25648_newMini on 2020/12/17.
//

import XCTest

struct Person {
    let sex:Bool
    let age:Int64
}

struct Person2 {
    let sex:Bool
    let age:Int64
}

class mlTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let size = MemoryLayout<Bool>.size
        let stride = MemoryLayout<Bool>.stride
        let alignment = MemoryLayout<Bool>.alignment
        print(size)
    }
    
    func teststruct(){
        let size = MemoryLayout<Person>.size
        let stride = MemoryLayout<Person>.stride
        let alignment = MemoryLayout<Person>.alignment
        print(size)
    }
    
    func teststruct2(){
        var person = Person(sex: true, age: 11)
        let person2 = person
//        let address = person.headPointerOfStruct()
//        let v2 = Unmanaged<Person>.passUnretained(person).toOpaque()
        print(person)
    }
    
    func teststruct3(){
        var person = Person(sex: true, age: 11)
        let rawPointer = UnsafeMutableRawPointer.allocate(byteCount:MemoryLayout<Person2>.stride, alignment: MemoryLayout<Person2>.alignment)
        let personPointer =  withUnsafeMutablePointer(to: &person) {
            return UnsafeMutableRawPointer($0).bindMemory(to: Int8.self, capacity: MemoryLayout<Self>.stride)}
        rawPointer.copyMemory(from: personPointer, byteCount: MemoryLayout<Person2>.stride)
        let person2 = rawPointer.load(as: Person2.self)
        
        XCTAssertTrue(person.sex == person2.sex && person.age == person2.age)
        //pass
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
