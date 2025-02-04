//
//  AffineTransform3D+Extensions.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/02/02.
//

import SwiftUI

public extension AffineTransform3D {
    func updated(with value: AffineTransform3D,
                 canDrag: Bool = true,
                 canScale: Bool = true,
                 canRotate: Bool = true) -> AffineTransform3D {
        
        var newTransform: AffineTransform3D = .identity
        
        if canDrag {
            newTransform.translation = self.translation + value.translation
        } else {
            newTransform.translation = self.translation
        }
        
        if canScale {
            let newScale = self.scale.scaled(by: value.scale)
            newTransform.scale(by: newScale)
        }
        
        if canRotate {
            if let rotation = value.rotation, let newRotation = self.rotation?.rotated(by: rotation) {
                newTransform.rotate(by: newRotation)
            }
        }
        
        return newTransform
    }
}
