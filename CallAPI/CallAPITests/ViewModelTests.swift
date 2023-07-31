//
//  ViewModelTests.swift
//  InstantSystemSwiftUITests
//
//  Created by Guillaume on 22/07/2023.
//

import XCTest
@testable import CallAPI

final class ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGettingUrl_WithSearchNil_ReturnError() {
        // Given
        let viewModel = ViewModel(url: nil, networkSession: MockNetworkSessionNet())
        var actualError = NetworkErrors.noError
        let errorAwaited = NetworkErrors.isNil
        XCTAssertNotEqual(actualError, errorAwaited)
        // When
        viewModel.gettingUrl(search: nil)
        if let error = viewModel.error {
            actualError = error
        }
        // Then
        XCTAssertEqual(actualError, errorAwaited)
    }
    
    func testGettingUrl_WithSearchEmpty_ReturnError() {
        // Given
        let sampleUrl = ""
        let viewModel = ViewModel(url: nil, networkSession: MockNetworkSessionNet())
        var actualError = NetworkErrors.noError
        let errorAwaited = NetworkErrors.empty
        XCTAssertNotEqual(actualError, errorAwaited)
        // When
        viewModel.gettingUrl(search: sampleUrl)
        if let error = viewModel.error {
            actualError = error
        }
        // Then
        XCTAssertEqual(actualError, errorAwaited)
    }
    
    func testGettingUrl_WithSearchCorrect_ReturnCorrectUrl() {
        // Given
        let sampleUrl = "Paris"
        let viewModel = ViewModel(url: nil, networkSession: MockNetworkSessionNet())
        var actualUrl = URL(string: "")
        let urlAwaited = URL(string: "https://newsapi.org/v2/everything?q=Paris&sortBy=popularity&apiKey=10a80a3edbc94a49b406c4f1fe8eaf67")!
        XCTAssertNotEqual(actualUrl, urlAwaited)
        // When
        viewModel.gettingUrl(search: sampleUrl)
        actualUrl = viewModel.url!
        // Then
        XCTAssertEqual(actualUrl, urlAwaited)
    }
    
    func testGetApiData_WithUrlNil_ReturnErrorData() async {
        // Given
        let viewModel = ViewModel(url: nil, networkSession: MockNetworkSessionNet())
        var errorResult:  NetworkErrors?
        let errorAwaited = NetworkErrors.invalidURL
        XCTAssertNotEqual(errorResult, errorAwaited)
        // When
        do {
            try await viewModel.getNews()
        } catch let error {
            errorResult = error as? NetworkErrors
        }
        // Then
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorResult, errorAwaited)
    }
    
    func testGetApiData_WithUrlString_ReturnRightData() async {
        // Given
        let sampleUrl = FakeResponseData.urlForRightData
        let viewModel = ViewModel(url: sampleUrl ,networkSession: MockNetworkSessionNet())
        var errorResult:  NetworkErrors?
        let answerAwaited = "Andrew Tarantola"
        var answer = ""
        XCTAssertNotEqual(answerAwaited, answer)
        // When
        do {
            try await viewModel.getNews()
        } catch let error {
            errorResult = error as? NetworkErrors
        }
        // Then
        XCTAssertNil(errorResult)
        answer = viewModel.articles?[0].author ?? "Rien"
        XCTAssertEqual(answerAwaited, answer)
    }
    
    func testGetApiData_WithUrlString_ReturnBadData() async {
        // Given
        let sampleUrl = FakeResponseData.urlForBadData
        let viewModel = ViewModel(url: sampleUrl ,networkSession: MockNetworkSessionNet())
        var errorResult:  NetworkErrors?
        let errorAwaited = NetworkErrors.decodingError
        XCTAssertNil(errorResult)
        XCTAssertNotEqual(errorAwaited, errorResult)
        // When
        do {
            try await viewModel.getNews()
        } catch let error {
            errorResult = error as? NetworkErrors
        }
        // Then
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorAwaited, errorResult)
    }
    
    func testGetApiData_WithUrlString_ReturnBadResponse() async {
        // Given
        let sampleUrl = URL(string: "BadResponse")!
        let viewModel = ViewModel(url: sampleUrl ,networkSession: MockNetworkSessionNet())
        var errorResult:  NetworkErrors?
        let errorAwaited = NetworkErrors.invalidStatusCode
        XCTAssertNil(errorResult)
        XCTAssertNotEqual(errorAwaited, errorResult)
        // When
        do {
            try await viewModel.getNews()
        } catch let error {
            errorResult = error as? NetworkErrors
        }
        // Then
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorAwaited, errorResult)
    }
}
