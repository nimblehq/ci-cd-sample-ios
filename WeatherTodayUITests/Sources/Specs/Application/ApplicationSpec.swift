import Nimble
import Quick

final class ApplicationSpec: QuickSpec {

    override func spec() {

        var app: XCUIApplication!
        let defaultTemperatureText = "Temperature _ ℃"
        let defaultHumidityText = "Humidity _ %"
        let floatRegex = "[0-9]+.[0-9]+"
        let temperaturePredicate = NSPredicate(format: "label MATCHES 'Temperature \(floatRegex) ℃'")
        let humidityPredicate = NSPredicate(format: "label MATCHES 'Humidity \(floatRegex) %'")

        describe("a WeatherToday app") {

            beforeEach {
                app = XCUIApplication()
                app.launch()
            }

            afterEach {
                app.terminate()
            }

            context("when no city name entered") {

                it("should show default temperature text") {
                    expect(app.staticTexts[defaultTemperatureText].exists) == true
                }

                it("should show default humidity text") {
                    expect(app.staticTexts[defaultHumidityText].exists) == true
                }
            }

            describe("city name entered") {

                context("when invalid city name entered") {

                    beforeEach {
                        let cityNameTextField = app.textFields["Write city name here"]
                        cityNameTextField.tap()
                        cityNameTextField.typeText("A")
                        app.keyboards.buttons["return"].tap()
                    }

                    it("should show default temperature text") {
                        expect(app.staticTexts[defaultTemperatureText].exists) == true
                    }
                }

                context("when valid city name entered") {

                    beforeEach {
                        let cityNameTextField = app.textFields["Write city name here"]
                        cityNameTextField.tap()
                        cityNameTextField.typeText("Dhaka")
                        app.keyboards.buttons["return"].tap()
                    }

                    it("should not show temperature text with value") {
                        expect(app.staticTexts.element(matching: temperaturePredicate).waitForExistence(timeout: 4.0)) == true
                    }

                    it("should show humidity text with value") {
                        expect(app.staticTexts.element(matching: humidityPredicate).waitForExistence(timeout: 4.0)) == true
                    }
                }
            }
        }
    }
}
