import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(multipart_kit_issueTests.allTests),
    ]
}
#endif
