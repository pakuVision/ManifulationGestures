//
//  RealityView+Extensions.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/29.
//

import SwiftUI
import RealityKit

extension RealityView {
    func installManifulationGesture() -> some View {
        self.gesture(
            manifulationGesture()
                // これを実行することで、Entityに対してGestureが適用される
                .targetedToAnyEntity()
                // .gesture.onChanged, .onEndedのメソッド内で GestureComponentを使用するため
                // nameSpaceの関係で メソッドで繋ぐ
               // .useGestureComponent()
        )
    }
}

extension View {
    func manifulationGesture() -> some Gesture<AffineTransform3D> {
        DragGesture()
            .simultaneously(with: MagnifyGesture())
            .simultaneously(with: RotateGesture3D())
            .map { gesture in
                let (translation, scale, rotation) = gesture.components()
                return AffineTransform3D(scale: scale, rotation: rotation, translation: translation)
            }
    }
}




