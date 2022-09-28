//
//  RequestInterceptor.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 27/09/2022.
//

import Foundation

public protocol Interceptor {
    func interceptRequest(_ request: URLRequest)
    
    func interceptResponse(_ data: Data?, response: URLResponse?, error: Error?)
}
