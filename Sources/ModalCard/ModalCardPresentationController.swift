//
//  ModalCardPresentationController.swift
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

class ModalCardPresentationController: UIPresentationController {

    private let height: CGFloat

    private let dimmingView: UIView

    init(height: CGFloat, presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, dimWithBlur: Bool = false) {
        self.height = height

        if dimWithBlur {
            dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        }
        else {
            dimmingView = UIView(frame: .zero)
            dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.33)
        }
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: presentingViewController.view.bounds.width, height: height)
        let origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - size.height)
        return CGRect(origin: origin, size: size)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        let superview: UIView! = presentingViewController.view

        dimmingView.frame = superview.bounds
        superview.addSubview(dimmingView)

        dimmingView.alpha = 0
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 1
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 0
        }, completion: { [weak self] context in
            if !context.isCancelled {
                self?.dimmingView.removeFromSuperview()
            }
        })
    }
}

