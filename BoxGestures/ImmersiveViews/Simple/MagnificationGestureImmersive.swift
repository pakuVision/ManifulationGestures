//
//  MagnificationGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI
import RealityKit

struct MagnificationGestureImmersive: View {
    
    @State var entity = ModelEntity()
    
    var body: some View {
        RealityView { content in
            
            let sphere = MeshResource.generateSphere(radius: 0.3)
            let material = SimpleMaterial(color: .blue, isMetallic: true)
            self.entity = ModelEntity(mesh: sphere, materials: [material])
            
            entity.position = .init(0, 0.5, -2)
            
            entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            entity.generateCollisionShapes(recursive: true)
            entity.components.set(GroundingShadowComponent(castsShadow: true))
            content.add(entity)
        }
        .gesture(MagnifyGesture().targetedToEntity(entity).onChanged({ value in
            let magnification =  value.gestureValue.magnification
            let scale: Float = max(0.5, min(Float(magnification), 3.0))
            entity.transform.scale = [scale, scale, scale]
        }))
    }
}
