//
//  FollowEffect.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/05/2021.
//

import SwiftUI

/// Translate a view along a path
public struct FollowEffect: GeometryEffect {
    let path: Path
    var length: CGFloat = 0
    let rotate: Bool
    let currentPosition: Binding<CGPoint>?
    let currentDirection: Binding<Angle>?
    let currentProgress: Binding<Double>?
    
    /// - Parameters:
    ///   - path: path along wich to translate the view
    ///   - length: percentage of path length used for the follow effect
    ///   - rotate: rotate view according to path direction
    ///   - currentPosition: current position olong the path
    ///   - currentDirection: direction of the current position
    ///   - currentProgress: percentage o thef path length completed by the effect
    public init(path: Path,
         length: CGFloat = 0,
         rotate: Bool = false,
         currentPosition: Binding<CGPoint>? = nil,
         currentDirection: Binding<Angle>? = nil,
         currentProgress: Binding<Double>? = nil
    ){
        self.path = path
        self.length = length
        self.rotate = rotate
        self.currentPosition = currentPosition
        self.currentDirection = currentDirection
        self.currentProgress = currentProgress
    }
    
    public var animatableData: CGFloat {
        get { length }
        set { length = newValue }
    }
    
    public func effectValue(size: CGSize) -> ProjectionTransform {
        var transform: CGAffineTransform
        if !rotate {
            let pt = currentPoint(progress: length)
            
            transform = CGAffineTransform(translationX: pt.x, y: pt.y)
        } else {
            let pt1 = currentPoint(progress: length)
            let pt2 = currentPoint(progress: length - 0.01)
            let direction = CGFloat(direction(from: pt1, to: pt2).radians)
            
            transform = CGAffineTransform(translationX: pt1.x, y: pt1.y).rotated(by: direction)
        }
        
        return ProjectionTransform(transform)
    }
    
    func currentPoint(progress: CGFloat) -> CGPoint {
        // Percent difference between two points on the path
        let diff: CGFloat = 0.0001
        let comp: CGFloat = 1 - diff
        
        // Handle limits
        let currentProgress = progress > 1 ? 0 : (progress < 0 ? 1 : progress)
        
        let a = currentProgress > comp ? comp : currentProgress
        let b = currentProgress > comp ? 1 : currentProgress + diff
        let trimmedPath = path.trimmedPath(from: a, to: b)
        
        let currentPosition = CGPoint(x: trimmedPath.boundingRect.midX,
                                      y: trimmedPath.boundingRect.midY)
        DispatchQueue.main.async {
            self.currentPosition?.wrappedValue = currentPosition
            self.currentProgress?.wrappedValue = Double(progress)
        }
        
        return currentPosition
    }
    
    func direction(from pt1: CGPoint, to pt2: CGPoint) -> Angle {
        let dx = pt2.x - pt1.x
        let dy = pt2.y - pt1.y
        
        let radians = dx < 0 ? atan(Double(dy / dx)) : atan(Double(dy / dx)) - Double.pi
        let currentDirection = Angle.radians(radians)
        
        DispatchQueue.main.async {
            self.currentDirection?.wrappedValue =  currentDirection
            self.currentProgress?.wrappedValue = Double(length)
        }
        
        return currentDirection
    }
}
