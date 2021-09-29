//
//  Data+Extensions.swift
//  BFKit-Swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 - 2019 Fabrizio Brancati.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
#if canImport(Foundation)
import Foundation


// MARK: - Properties
/// This extension add some useful functions to Data.
public extension Data {
    /// SwifterSwift: Return data as an array of bytes.
    var bytes: [UInt8] {
        // http://stackoverflow.com/questions/38097710/swift-3-changes-for-getbytes-method
        return [UInt8](self)
    }
}

// MARK: - Methods
public extension Data {
    // MARK: - Functions
    /// Convert self to a UTF8 String.
    ///
    /// - Returns: Returns self as UTF8 NSString.
    func utf8() -> String? {
        String(data: self, encoding: .utf8)
    }
    
    /// Convert self to a ASCII String.
    ///
    /// - Returns: Returns self as ASCII String.
    func ascii() -> String? {
        String(data: self, encoding: .ascii)
    }
    
    /// Convert self UUID to String.
    ///
    /// Useful for push notifications.
    ///
    /// - Returns: Returns self as String from UUID.
    func readableUUID() -> String {
        description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
    /// SwifterSwift: String by encoding Data using the given encoding (if applicable).
    ///
    /// - Parameter encoding: encoding.
    /// - Returns: String by encoding Data using the given encoding (if applicable).
    func string(encoding: String.Encoding) -> String? {
        return String(data: self, encoding: encoding)
    }

    /// SwifterSwift: Returns a Foundation object from given JSON data.
    ///
    /// - Parameter options: Options for reading the JSON data and creating the Foundation object.
    ///
    ///   For possible values, see `JSONSerialization.ReadingOptions`.
    /// - Throws: An `NSError` if the receiver does not represent a valid JSON object.
    /// - Returns: A Foundation object from the JSON data in the receiver, or `nil` if an error occurs.
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: self, options: options)
    }
}

#endif
