//
//  ViewModifiers.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/28.
//

import SwiftUI

extension View {
    func keepManipulationForModel3D() -> some View {
        self.modifier(KeepManipulationModifier())
    }
}

struct KeepManipulationModifier: ViewModifier {

    // Gestureが終わったあとの情報を持つため
    @State private var manipuationTransformOnEnded: AffineTransform3D = .identity
    
    // Gesture時のTransform3d
    @State private var manipulationTransform: AffineTransform3D = .identity
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(manipulationTransform.scale)
            .rotation3DEffect(manipulationTransform.rotation ?? .identity)
            .offset(x: manipulationTransform.translation.x)
            .offset(y: manipulationTransform.translation.y)
            .offset(z: manipulationTransform.translation.z)
            .animation(.spring, value: manipulationTransform)
            .gesture(
                manipulationGesture()
                    .onChanged({ value in
                        var newTransform: AffineTransform3D = .identity
                        newTransform.translation = manipuationTransformOnEnded.translation + value.translation
                        
                        let newSize3D = manipuationTransformOnEnded.scale.scaled(by: value.scale)
                        newTransform.scale(by: newSize3D)
                        
                        let newRotation = manipuationTransformOnEnded.rotated(by: value.rotation ?? .identity).rotation
                        newTransform.rotate(by: newRotation ?? .identity)
                        
                        manipulationTransform = newTransform
                    })
                    .onEnded({ _ in
                        // 完了時に現在のデータを保持
                        manipuationTransformOnEnded = manipulationTransform
                    })
            )
    }
}

extension ViewModifier {
    func manipulationGesture() -> some Gesture<AffineTransform3D> {
        DragGesture()
            .simultaneously(with: MagnifyGesture())
            .simultaneously(with: RotateGesture3D())
            .map { gesture in
                // ここで3つのvalueをgestureから取得するために GestureのExtentionを使用
                let (translation, scale, rotation) = gesture.components()
                
                return AffineTransform3D(scale: scale, rotation: rotation, translation: translation)
            }
    }
}

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

