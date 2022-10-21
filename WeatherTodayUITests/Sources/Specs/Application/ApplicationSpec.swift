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
                    expect(app.staticTexts[defaultHumidityText].exists) == true
                }
            }

            context("when invalid city name entered") {

                beforeEach {
                    let cityNameTextField = app.textFields["Write city name here"]
                    cityNameTextField.tap()
                    cityNameTextField.typeText("A")
                    sleep(1)
                    app.keyboards.buttons["return"].forceTapElement()
                }

                it("should show default temperature and humidity text text") {
                    expect(app.staticTexts[defaultTemperatureText].exists) == true
                    expect(app.staticTexts[defaultHumidityText].exists) == true
                }
            }

            context("when valid city name entered") {

                beforeEach {
                    let cityNameTextField = app.textFields["Write city name here"]
                    cityNameTextField.tap()
                    cityNameTextField.typeText("Dhaka")
                    sleep(1)
                    app.keyboards.buttons["return"].forceTapElement()
                }

                it("should not show temperature and humidity text with value") {
                    expect(app.staticTexts.element(matching: temperaturePredicate).waitForExistence(timeout: 4.0)) == true
                    expect(app.staticTexts.element(matching: humidityPredicate).waitForExistence(timeout: 4.0)) == true
                }
            }
        }
    }
}

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
