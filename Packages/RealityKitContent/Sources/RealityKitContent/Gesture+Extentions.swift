//
//  Gesture+Extentions.swift
//  RealityKitContent
//
//  Created by boardguy.vision on 2025/02/02.
//

import SwiftUI
import RealityKit

//public extension Gesture where Value == EntityTargetValue<AffineTransform3D> {
//    
//    func useGestureComponent() -> some Gesture {
//        onChanged { value in
//            guard let gestureComponent = value.entity.gestureComponent else { return }
//            gestureComponent
//                .onChanged(value: value)
//        }
//        .onEnded { value in
//            guard let gestureComponent = value.entity.gestureComponent else { return }
//            gestureComponent
//                .onEnded(value: value)
//        }
//    }
//}

// SimultaneousGestureは最大2つであるが、このように組み合わせることで拡張できる
extension SimultaneousGesture<SimultaneousGesture<DragGesture, MagnifyGesture>, RotateGesture3D>.Value {
    func components() -> (Vector3D, Size3D, Rotation3D) {
        // param.first.firstが DragGestureなので
        let translation = self.first?.first?.translation3D ?? .zero
        let magnification = self.first?.second?.magnification ?? 1
        let size3D = Size3D(width: magnification, height: magnification, depth: magnification)
        let rotation = self.second?.rotation ?? .identity
        return (translation, size3D, rotation)
    }
}

