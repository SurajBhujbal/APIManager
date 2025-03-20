import XCTest
@testable import APIManager

final class APIManagerTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    func testGetApi(){
        let exception = XCTestExpectation(description: "Fetch User Data")
        
        let apiExaple = APIManagerExample()
        apiExaple.getData()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            exception.fulfill()
        }
        wait(for: [exception], timeout: 5)
    }
    
    func testPostApi(){
        let execption = XCTestExpectation(description: "Post User Data")
        
        let apiExample = APIManagerExample()
        apiExample.postData()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2){
            execption.fulfill()
        }
        wait(for: [execption],timeout: 5)
    }
    
}
