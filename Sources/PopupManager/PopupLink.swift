//
//  PopupLink.swift
//  
//
//  Created by Richard Cron on 9/11/23.
//

import SwiftUI

#if os(iOS)


public struct PopupLink<LabelView: View, Popup: View>: View {
    public enum AnimationSource {
        case fromRect, fromPoint
    }
    
    @EnvironmentObject private var stack: PopupStack
    
    var widthMultiplier: CGFloat
    var heightMultiplier: CGFloat
    var touchOutsideDismisses: Bool
    var animationSource: AnimationSource
    
    var label: () -> LabelView
    var popup: () -> Popup
    
    // Animation midpoint values
    @State private var rect = CGRect.zero
    @State private var midX = CGFloat.zero
    @State private var midY = CGFloat.zero
    
    public init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, animationSource: AnimationSource = .fromRect, popup: @escaping () -> Popup, label: @escaping () -> LabelView) {
        self.widthMultiplier = widthMultiplier.clamped(to: 0.1...1.0)
        self.heightMultiplier = heightMultiplier.clamped(to: 0.1...1.0)
        self.touchOutsideDismisses = touchOutsideDismisses
        self.animationSource = animationSource
        self.label = label
        self.popup = popup
    }
    
    public var body: some View {
        label()
            .background(GeometryReader { geo in
                Color(.clear)
                    .preference(key: PMSizePreferenceKey.self, value: geo.frame(in: .named(stack.coordinateNamespace)))
                    .preference(key: LocalSizePreferenceKey.self, value: geo.frame(in: .local))
            })
            .onTapGesture(count: 1, coordinateSpace: .named(stack.coordinateNamespace)) { location in
                var xOffset = CGFloat.zero
                var yOffset = CGFloat.zero
                
                switch animationSource {
                case .fromRect:
                    // Popup animates from the center of the label
                    xOffset = rect.origin.x + midX
                    yOffset = rect.origin.y + midY
                case .fromPoint:
                    // Popup animates from the touch location within the label
                    xOffset = location.x
                    yOffset = location.y
                }
                
                stack.push(.init(popup: AnyView(popup()), widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, touchOutsideDismisses: touchOutsideDismisses, source: CGPoint(x: xOffset, y: yOffset)))
            }
            .onPreferenceChange(PMSizePreferenceKey.self) { newVal in
                rect = newVal
            }
            .onPreferenceChange(LocalSizePreferenceKey.self) { newVal in
                midX = newVal.midX
                midY = newVal.midY
            }
    }
}

struct PMSizePreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct LocalSizePreferenceKey: PreferenceKey {
    typealias Value = CGRect
    static var defaultValue: Value = .zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

public extension PopupLink where LabelView == Text {
    
    /// Convienience initializer to allow quickly creating a text PopupLink
    /// - Parameters:
    ///   - widthMultiplier: width of the popup view realative to its PopupManager
    ///   - heightMultiplier: height of the popup view realative to its PopupManager
    ///   - label: String used in the label Text view
    ///   - popup: ViewBuilder closure used to create the popup view
    init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, _ label: LocalizedStringKey, popup: @escaping () -> Popup) {
        self.init(widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, popup: popup) {
            Text(label)
        }
    }
}

// View modifier to simplify adding a PopupLink

struct Linked<Popup: View>: ViewModifier {
    var widthMultiplier: CGFloat
    var heightMultiplier: CGFloat
    var touchOutsideDismisses: Bool
    var popup: () -> Popup
    
    public init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, popup: @escaping () -> Popup) {
        self.widthMultiplier = widthMultiplier.clamped(to: 0.1...1.0)
        self.heightMultiplier = heightMultiplier.clamped(to: 0.1...1.0)
        self.touchOutsideDismisses = touchOutsideDismisses
        self.popup = popup
    }
    
    func body(content: Content) -> some View {
        PopupLink(widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, touchOutsideDismisses:  touchOutsideDismisses) {
            popup()
        } label: {
            content
        }
    }
}

public extension View {
    
    /// View modifier to create a PopupLink from a view
    /// - Parameters:
    ///   - widthMultiplier: width of the popup view realative to its PopupManager
    ///   - heightMultiplier: height of the popup view realative to its PopupManager
    ///   - touchOutsideDismisses: Specifies whether tapping outside the popup dismisses it, default is true
    ///   - popup: ViewBuilder closure used to create the popup view
    /// - Returns: PopupLink-wrapped view
    func popupLink<Popup: View>(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, popup: @escaping () -> Popup) -> some View {
        modifier(Linked(widthMultiplier: widthMultiplier.clamped(to: 0.1...1.0), heightMultiplier: heightMultiplier.clamped(to: 0.1...1.0), touchOutsideDismisses: touchOutsideDismisses, popup: popup))
    }
}

#endif
