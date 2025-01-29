//
//  DragGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct DragGestureImmersive: View {

    @State private var box = ModelEntity()

    var body: some View {
        RealityView { content in
            
            let boxMesh = MeshResource.generateBox(size: 0.3)
            let material = SimpleMaterial(color: .red, isMetallic: true)
            self.box = ModelEntity(mesh: boxMesh, materials: [material])
            box.position = .init(0, 0.5, -2)
            
            box.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            box.generateCollisionShapes(recursive: true)
            box.components.set(GroundingShadowComponent(castsShadow: true))
            content.add(box)
        }
        .gesture(
            DragGesture()
                .targetedToEntity(box)
                .onChanged({ value in
                    box.position = value.convert(value.location3D, from: .local, to: box.parent!)
                })
            )
    }
}

#Preview(immersionStyle: .mixed) {
    DragGestureImmersive()
}
