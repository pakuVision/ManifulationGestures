//
//  BoxGesturesApp.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI

@main
struct BoxGesturesApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }

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
     }
}
