//
//  DragRotateScaleGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/28.
//

import SwiftUI
import RealityKit

// Drag + Rotate + Scale gestureを同時に行う最もシンプルな実装
struct DragRotateScaleGestureImmersive: View {
    
    @State var boxEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            let mesh = MeshResource.generateBox(size: 0.3, cornerRadius: 0.1)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            boxEntity = ModelEntity(mesh: mesh, materials: [material])
            
            boxEntity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            boxEntity.components.set(GroundingShadowComponent(castsShadow: true))
            boxEntity.generateCollisionShapes(recursive: true)
            boxEntity.position = .init(0, 0.5, -2)
            
            content.add(boxEntity)
        }
        .gesture(
            SimultaneousGesture(
                DragGesture()
                    .targetedToEntity(boxEntity)
                    .onChanged({ value in
                        boxEntity.position = value.convert(value.location3D, from: .local, to: boxEntity.parent!)
                    })
                , SimultaneousGesture(
                    RotateGesture3D()
                        .targetedToEntity(boxEntity)
                        .onChanged({ value in
                            boxEntity.transform.rotation = value.convert(value.rotation, from: .local, to: .scene)
                        }),
                    MagnifyGesture()
                        .targetedToEntity(boxEntity)
                        .onChanged({ value in
                            let magnification = max(0.3, min(Float(value.magnification), 3.0))
                            boxEntity.transform.scale = .init(magnification, magnification, magnification)
                        })
                ))
        )
    }
}

#Preview(immersionStyle: .mixed) {
    DragRotateScaleGestureImmersive()
}
