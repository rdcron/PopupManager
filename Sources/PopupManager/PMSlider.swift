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
    public var step: V.Stride
    public  var label: (() -> Text)?
    public var minimumValueLabel: () -> Text
    public var maximumValueLabel: () -> Text
    public var onEditingChanged: (Bool) -> Void
    
    @State private var lastCoordinateValue: V = 0.0
    @State private var size = CGSize.zero
    @State private var minLabelSize = CGFloat.zero
    @State private var maxLabelSize = CGFloat.zero
    @State private var trackSize = CGFloat.zero
    @State private var graduations: V = .zero
    let thumbSize = 27.5
    
    public init(value: Binding<V>, in range: ClosedRange<V>, step: V.Stride = .zero, label: (() -> Text)? = nil, minimumValueLabel: @escaping () -> Text = { Text("") }, maximumValueLabel: @escaping () -> Text = { Text("") }, onEditingChanged: @escaping (Bool) -> Void = {_ in} ) {
        _value = value
        self.step = step
        self.sliderRange = range
        self.label = label
        self.minimumValueLabel = minimumValueLabel
        self.maximumValueLabel = maximumValueLabel
        self.onEditingChanged = onEditingChanged
    }
    
    public var body: some View {

        let minValue = V(0.0)
        let maxValue = V(size.width - (thumbSize + minLabelSize + maxLabelSize))
            
        let scaleFactor = (maxValue - minValue) / (sliderRange.upperBound - sliderRange.lowerBound)
        let lower = sliderRange.lowerBound
        let sliderVal = (self.value - lower) * scaleFactor + minValue
        
        ZStack {
            
            HStack {
                minimumValueLabel()
                    .background(GeometryReader { geo in
                        Color.clear
                            .preference(key: MinLabelSizeKey.self, value: geo.size.width)
                    })
                    .onPreferenceChange(MinLabelSizeKey.self) { newValue in
                        minLabelSize = newValue
                    }
                
                ZStack {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: size.height / 2))
                        path.addLine(to: CGPoint(x: trackSize, y: size.height / 2))
                    }
                    .stroke(.black.opacity(0.1), lineWidth: 4)
                    
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: size.height / 2))
                        path.addLine(to: CGPoint(x: trackSize, y: size.height / 2))
                    }
                    .trim(from: 0, to: CGFloat((value - sliderRange.lowerBound) / abs(sliderRange.lowerBound - sliderRange.upperBound)))
                    .stroke(.tint, lineWidth: 4)
                }
                .background( GeometryReader { geo in
                    Color.clear
                        .preference(key: SliderTrackSizeKey.self, value: geo.size.width)
                })
                .onPreferenceChange(SliderTrackSizeKey.self) { newValue in
                    trackSize = newValue
                }
                
                
                maximumValueLabel()
                    .background(GeometryReader { geo in
                        Color.clear
                            .preference(key: MaxLabelSizeKey.self, value: geo.size.width)
                    })
                    .onPreferenceChange(MaxLabelSizeKey.self) { newValue in
                        maxLabelSize = newValue
                    }
            }
//            .border(.yellow)
            
            HStack {
                Circle()
                    .fill(.white.shadow(.drop(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: CGFloat(sliderVal) + minLabelSize)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { val in
                                var localValue: V = .zero
                                
                                if (abs(val.translation.width) < 0.1) {
                                    self.lastCoordinateValue = sliderVal
                                }
                                if val.translation.width > 0 {
                                    let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + V(val.translation.width))
                                    localValue = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                } else {
                                    let nextCoordinateValue = max(minValue, self.lastCoordinateValue + V(val.translation.width))
                                    localValue = ((nextCoordinateValue - minValue) / scaleFactor) + lower
                                }
                                
                                if step == .zero {
                                    value = localValue
                                } else {
                                    let percent = (localValue - sliderRange.lowerBound) / abs(sliderRange.lowerBound - sliderRange.upperBound)
                                    let steps = round(V(graduations) * percent)
                                    value = sliderRange.lowerBound + (V(step) * steps)
                                    print(sliderRange.lowerBound + (V(step) * steps))
                                }
                                    
                                onEditingChanged(true)
                            }
                    )
                Spacer()
            }
            .onAppear {
                self.graduations = (step == .zero) ? .zero : abs(sliderRange.lowerBound - sliderRange.upperBound) / V(step)
                if graduations != .zero {
                    let percent = (value - sliderRange.lowerBound) / abs(sliderRange.lowerBound - sliderRange.upperBound)
                    let steps = round(V(graduations) * percent)
                    value = sliderRange.lowerBound + (V(step) * steps)
                }
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

struct MinLabelSizeKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct MaxLabelSizeKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct SliderTrackSizeKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
