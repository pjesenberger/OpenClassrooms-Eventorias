//
//  URLProtocolMock.swift
//  EventoriasTests
//
//  Created by Pascal Jesenberger on 15/09/2025.
//

import XCTest
@testable import Eventorias

class URLProtocolMock: URLProtocol {
    static var testData: Data?
    static var testError: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        if let error = Self.testError {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocol(self, didLoad: Self.testData ?? Data())
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    override func stopLoading() {}
}
