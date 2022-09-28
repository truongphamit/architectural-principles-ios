//
//  LoggingInterceptor.swift
//  ArchitecturalPrinciples
//
//  Created by Truong Pham on 27/09/2022.
//

import Foundation

class LoggingInterceptor: Interceptor {
    func interceptRequest(_ request: URLRequest) {
        var array: [String] = []
        
        if let method = request.httpMethod,
           let url = request.url?.absoluteString {
            array.append(Output.request(method: method, url: url).value)
        }
        
        if let dict = request.allHTTPHeaderFields, !dict.isEmpty {
            array.append(Output.headers(dict).value)
        }
        
        if let data = request.httpBody,
           let string = String(json: data), !string.isEmpty {
            array.append(Output.body(string).value)
        }
        
        
        print(array.joined(separator: "\n"))
    }
    
    func interceptResponse(_ data: Data?, response: URLResponse?, error: Error?) {
        guard let urlResponse = response as? HTTPURLResponse,
              let url = urlResponse.url?.absoluteString
        else { return }
        
        var array: [String] = []
        
        array.append(
            Output.response(code: urlResponse.statusCode, url: url).value
        )
        
        if let data = data {
            if let string = String(json: data), !string.isEmpty {
                array.append(Output.body(string).value)
            }
        }
        
        
        print(array.joined(separator: "\n"))
    }
    
    
}

public enum Output {
    case request(method: String, url: String)
    case response(code: Int, url: String)
    case headers([String : String])
    case body(String)
    case failure(URLError)
    
    var value: String {
        switch self {
        case .request(let method, let url):
            return "\n" + "🚀" + "\(method) ".tabbed + url
            
        case .headers(let dict):
            var lines: [String] = []
            for (key, value) in dict {
                lines.append("\(key) : \(value)".tabbed)
            }
            return lines.joined(separator: "\n")
            
        case .response(let code, let url):
            return ((200...299).contains(code) ? "✅" : "⛔️") + "\(code) ".tabbed + url
            
        case .body(let body):
            return body.replacingOccurrences(of: "\n", with: "\n\t").tabbed
            
        case .failure(let error):
            var lines: [String] = []
            lines.append("⛔️" + "\(error.errorCode) \(error.failureURLString ?? "")".tabbed)
            lines.append(error.localizedDescription.tabbed)
            return lines.joined(separator: "\n")
        }
    }
}

extension String {
    var tabbed: String {
        "\t" + self
    }
}

extension Data {
    init?(stream: InputStream) {
        self.init()
        
        stream.open()
        
        let bufferSize: Int = 8
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        while stream.hasBytesAvailable {
            let readB = stream.read(buffer, maxLength: bufferSize)
            if let error = stream.streamError {
                print("input stream error", error)
                return nil
            }
            append(buffer, count: readB)
        }
        
        buffer.deallocate()
        stream.close()
    }
}

extension String {
    init?(json: Data) {
        do {
            /// json encoded
            let object = try JSONSerialization.jsonObject(with: json, options: [])
            let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
            self.init(data: data, encoding: .utf8)
        } catch {
            /// url encoded
            print("decoding json error", error)
            self.init(data: json, encoding: .utf8)
        }
    }
}
