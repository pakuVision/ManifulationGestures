//
//  BoxGesturesApp.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI
import RealityKitContent

@main
struct BoxGesturesApp: App {

    init() {
        // RealityComposerProで自作のComponentを呼び出す場合、ここでこれを実行する必要がある
        RealityKitContent.GestureComponent.registerComponent()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .defaultSize(width: 800, height: 400)

        ImmersiveSpace(id: "DragGestureImmersive") {
            DragGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: "MagnificationGestureImmersive") {
            MagnificationGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: "DragAndMagnifyGestureImmersive") {
            DragAndMagnifyGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        
        
        ImmersiveSpace(id: "RotationGestureImmersive") {
            RotationGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: "RotationAndMagnifyGestureImmersive") {
            RotationAndMagnifyGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: "DragRotateScaleGestureImmersive") {
            DragRotateScaleGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        
        ImmersiveSpace(id: "DragRotateMagnifyImmersive") {
            DragRotateMagnifyImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        

        ImmersiveSpace(id: "ManifulationGestureImmersive") {
            ManifulationGestureImmersive()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
     }
}
