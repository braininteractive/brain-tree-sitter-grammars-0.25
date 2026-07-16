import XCTest
import SwiftTreeSitter
import TreeSitterFreemarker

final class TreeSitterFreemarkerTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_freemarker())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Freemarker grammar")
    }
}
