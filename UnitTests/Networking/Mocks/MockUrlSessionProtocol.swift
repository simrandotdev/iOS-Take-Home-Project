//
//  MockUrlSessionProtocol.swift
//  UnitTests
//
//  Created by Simran Preet Narang on 2022-09-27.
//

import XCTest

class MockUrlSessionProtocol: URLProtocol {

    static var loadingHander: ( () -> (HTTPURLResponse, Data?) )?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockUrlSessionProtocol.loadingHander else {
            XCTFail("Loading handler is not set")
            return
        }
        
        let (response, data) = handler()
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        if let data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }

    
    override func stopLoading() {
        
    }
}
