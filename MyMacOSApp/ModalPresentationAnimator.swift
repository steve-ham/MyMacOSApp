//
//  ModalPresentationAnimator.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

private class DimView: NSView {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor(white: 0, alpha: 0.5).cgColor
        alphaValue = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ModalPresentationAnimator: NSObject, NSViewControllerPresentationAnimator {
    private let dimView = DimView(frame: .zero)
    private var centerYConstraint: NSLayoutConstraint!
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        fromViewController.view.addSubview(dimView)
        dimView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([dimView.topAnchor.constraint(equalTo: fromViewController.view.topAnchor),
                                     dimView.rightAnchor.constraint(equalTo: fromViewController.view.rightAnchor),
                                     dimView.bottomAnchor.constraint(equalTo: fromViewController.view.bottomAnchor),
                                     dimView.leftAnchor.constraint(equalTo: fromViewController.view.leftAnchor)])
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        centerYConstraint = viewController.view.centerYAnchor.constraint(equalTo: dimView.centerYAnchor, constant: 100) // Lowering view
        dimView.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.centerXAnchor.constraint(equalTo: dimView.centerXAnchor),
            centerYConstraint,
            viewController.view.widthAnchor.constraint(equalTo: dimView.widthAnchor, constant: -100),
            viewController.view.heightAnchor.constraint(equalTo: dimView.heightAnchor, constant: -100)
        ])
        
        NSAnimationContext.runAnimationGroup({ context in // Going towards alpha = 1; Y constraint constant 0
            context.duration = 0.5
            self.dimView.animator().alphaValue = 1
            self.centerYConstraint.animator().constant = 0
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        NSAnimationContext.runAnimationGroup({ _ in
            self.dimView.animator().alphaValue = 0
            self.centerYConstraint.animator().constant = 100
        }, completionHandler: {
            self.dimView.removeFromSuperview()
        })
    }
}
