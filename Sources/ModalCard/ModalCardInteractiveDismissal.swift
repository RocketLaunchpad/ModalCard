//
//  ModalCardInteractiveDismissal.swift
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

class ModalCardInteractiveDismissal: UIPercentDrivenInteractiveTransition {

    unowned var viewController: UIViewController

    private let dismissThreshold: CGFloat

    init(viewController: UIViewController, dismissThreshold: CGFloat) {
        self.viewController = viewController
        self.dismissThreshold = dismissThreshold
        super.init()

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(recognizer:)))
        viewController.view.addGestureRecognizer(gesture)
    }

    @objc private func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: viewController.view)
        let dyPct = translation.y / viewController.view.bounds.height

        switch recognizer.state {
        case .began:
            viewController.dismiss(animated: true)

        case .changed:
            update(dyPct)

        case .ended:
            if dyPct > dismissThreshold {
                finish()
            }
            else {
                cancel()
            }

        case .cancelled:
            cancel()

        default:
            cancel()
        }
    }
}
