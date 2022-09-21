import XCTest

final class CarMarketCarsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //MARK: - UI test scenery
        
        let startButton = app.buttons["Get Started"]
        XCTAssertTrue(startButton.exists, "Button with name: <Get Started> not found!")
        startButton.tap()

        let usernameField = app.textFields["userEmail"]
        XCTAssertTrue(usernameField.exists, "Textfield with name: <Enter Your Email> not found!")
        usernameField.tap()
        usernameField.typeText("m@gmail.com")
        
        let welcomeLbl = app.staticTexts["Welcome Back !"]
        XCTAssertTrue(welcomeLbl.exists)
        welcomeLbl.tap()

        let userPasswordField = app.secureTextFields["userPassword"]
        XCTAssertTrue(userPasswordField.exists, "Textfield with name: <Enter Your Password> not found!")
        userPasswordField.tap()
        userPasswordField.typeText("Refera123")
        
        welcomeLbl.tap()

        let signInButton = app.buttons.matching(identifier: "Sign In").staticTexts["Sign In"]
        XCTAssertTrue(signInButton.exists, "Button with name: <Sign In> not found!")
        signInButton.tap()
        
        let userLbl = app.staticTexts["User:"]
        XCTAssertTrue(userLbl.waitForExistence(timeout: 5))

    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

