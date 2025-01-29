//
//  RotationGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/28.
//

import SwiftUI
import RealityKit

struct RotationGestureImmersive: View {
    
    @State var boxEntity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            let mesh = MeshResource.generateBox(size: 0.3, cornerRadius: 0.1)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            boxEntity = ModelEntity(mesh: mesh, materials: [material])
            
            boxEntity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            boxEntity.components.set(GroundingShadowComponent(castsShadow: true))
            boxEntity.generateCollisionShapes(recursive: true)
            boxEntity.position = .init(0, 0.3, -2)
            
            content.add(boxEntity)
        }
        .gesture(
            RotateGesture3D().targetedToEntity(boxEntity).onChanged({ value in
                boxEntity.transform.rotation = value.convert(value.rotation, from: .local, to: .scene)
            })
        )
    }
}

#Preview(immersionStyle: .mixed) {
    RotationGestureImmersive()
}
