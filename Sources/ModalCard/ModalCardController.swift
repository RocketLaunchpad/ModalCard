//
//  ModalCardViewController.swift
//  ModalCard
//
//  Copyright (c) 2020 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import UIKit

public class ModalCardController: NSObject, UIViewControllerTransitioningDelegate {

    let modalHeight: CGFloat

    private unowned let parent: UIViewController

    private let dismissPanGesturePercentageThreshold: CGFloat

    private let dismissTransition: UIPercentDrivenInteractiveTransition

    private var programmaticDismissal = false

    public init(parent: UIViewController,
                modalHeight: CGFloat,
                dismissPanGesturePercentageThreshold: CGFloat = 0.33,
                cornerRadius: CGFloat = 15,
                roundedCorners: UIRectCorner = [.topLeft, .topRight]) {

        self.parent = parent
        self.modalHeight = modalHeight
        self.dismissPanGesturePercentageThreshold = dismissPanGesturePercentageThreshold
        self.dismissTransition = ModalCardInteractiveDismissal(viewController: parent, dismissThreshold: dismissPanGesturePercentageThreshold)

        super.init()

        let path = UIBezierPath(roundedRect: parent.view.bounds, byRoundingCorners: roundedCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        parent.view.layer.mask = mask

        parent.modalPresentationStyle = .custom
        parent.transitioningDelegate = self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalCardDismissAnimator(height: modalHeight)
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalCardPresentationController(height: modalHeight, presentedViewController: presented, presenting: presenting)
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return programmaticDismissal ? nil : dismissTransition
    }

    public func dismissModal(animated: Bool, completion: (() -> Void)? = nil) {
        programmaticDismissal = true
        parent.dismiss(animated: animated) { [weak self] in
            self?.programmaticDismissal = false
            completion?()
        }
    }
}
