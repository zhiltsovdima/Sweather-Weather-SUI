//
//  RoundedCornerShape.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct RectCorner: OptionSet {
    
    let rawValue: Int
        
    static let topLeft = RectCorner(rawValue: 1 << 0)
    static let topRight = RectCorner(rawValue: 1 << 1)
    static let bottomRight = RectCorner(rawValue: 1 << 2)
    static let bottomLeft = RectCorner(rawValue: 1 << 3)
    
    static let allCorners: RectCorner = [.topLeft, topRight, .bottomLeft, .bottomRight]
}

struct RoundedCornersShape: Shape {
    
    var radius: CGFloat = .zero
    var corners: RectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let point1 = CGPoint(x: rect.minX, y: corners.contains(.topLeft) ? rect.minY + radius : rect.minY )
        let point2 = CGPoint(x: corners.contains(.topLeft) ? rect.minX + radius : rect.minX, y: rect.minY )

        let point3 = CGPoint(x: corners.contains(.topRight) ? rect.maxX - radius : rect.maxX, y: rect.minY )
        let point4 = CGPoint(x: rect.maxX, y: corners.contains(.topRight) ? rect.minY + radius : rect.minY )

        let point5 = CGPoint(x: rect.maxX, y: corners.contains(.bottomRight) ? rect.maxY - radius : rect.maxY )
        let point6 = CGPoint(x: corners.contains(.bottomRight) ? rect.maxX - radius : rect.maxX, y: rect.maxY )

        let point7 = CGPoint(x: corners.contains(.bottomLeft) ? rect.minX + radius : rect.minX, y: rect.maxY )
        let point8 = CGPoint(x: rect.minX, y: corners.contains(.bottomLeft) ? rect.maxY - radius : rect.maxY )

        path.move(to: point1)
        path.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY),
                    tangent2End: point2,
                    radius: radius)
        path.addLine(to: point3)
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY),
                    tangent2End: point4,
                    radius: radius)
        path.addLine(to: point5)
        path.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY),
                    tangent2End: point6,
                    radius: radius)
        path.addLine(to: point7)
        path.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY),
                    tangent2End: point8,
                    radius: radius)
        path.closeSubpath()

        return path
    }
}
