//
//  CalculatorPage.swift
//  CalculatorUITests
//
//  Created by Remya on 16/04/2023.
//

import Foundation
import XCTest

class CalculatorPage: BasePage {
    
    private lazy var pageTitle = app.staticTexts["Calculator App"]
    private lazy var firstValueTextField = app.textFields["first_value"]
    private lazy var secondValueTextField = app.textFields["second_value"]
    private lazy var addButton = app.buttons["add"]
    private lazy var resultText = app.staticTexts["result"]
    
    
    @discardableResult
    func validateTheCalculatorPageIsDisplayed() ->Self{
        waitForElement(element: pageTitle)
        return self
    }
    
    @discardableResult
    func validateTheValueTextFieldsExists() -> Self {
        waitForElement(element: firstValueTextField)
        waitForElement(element: secondValueTextField)
        return self
    }
    
    @discardableResult
    func validateTheAddButtonExists() -> Self {
        waitForElement(element: addButton)
        return self
    }
    
    @discardableResult
    func validateTheResultTextExists() -> Self {
        waitForElement(element: resultText)
        return self
    }
    
    @discardableResult
    func validateThePlaceholderValueForTextFields() -> Self {
        XCTAssertEqual(firstValueTextField.placeholderValue, "Enter value")
        XCTAssertEqual(secondValueTextField.placeholderValue, "Enter value")
        return self
    }
    
    @discardableResult
    func validateAdditionOfTwoNumbers(value1: String, value2: String) -> Self {
        enterValueInTextFieldandtapAddButton(val1: value1, val2: value2)
        let num1 = Int(value1) ?? 0
        let num2 = Int(value2) ?? 0
        let result = num1 + num2
        validateTheResult(expectedResult: String(result))
        return self
    }
    
    @discardableResult
    func enterValueInTextFieldandtapAddButton(val1: String, val2: String) -> Self{
        enterTextInTextFiled(textFieldElement: firstValueTextField, num: val1)
        enterTextInTextFiled(textFieldElement: secondValueTextField, num: val2)
        addButton.tap()
        return self
    }
    
    func enterTextInTextFiled(textFieldElement: XCUIElement, num: String) {
        waitForElement(element: textFieldElement)
        textFieldElement.tap()
        textFieldElement.typeText(num)
    }
    
    func validateTheResult(expectedResult: String){
        waitForElement(element: resultText)
        XCTAssertEqual(resultText.label, expectedResult)
    }
    
    @discardableResult
    func validateMessageForNonInteger() -> Self{
        waitForElement(element: resultText)
        XCTAssertTrue(app.staticTexts["Only integers are allowed"].exists)
        return self
    }
    
    @discardableResult
    func validateMessageForEmptyValueField() -> Self{
        addButton.tap()
        waitForElement(element: resultText)
        XCTAssertTrue(app.staticTexts["One or more fields are empty"].exists)
        return self
    }
}
