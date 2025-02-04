//
//  RealityView+Extensions.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/29.
//

import SwiftUI
import RealityKit

public extension RealityView {
     func installManifulationGesture1() -> some View {
        self.gesture(
            manifulationGesture1()
            // これを実行することで、Entityに対してGestureが適用される
                .targetedToAnyEntity()
            // .gesture.onChanged, .onEndedのメソッド内で GestureComponentを使用するため
            
            //.useGestureComponent()
                .onChanged { value in
                    guard let gestureComponent = value.entity.gestureComponent else { return }
                    gestureComponent
                        .onChanged(value: value)
                }
                .onEnded { value in
                    guard let gestureComponent = value.entity.gestureComponent else { return }
                    gestureComponent
                        .onEnded(value: value)
                }
        )
    }
}

extension View {
    func manifulationGesture1() -> some Gesture<AffineTransform3D> {
        DragGesture()
            .simultaneously(with: MagnifyGesture())
            .simultaneously(with: RotateGesture3D())
            .map { gesture in
                let (translation, scale, rotation) = gesture.components()
                return AffineTransform3D(scale: scale, rotation: rotation, translation: translation)
            }
    }
}




