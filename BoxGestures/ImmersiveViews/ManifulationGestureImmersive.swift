//
//  ManifulationGestureImmersive.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/29.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ManifulationGestureImmersive: View {
    
    var body: some View {
        RealityView { content in
            guard let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) else {
                fatalError()
            }
            
            scene.position = .init(0, 0.7, -1.5)
            content.add(scene)
        }
        // RealityViewに対して Gestureを設定
        .installManifulationGesture1()
    }
}

#Preview(immersionStyle: .mixed) {
    ManifulationGestureImmersive()
}
