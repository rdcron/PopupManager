//
//  SwiftUIView.swift
//  
//
//  Created by Richard Cron on 9/25/23.
//

import SwiftUI

public struct SwiftUIView: View {
    @Binding var value: Double
    var sliderRange: ClosedRange<Double>
    // stride here
    var label: (() -> Text)?
    var onEditingChanged: (Bool) -> Void
    
    @State var lastCoordinateValue: CGFloat = 0.0
    
    public init(value: Binding<Double>, in range: ClosedRange<Double>, label: (() -> Text)? = nil, onEditingChanged: @escaping (Bool) -> Void = {_ in} ) {
        _value = value
        self.sliderRange = range
        self.label = label
        self.onEditingChanged = onEditingChanged
    }
    
    public var body: some View {
        GeometryReader { geo in
            let thumbSize = geo.size.height * 0.8
            let radius = geo.size.height * 0.5
            let minValue = geo.size.width * 0.015
            let maxValue = (geo.size.width * 0.98) - thumbSize
            
            let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
            let lower = sliderRange.lowerBound
            let sliderVal = (self.value - lower) * scaleFactor + minValue
            
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .foregroundColor(.blue)
                HStack {
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: thumbSize, height: thumbSize)
                        .offset(x: sliderVal)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { val in
                                    if (abs(val.translation.width) < 0.1) {
                                        self.lastCoordinateValue = sliderVal
                                    }
                                    if val.translation.width > 0 {
                                        let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + val.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    } else {
                                        let nextCoordinateValue = max(minValue, self.lastCoordinateValue + val.translation.width)
                                        self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                    }
                                    onEditingChanged(true)
                                }
                        )
                    Spacer()
                }
            }
        }
    }
}

