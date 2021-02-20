import XCTest
@testable import SwiftyVisuals

final class SwiftyVisualsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftyVisuals().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
