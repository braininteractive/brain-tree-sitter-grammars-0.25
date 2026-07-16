import XCTest
import SwiftTreeSitter
import TreeSitterJSP

final class TreeSitterJSPTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_jsp())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading JSP grammar")
    }
}
