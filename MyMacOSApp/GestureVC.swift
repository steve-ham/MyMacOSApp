//
//  GestureVC.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2021/01/04.
//

import Cocoa

class GestureVC: NSViewController {

    @IBOutlet private weak var customView: NSView! {
        didSet {
            customView.wantsLayer = true
            customView.layer?.backgroundColor = NSColor.red.cgColor
        }
    }
    
    @IBAction private func clickView(_ click: NSClickGestureRecognizer) {
        click.view?.layer?.backgroundColor = NSColor.randomColor().cgColor
    }
    
    @IBAction private func panView(_ panGestureRecognizer: NSPanGestureRecognizer) {
        let contentView = view.window?.contentView
        let translation = panGestureRecognizer.translation(in: contentView)
        panGestureRecognizer.view!.frame = NSOffsetRect(panGestureRecognizer.view!.frame, translation.x, translation.y)
        panGestureRecognizer.setTranslation(NSZeroPoint, in: nil)
    }
    
    @IBAction private func rotateView(_ rotationGestureRecognizer: NSRotationGestureRecognizer) {
        let rotation = rotationGestureRecognizer.rotation
        let view = rotationGestureRecognizer.view!
        view.layer?.setAffineTransform(view.layer!.affineTransform().rotated(by: rotation))
        rotationGestureRecognizer.rotation = 0
    }
    
    @IBAction private func magnifyView(_ magnificationGestureRecognizer: NSMagnificationGestureRecognizer) {
        let magnification = magnificationGestureRecognizer.magnification + 1.0
        let view = magnificationGestureRecognizer.view!
        view.layer?.setAffineTransform(view.layer!.affineTransform().scaledBy(x: magnification, y: magnification))
        magnificationGestureRecognizer.magnification = 0
    }
}

extension NSColor {
    class func randomColor() -> NSColor {
        let r = CGFloat(drand48())
        let g = CGFloat(drand48())
        let b = CGFloat(drand48())
        return NSColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
