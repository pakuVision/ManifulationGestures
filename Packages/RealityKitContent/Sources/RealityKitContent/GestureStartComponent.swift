
import SwiftUI
import RealityKit

public struct GestureStartComponent: Component {
    
    public let transform: Transform
    
    init(transform: Transform) {
        self.transform = transform
    }
    
    public var affineTransform3D: AffineTransform3D {
        AffineTransform3D(transform)
    }
}
