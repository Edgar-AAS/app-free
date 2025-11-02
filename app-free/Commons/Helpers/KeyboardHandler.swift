//
//  KeyboardHandler.swift
//  app-free
//
//  Created by Lidia on 24/10/25.
//

import UIKit

class KeyboardHandler {

    private weak var scrollView: UIScrollView?
    private weak var view: UIView?
    private var bottomConstraint: NSLayoutConstraint?
    private var originalContentOffset: CGPoint?
    private let extraSpacing: CGFloat = 20
 
    init(scrollView: UIScrollView, bottomConstraint: NSLayoutConstraint? = nil) {
        self.scrollView = scrollView
        self.view = scrollView.superview
        self.bottomConstraint = bottomConstraint
        setupObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let scrollView = scrollView else { return }
       
        if originalContentOffset == nil {
            originalContentOffset = scrollView.contentOffset
        }

        adjustForKeyboard(notification: notification, showing: true)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let scrollView = scrollView else { return }

        adjustForKeyboard(notification: notification, showing: false)
        
        if let offset = originalContentOffset {
            UIView.animate(withDuration: 0.25) {
                scrollView.setContentOffset(offset, animated: false)
            }
            originalContentOffset = nil
        }
    }
   

    private func adjustForKeyboard(notification: Notification, showing: Bool) {
        guard let view = view,
              let scrollView = scrollView,
              let userInfo = notification.userInfo,
              let kbFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let kbFrame = kbFrameValue.cgRectValue
        let kbHeight = showing ? kbFrame.height : 0
       
        if let bottomConstraint = bottomConstraint {
            bottomConstraint.constant = -(kbHeight + extraSpacing)
        } else {
            let insetBottom = kbHeight + extraSpacing
            scrollView.contentInset.bottom = insetBottom
            scrollView.verticalScrollIndicatorInsets.bottom = insetBottom
        }
      
        let curve = UIView.AnimationOptions(rawValue: curveRaw << 16)
        UIView.animate(withDuration: duration, delay: 0, options: [curve, .beginFromCurrentState]) {
            view.layoutIfNeeded()
        }
    }
}
