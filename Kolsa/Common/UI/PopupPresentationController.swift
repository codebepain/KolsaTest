//
//  PopupPresentationController.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import UIKit

class PopupPresentationController: UIPresentationController {

    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView, let presentedView else { return .zero }
        
        let preferredSize = presentedView.systemLayoutSizeFitting(
            CGSize(
                width: containerView.bounds.width - 40,
                height: UIView.layoutFittingCompressedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return CGRect(
            x: (containerView.bounds.width - preferredSize.width) / 2,
            y: containerView.bounds.height - preferredSize.height - containerView.safeAreaInsets.bottom - 20,
            width: preferredSize.width,
            height: preferredSize.height
        )
    }

    override func presentationTransitionWillBegin() {
        guard let containerView, let presentedView else { return }
        
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipe.direction = .down
        presentedView.addGestureRecognizer(swipe)
        
        presentedView.layer.cornerRadius = 20
        presentedView.layer.masksToBounds = true
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    @objc private func handleTap() {
        presentedViewController.dismiss(animated: true)
    }
    
    @objc private func handleSwipe() {
        presentedViewController.dismiss(animated: true)
    }
}
