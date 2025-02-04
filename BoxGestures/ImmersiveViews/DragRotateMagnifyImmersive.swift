//
//  Drag+Rotate+DragRotateMagnifyImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/28.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct DragRotateMagnifyImmersive: View {
    
    var body: some View {
        RealityView { content, attachments in
            if let model = attachments.entity(for: "Model3D") {
                model.position = .init(0, 1, -2)
                model.components.set(GroundingShadowComponent(castsShadow: true))
                content.add(model)
            }
        } attachments: {
            Attachment(id: "Model3D") {
                Model3D(named: "Robot", bundle: realityKitContentBundle) { model in
                    model
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(depth: nil, alignment: .center)
                 // Model3Dに対して Gestureを設定する
                .keepManipulationForModel3D()
            }
        }
    }
}

#Preview(immersionStyle: .mixed) {
    DragRotateMagnifyImmersive()
}
