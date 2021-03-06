//
//  UIBarButtonItem+Extensions.swift
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

import Foundation
import UIKit

// MARK: - UIBarButtonItem extension

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties

public extension UIBarButtonItem {
    /// SwifterSwift: Creates a flexible space UIBarButtonItem.
    static var flexibleSpace: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}

// MARK: - Methods

public extension UIBarButtonItem {
    // MARK: - Functions

    /// Create an UIBarButtonItem with type setted to FlexibleSpace or FixedSpace.
    ///
    /// - Parameters:
    ///   - space: Must be FlexibleSpace or FixedSpace, otherwise a FlexibleSpace UIBarButtonItem will be created.
    ///   - width: To use only if space is setted to FixedSpace, and it will be the width of it.
    convenience init(barButtonSpaceType space: UIBarButtonItem.SystemItem, width: CGFloat = 0.0) {
        if space == .fixedSpace || space == .flexibleSpace {
            self.init(barButtonSystemItem: space, target: nil, action: nil)
            
            if space == .fixedSpace {
                self.width = width
            }
        } else {
            self.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        }
    }
    /// SwifterSwift: Add Target to UIBarButtonItem.
    ///
    /// - Parameters:
    ///   - target: target.
    ///   - action: selector to run when button is tapped.
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }

    /// SwifterSwift: Creates a fixed space UIBarButtonItem with a specific width.
    ///
    /// - Parameter width: Width of the UIBarButtonItem.
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
}

#endif
