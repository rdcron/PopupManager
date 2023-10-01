//
//  File.swift
//  
//
//  Created by Richard Cron on 10/1/23.
//

import SwiftUI

struct AdHocTouchTracker: ViewModifier {
    @Environment(\.popupCoordinateSpace) var coordSpaceName
    @Binding var touchLocation: CGPoint
    @State var isDragging = false
    
    init(touchLocation: Binding<CGPoint>) {
        _touchLocation = touchLocation
    }
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named(coordSpaceName))
                    .onChanged { value in
                        if !isDragging {
                            let xOffset = value.location.x
                            let yOffset = value.location.y
                            touchLocation = CGPoint(x: xOffset, y: yOffset)
                        }
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
    }
}

public extension View {
    func adHocTouchTracker(touchLocation: Binding<CGPoint>) -> some View {
        modifier(AdHocTouchTracker(touchLocation: touchLocation))
    }
}
