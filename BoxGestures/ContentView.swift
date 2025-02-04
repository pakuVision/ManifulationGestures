//
//  ContentView.swift
//  BoxGestures
//
//  Created by boardguy.vision on 2025/01/27.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var showingImmersiveSpace = false

    var body: some View {
        VStack {
            HStack {
                Button {
                    Task {
                        if showingImmersiveSpace {
                            await dismissImmersiveSpace()
                        }
                        await openImmersiveSpace(id: "DragGestureImmersive")
                        showingImmersiveSpace = true
                    }
                } label: {
                    Text("DragGesture")
                }
                
                Button {
                    Task {
                        if showingImmersiveSpace {
                            await dismissImmersiveSpace()
                        }
                        await openImmersiveSpace(id: "MagnificationGestureImmersive")
                        showingImmersiveSpace = true
                    }
                } label: {
                    Text("MagnificationGesture")
                }
                
                Button {
                    Task {
                        if showingImmersiveSpace {
                            await dismissImmersiveSpace()
                        }
                        await openImmersiveSpace(id: "DragAndMagnifyGestureImmersive")
                        showingImmersiveSpace = true
                    }
                } label: {
                    Text("DragAndMagnifyGestureImmersive")
                }
            }
           
            
            HStack {
                Button {
                    Task {
                        if showingImmersiveSpace {
                            await dismissImmersiveSpace()
                        }
                        await openImmersiveSpace(id: "RotationGestureImmersive")
                        showingImmersiveSpace = true
                    }
                } label: {
                    Text("RotationGestureImmersive")
                }
                
                Button {
                    Task {
                        if showingImmersiveSpace {
                            await dismissImmersiveSpace()
                        }
                        await openImmersiveSpace(id: "RotationAndMagnifyGestureImmersive")
                        showingImmersiveSpace = true
                    }
                } label: {
                    Text("RotationAndMagnifyGestureImmersive")
                }
            }

            Button {
                Task {
                    if showingImmersiveSpace {
                        await dismissImmersiveSpace()
                    }
                    await openImmersiveSpace(id: "DragRotateScaleGestureImmersive")
                    showingImmersiveSpace = true
                }
            } label: {
                Text("Drag + Rotate + Scale Gesture")
                    .bold()
            }
            
            Button {
                Task {
                    if showingImmersiveSpace {
                        await dismissImmersiveSpace()
                    }
                    await openImmersiveSpace(id: "DragRotateMagnifyImmersive")
                    showingImmersiveSpace = true
                }
            } label: {
                Text("Drag + Rotate + Scale Gesture (keep beforeGesture)")
                    .bold()
            }
            
            Button {
                Task {
                    if showingImmersiveSpace {
                        await dismissImmersiveSpace()
                    }
                    await openImmersiveSpace(id: "ManifulationGestureImmersive")
                    showingImmersiveSpace = true
                }
            } label: {
                Text("EntityでManifulationGesture")
                    .bold()
                    .foregroundStyle(.yellow)
            }
        }
    }
}
