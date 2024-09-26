//
//  TapGestureExtension.swift
//  IlaBankTask
//
//  Created by Priyanka on 05/09/24.
//

import UIKit

private var tapGestureCompletionKey: UInt8 = 0

/// Tap Gesture extension
extension UIView {
    func addTapGesture(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    /// Tap gesture extension
    typealias TapGestureCompletion = () -> Void
    
    func addTapGesture(completion: @escaping TapGestureCompletion) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        
        // Store the completion closure as an associated object
        objc_setAssociatedObject(self, &tapGestureCompletionKey, completion, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        // Retrieve the completion closure from the associated object
        if let completion = objc_getAssociatedObject(self, &tapGestureCompletionKey) as? TapGestureCompletion {
            completion()
        }
    }
}
