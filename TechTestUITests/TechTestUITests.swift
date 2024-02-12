//
//  TechTestUITests.swift
//  TechTestUITests
//
//  Created by Matthew Gallagher on 12/02/2024.
//

import XCTest

final class TechTestUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSchedule() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockData"]
        app.launch()
        
        takeScreenshot()

        let slot = app.buttons["98EF4AC4-6C9A-4240-B9D5-DFA513267413"]
        XCTAssertTrue(slot.exists)

        let titleLabel = slot.staticTexts["Registration & Breakfast"]
        XCTAssertTrue(titleLabel.exists)

        let subtitleLabel = slot.staticTexts["Time to check in 🎟"]
        XCTAssertTrue(subtitleLabel.exists)
    }

    func testSlotDetails() throws {
        let app = XCUIApplication()
        app.launchArguments = ["MockData"]
        app.launch()

        let firstSession = app.buttons["98EF4AC4-6C9A-4240-B9D5-DFA513267413"]
        firstSession.tap()

        takeScreenshot()

        let titleField = app.staticTexts["title"]
        let subtitleField = app.staticTexts["subtitle"]
        let detailsField = app.staticTexts["details"]
        
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        XCTAssertTrue(subtitleField.waitForExistence(timeout: 2))
        XCTAssertTrue(detailsField.waitForExistence(timeout: 2))
    }

    private func takeScreenshot() {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
