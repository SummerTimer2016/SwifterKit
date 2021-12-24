//
//  UIViewController+Extensions.swift
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
#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties

public extension UIViewController {
    /// SwifterSwift: Check if ViewController is onscreen and not hidden.
    var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return isViewLoaded && view.window != nil
    }
}

// MARK: - Methods

public extension UIViewController {
    /// SwifterSwift: Instantiate UIViewController from storyboard.
    ///
    /// - Parameters:
    ///   - storyboard: Name of the storyboard where the UIViewController is located.
    ///   - bundle: Bundle in which storyboard is located.
    ///   - identifier: UIViewController's storyboard identifier.
    /// - Returns: Custom UIViewController instantiated from storyboard.
    class func instantiate(from storyboard: String = "Main", bundle: Bundle? = nil, identifier: String? = nil) -> Self {
        let viewControllerIdentifier = identifier ?? String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self else {
            preconditionFailure(
                "Unable to instantiate view controller with identifier \(viewControllerIdentifier) as type \(type(of: self))")
        }
        return viewController
    }

    /// SwifterSwift: Assign as listener to notification.
    ///
    /// - Parameters:
    ///   - name: notification name.
    ///   - selector: selector to run with notified.
    func addNotificationObserver(name: Notification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener to notification.
    ///
    /// - Parameter name: notification name.
    func removeNotificationObserver(name: Notification.Name) {
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }

    /// SwifterSwift: Unassign as listener from all notifications.
    func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    /// SwifterSwift: Helper method to display an alert on any UIViewController subclass. Uses UIAlertController to show an alert.
    ///
    /// - Parameters:
    ///   - title: title of the alert.
    ///   - message: message/body of the alert.
    ///   - buttonTitles: (Optional)list of button titles for the alert. Default button i.e "OK" will be shown if this parameter is nil.
    ///   - highlightedButtonIndex: (Optional) index of the button from buttonTitles that should be highlighted. If this parameter is nil no button will be highlighted.
    ///   - completion: (Optional) completion block to be invoked when any one of the buttons is tapped. It passes the index of the tapped button as an argument.
    /// - Returns: UIAlertController object (discardable).
    @discardableResult
    func showAlert(
        title: String?,
        message: String?,
        buttonTitles: [String]? = nil,
        highlightedButtonIndex: Int? = nil,
        completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completion?(index)
            })
            alertController.addAction(action)
            // Check which button to highlight
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }

    /// SwifterSwift: Helper method to add a UIViewController as a childViewController.
    ///
    /// - Parameters:
    ///   - child: the view controller to add as a child.
    ///   - containerView: the containerView for the child viewController's root view.
    func addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    /// SwifterSwift: Helper method to remove a UIViewController from its parent.
    func removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    #if os(iOS)
    /// SwifterSwift: Helper method to present a UIViewController as a popover.
    ///
    /// - Parameters:
    ///   - popoverContent: the view controller to add as a popover.
    ///   - sourcePoint: the point in which to anchor the popover.
    ///   - size: the size of the popover. Default uses the popover preferredContentSize.
    ///   - delegate: the popover's presentationController delegate. Default is nil.
    ///   - animated: Pass true to animate the presentation; otherwise, pass false.
    ///   - completion: The block to execute after the presentation finishes. Default is nil.
    func presentPopover(
        _ popoverContent: UIViewController,
        sourcePoint: CGPoint,
        size: CGSize? = nil,
        delegate: UIPopoverPresentationControllerDelegate? = nil,
        animated: Bool = true,
        completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = delegate
        }

        present(popoverContent, animated: animated, completion: completion)
    }
    #endif
}

// MARK: - UIViewController extension

/// This extesion adds some useful functions to UIViewController.
public extension UIViewController {
    /// Use this in viewWillAppear(_:)
    ///
    /// - Parameter tableView: UITableView to be delected.
    func smoothlyDeselectRows(tableView: UITableView) {
        let selectedIndexPaths = tableView.indexPathsForSelectedRows ?? []
        
        if let coordinator = transitionCoordinator {
            coordinator.animateAlongsideTransition(
                in: parent?.view,
                animation: { coordinatorContext in
                    selectedIndexPaths.forEach {
                        tableView.deselectRow(at: $0, animated: coordinatorContext.isAnimated)
                    }
                }, completion: { coordinatorContext in
                    if coordinatorContext.isCancelled {
                        selectedIndexPaths.forEach {
                            tableView.selectRow(at: $0, animated: false, scrollPosition: .none)
                        }
                    }
                }
            )
        } else {
            selectedIndexPaths.forEach {
                tableView.deselectRow(at: $0, animated: false)
            }
        }
    }
    
    /// Presents a UIAlertController with a title, message and a set of actions.
    ///
    /// - parameter title: The title of the UIAlerController.
    /// - parameter message: An optional String for the UIAlertController's message.
    /// - parameter actions: An array of actions that will be added to the UIAlertController.
    /// - parameter alertType: The style of the UIAlertController.
    func present(title: String, message: String, actions: [UIAlertAction], alertType: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertType)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    /// Sets the tab bar visible or not.
    /// This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time.
    ///
    /// - Parameters:
    ///   - visible: Set if visible.
    ///   - animated: Set if the transition must be animated.
    func setTabBarVisible(_ visible: Bool, animated: Bool, duration: TimeInterval = 0.3) {
        let frame = tabBarController?.tabBar.frame
        
        guard isTabBarVisible() != visible, let height = frame?.size.height else {
            return
        }
        
        let offsetY = (visible ? -height : height)
        
        let duration: TimeInterval = (animated ? duration : 0.0)
        
        if let frame = frame {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
                return
            }
        }
    }
    
    /// Returns if the tab bar is visible.
    ///
    /// - Returns: Returns if the tab bar is visible.
    func isTabBarVisible() -> Bool {
        guard let tabBarOriginY = tabBarController?.tabBar.frame.origin.y else {
            return false
        }
        
        return tabBarOriginY < view.frame.maxY
    }
}
#endif
