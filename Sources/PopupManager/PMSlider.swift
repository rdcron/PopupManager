//
//  SwiftUIView.swift
//  
//
//  Created by Richard Cron on 9/25/23.
//

import SwiftUI

public struct PMSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint, V : Equatable {
    @Binding public var value: V
    public var sliderRange: ClosedRange<V>
    public var stride: V.Stride?
    public  var label: (() -> Text)?
    public var minimumValueLabel: (() -> Text)?
    public var maximumValueLabel: (() -> Text)?
    public var onEditingChanged: (Bool) -> Void
    
    @State private var lastCoordinateValue: V = 0.0
    @State private var size = CGSize.zero
    @State private var normalizedVal = 0.0
    let thumbSize = 30.0
    
    public init(value: Binding<V>, in range: ClosedRange<V>, stride: V.Stride? = nil, label: (() -> Text)? = nil, minimumValueLabel: (() -> Text)? = nil, maximumValueLabel: (() -> Text)? = nil, onEditingChanged: @escaping (Bool) -> Void = {_ in} ) {
        _value = value
        self.stride = stride
        self.sliderRange = range
        self.label = label
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.onEditingChanged = onEditingChanged
    }
    
    public var body: some View {

        let minValue = V(0.0)
        let maxValue = V((size.width) - thumbSize)
            
        let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
        let lower = sliderRange.lowerBound
        let sliderVal = (self.value - lower) * scaleFactor + minValue
        
        ZStack {
            
            HStack {
               
                Path { path in
                    path.move(to: CGPoint(x: 0, y: size.height / 2))
                    path.addLine(to: CGPoint(x: size.width * normalizedVal, y: size.height / 2))
                }
                .stroke(.tint, lineWidth: 4)
                Path{ path in
                    path.move(to: CGPoint(x: (size.width * normalizedVal) - (size.width / 2), y: size.height / 2))
                    path.addLine(to: CGPoint(x: size.width / 2, y: size.height / 2))
                }
                .stroke(.gray, lineWidth: 4)
                
            }
            
            HStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: CGFloat(sliderVal))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { val in
                                if (abs(val.translation.width) < 0.1) {
                                    self.lastCoordinateValue = sliderVal
                                }
                                if val.translation.width > 0 {
                                    let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + V(val.translation.width))
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                } else {
                                    let nextCoordinateValue = max(minValue, self.lastCoordinateValue + V(val.translation.width))
                                    self.value = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                }
                                normalizedVal = Double(sliderVal / maxValue)
                                onEditingChanged(true)
                            }
                    )
                Spacer()
            }
            .onAppear {
                normalizedVal = Double(sliderVal / maxValue)
            }
            .onChange(of: value) { newVal in
                normalizedVal = Double(value / sliderRange.upperBound)
            }
            
        }
        .background(GeometryReader { geo in
            Color.clear
                .preference(key: SliderSizeKey.self, value: geo.frame(in:.local).size)
        })
        .frame(maxWidth: .infinity)
        .frame(height: thumbSize)
        .onPreferenceChange(SliderSizeKey.self) { newValue in
            size = newValue
        }
        
    }
}

struct SliderSizeKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
