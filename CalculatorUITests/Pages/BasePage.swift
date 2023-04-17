//
//  BasePage.swift
//  CalculatorUITests
//
//  Created by Remya on 16/04/2023.
//

import Foundation
import XCTest

class BasePage: XCTestCase {
    
    public let app = XCUIApplication()
    
    func waitForElement(element: XCUIElement, timeout: TimeInterval = 5){
        let exists = NSPredicate(format: "exists == true AND hittable == true AND enabled == true")
        self.expectation(for: exists, evaluatedWith: element, handler: nil)
        self.waitForExpectations(timeout: timeout, handler: nil)
        XCTAssert(element.exists)
    }
}
