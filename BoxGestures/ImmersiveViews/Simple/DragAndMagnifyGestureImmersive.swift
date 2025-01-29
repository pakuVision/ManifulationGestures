//
//  DragAndMagnifyGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI
import RealityKit

struct DragAndMagnifyGestureImmersive: View {
    
    @State var box = ModelEntity()
    
    var body: some View {
        RealityView { content in
            
            let mesh = MeshResource.generateBox(size: 0.3, cornerRadius: 0.1)
            let material = SimpleMaterial(color: .green, isMetallic: true)
            self.box = ModelEntity(mesh: mesh, materials: [material])
            
            box.position = .init(0, 0.3, -2)
            
            box.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            box.generateCollisionShapes(recursive: true)
            box.components.set(GroundingShadowComponent(castsShadow: true))
            
            content.add(box)
        }
        .gesture(
            SimultaneousGesture(
                DragGesture().targetedToEntity(box)
                    .onChanged({ value in
                        box.position = value.convert(value.location3D, from: .local, to: box.parent!)
                    }),
                MagnifyGesture().targetedToEntity(box)
                    .onChanged({ value in
                        let magnification = value.magnification
                        let scale = max(0.5, min(Float(magnification), 3.0))
                        box.transform.scale = .init(scale, scale, scale)
                    }))
        )
    }
}
