//
//  CalculatorTests.swift
//  CalculatorUITests
//
//  Created by Remya on 16/04/2023.
//

import Foundation

class CalculatorTests: BaseTest {
    
    /* Test to validate all the elements within the Claculator Page */
    func test_ValidateTheFields() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .validateTheValueTextFieldsExists()
            .validateThePlaceholderValueForTextFields()
            .validateTheAddButtonExists()
    }
    
    /* Test to validate the error message displayed when the value field is empty  and add button tapped*/
    func test_validateTheErrorMessageWhenTheValueFieldIsEmpty() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .validateMessageForEmptyValueField()
    }
    
    /* Test to validate the addition of two whole numbers*/
    func test_validateAdditionOfWholeNumbers() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .validateAdditionOfTwoNumbers(value1: "33", value2: "33")
    }
    
    /* Test to validate the addition of two negative numbers*/
    func test_validateAdditionOfNegavtiveNumbers() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .validateAdditionOfTwoNumbers(value1: "-55", value2: "-5")
    }
    
    /* Test to validate the error message displayed upon addition of 2 decimal number*/
    func test_validateTheErrorMessageUponAddingDecimalValue() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .enterValueInTextFieldandtapAddButton(val1: "2.3", val2: "4.4")
            .validateMessageForNonInteger()
    }
    
    /* Test to validate the error message displayed upon addition of 2 Strings/Speacial characters*/
    func test_validateTheErrorMessageUponAddingAStringOrSpecialCharValue() {
        CalculatorPage()
            .validateTheCalculatorPageIsDisplayed()
            .enterValueInTextFieldandtapAddButton(val1: "aa", val2: "&")
            .validateMessageForNonInteger()
    }
    

}
