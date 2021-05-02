import XCTest
@testable import SwiftyVisuals

final class SwiftyVisualsTests: XCTestCase {
    func referenceTest() {
        let original = Reference(["Audi", "Mercedes"])
        var copy = Reference(["Alfa Romeo"])
        
        XCTAssertNotEqual(original.wrappedValue, copy.wrappedValue)
        
        copy = original
        copy.wrappedValue.append("Porsche")
        
        XCTAssertEqual(original.wrappedValue, copy.wrappedValue)
    }

    static var allTests = [
        ("referenceTest", referenceTest),
    ]
}
