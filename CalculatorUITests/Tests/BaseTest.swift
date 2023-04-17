//
//  BaseTest.swift
//  CalculatorUITests
//
//  Created by remya on 16/04/2023.
//

import Foundation
import XCTest

open class BaseTest: XCTestCase {
    
    private var basePage = BasePage()
    lazy var app = basePage.app
    
    open override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    open override func tearDown() {
        app.terminate()
    }
}
