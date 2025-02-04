import SwiftUI
import RealityKit

public struct GestureComponent: Component, Codable {
 
    public var canDrag = true
    public var canScale = true
    public var canRotate = true
    public var resetOnEnded = true
    
    public init() { }
    
    @MainActor
    func onChanged(value: EntityTargetValue<AffineTransform3D>) {
        
        let target = value.entity
        
        if target.components.has(GestureStartComponent.self) == false {
            target.gestureStartComponent = GestureStartComponent(transform: target.transform)
        }
        
        setTransform(value: value)
    }
    
    // Transformの更新
    @MainActor
    private func setTransform(value: EntityTargetValue<AffineTransform3D>) {
        
        let target = value.entity
        
        // GestureしたTranslationの値を、空間内のTranslationへ変換
        let offset = value.convert(value.gestureValue.translation, from: .local, to: .scene)
        
        let currentAffine3D = AffineTransform3D(
            scale: value.scale,
            rotation: value.rotation ?? .identity,
            translation: .init(x: offset.x, y: offset.y, z: offset.z))

        
        guard let beforeAffineTransform3D = target.gestureStartComponent?.affineTransform3D else { return }
        
        let newAffineTransform3D = beforeAffineTransform3D.updated(with: currentAffine3D)
        target.transform = Transform(newAffineTransform3D)

        // うまくいかなかったので使わない
        //　let newTranslation = newAffineTransform3D.translation
        // let matrix = Transform(newAffineTransform3D).matrix
        // target.setTransformMatrix(matrix, relativeTo: target.parent)
    }
    
    @MainActor
    func onEnded(value: EntityTargetValue<AffineTransform3D>) {
        
//        if resetOnEnded {
//            // Gestureが終わったら、1.0秒で 元の位置に戻す
//            resetTransform(value: value, duration: 1.0)
//        } else {
//            setTransform(value: value)
//        }
        
        // GestureStartComponentを削除
        value.entity.components.remove(GestureStartComponent.self)
    }
    
    // 元に戻す
    @MainActor
    private func resetTransform(value: EntityTargetValue<AffineTransform3D>, duration: TimeInterval) {
        
        guard let beforeAffineTransform3D = value.entity.gestureStartComponent?.affineTransform3D else { return }
        
        value.entity.move(to: .identity, relativeTo: nil, duration: duration)
    }
}

public extension Entity {
    var gestureStartComponent: GestureStartComponent? {
        get { components[GestureStartComponent.self] }
        set { components[GestureStartComponent.self] = newValue }
    }

    var gestureComponent: GestureComponent? {
        get { components[GestureComponent.self] }
        set { components[GestureComponent.self] = newValue }
    }
}
