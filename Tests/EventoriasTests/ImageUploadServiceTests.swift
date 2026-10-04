//
//  ImageUploadServiceTests.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 18/09/2025.
//

import XCTest
import UIKit
@testable import Eventorias

final class ImageUploadServiceTests: XCTestCase {
    var service: ImageUploadService!

    override func setUp() {
        super.setUp()
        service = ImageUploadService(apiKey: "FAKE_KEY")
    }

    func testInvalidImage() {
        let emptyImage = UIImage()
        let expectation = XCTestExpectation(description: "Upload should fail with invalid image")

        service.uploadImage(emptyImage) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error as? ImageUploadError, .invalidImage)
            case .success:
                XCTFail("Upload should not succeed with invalid image")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testUploadFailed() {
        let testImage = UIImage(systemName: "star.fill")!
        let expectation = XCTestExpectation(description: "Upload should fail with invalid response")

        URLProtocolMock.testData = Data("invalid json".utf8)
        URLProtocolMock.testError = nil
        URLProtocol.registerClass(URLProtocolMock.self)

        service.uploadImage(testImage) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error as? ImageUploadError, .uploadFailed)
            case .success:
                XCTFail("Upload should fail with invalid response")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        URLProtocol.unregisterClass(URLProtocolMock.self)
    }

    func testUploadSuccess() {
        let testImage = UIImage(systemName: "star.fill")!
        let expectation = XCTestExpectation(description: "Upload should succeed")

        let fakeURL = "https://example.com/image.jpg"
        let json: [String: Any] = ["data": ["url": fakeURL]]
        URLProtocolMock.testData = try! JSONSerialization.data(withJSONObject: json)
        URLProtocolMock.testError = nil
        URLProtocol.registerClass(URLProtocolMock.self)

        service.uploadImage(testImage) { result in
            switch result {
            case .success(let url):
                XCTAssertEqual(url, fakeURL)
            case .failure:
                XCTFail("Upload should succeed")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
        URLProtocol.unregisterClass(URLProtocolMock.self)
    }
}
