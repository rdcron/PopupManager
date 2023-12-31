//
//  PopupLink.swift
//  
//
//  Created by Richard Cron on 9/11/23.
//

import SwiftUI

#if os(iOS)


public struct PopupLink<LabelView: View, Popup: View>: View {
    
    @EnvironmentObject private var stack: PopupStack
    @Environment(\.pmSize) var pmSize
    
    var widthMultiplier: CGFloat
    var heightMultiplier: CGFloat
    var touchOutsideDismisses: Bool
    var presentaionMode: PopupPresentationMode
    
    var label: () -> LabelView
    var popup: () -> Popup
    var onDismiss: () -> ()
    
    // Animation midpoint values
    @State private var rect = CGRect.zero
    @State private var midX = CGFloat.zero
    @State private var midY = CGFloat.zero
    @State private var globalLeading = CGPoint.zero
    @State private var globalTrailing = CGPoint.zero
    @State private var globalTop = CGPoint.zero
    @State private var globalBottom = CGPoint.zero
    
    public init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, presentaionMode: PopupPresentationMode = .fromRect(), popup: @escaping () -> Popup, label: @escaping () -> LabelView, onDismiss: @escaping () -> () = {}) {
        self.widthMultiplier = widthMultiplier.clamped(to: 0.1...1.0)
        self.heightMultiplier = heightMultiplier.clamped(to: 0.1...1.0)
        self.touchOutsideDismisses = touchOutsideDismisses
        self.presentaionMode = presentaionMode
        self.label = label
        self.popup = popup
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        label()
            .background(GeometryReader { geo in
                Color(.clear)
                    .preference(key: LocalSizePreferenceKey.self, value: geo.frame(in: .local))
                    .onAppear {
                        rect = geo.frame(in: .named(stack.coordinateNamespace))
                    }
                    .onChange(of: geo.frame(in: .named(stack.coordinateNamespace))) { newValue in
                        rect = newValue
                    }
            })
            .onTapGesture(count: 1, coordinateSpace: .named(stack.coordinateNamespace)) { location in
                var xOffset = CGFloat.zero
                var yOffset = CGFloat.zero
                var shouldExpand: Bool
                
                switch presentaionMode {
                case .fromRect(let expand):
                    // Popup animates from the center of the label
                    xOffset = rect.origin.x + midX
                    yOffset = rect.origin.y + midY
                    shouldExpand = expand
                case .fromPoint(let expand):
                    // Popup animates from the touch location within the label
                    xOffset = location.x
                    yOffset = location.y
                    shouldExpand = expand
                case .fromBottom(let expand):
                    xOffset = pmSize.width / 2
                    yOffset = pmSize.height
                    shouldExpand = expand
                case .fromTop(let expand):
                    xOffset = pmSize.width / 2
                    yOffset = 0
                    shouldExpand = expand
                case .fromLeading(let expand):
                    xOffset = 0
                    yOffset = pmSize.height / 2
                    shouldExpand = expand
                case .fromTrailing(let expand):
                    xOffset = pmSize.width
                    yOffset = pmSize.height / 2
                    shouldExpand = expand
                case .fromCenter(let expand):
                    xOffset = pmSize.width / 2
                    yOffset = pmSize.height / 2
                    shouldExpand = expand
                case .fromProvided(let point, let expand):
                    xOffset = point.x
                    yOffset = point.y
                    shouldExpand = expand
                }
                
                stack.push(.init(popup: AnyView(popup()), widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, touchOutsideDismisses: touchOutsideDismisses, source: CGPoint(x: xOffset, y: yOffset), expand: shouldExpand, onDismiss: onDismiss))
            }
            
        
//            .onPreferenceChange(PMSizePreferenceKey.self) { newVal in
//                rect = newVal
//            }
            .onPreferenceChange(LocalSizePreferenceKey.self) { newVal in
                midX = newVal.midX
                midY = newVal.midY
            }
    }
}

//struct PMSizePreferenceKey: PreferenceKey {
//    typealias Value = CGRect
//    static var defaultValue: Value = .zero
//
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value = nextValue()
//    }
//}

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
    init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, _ label: LocalizedStringKey, popup: @escaping () -> Popup, onDismiss: @escaping () -> () = {}) {
        self.init(widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, popup: popup, label: {
            Text(label)
        }, onDismiss: onDismiss)
    }
}

// View modifier to simplify adding a PopupLink

struct Linked<Popup: View>: ViewModifier {
    var widthMultiplier: CGFloat
    var heightMultiplier: CGFloat
    var touchOutsideDismisses: Bool
    var presentationMode: PopupPresentationMode
    var popup: () -> Popup
    var onDismiss: () -> ()
    
    public init(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, presentationMode: PopupPresentationMode = .fromRect(), popup: @escaping () -> Popup, onDismiss: @escaping () -> () = {}) {
        self.widthMultiplier = widthMultiplier.clamped(to: 0.1...1.0)
        self.heightMultiplier = heightMultiplier.clamped(to: 0.1...1.0)
        self.touchOutsideDismisses = touchOutsideDismisses
        self.presentationMode = presentationMode
        self.popup = popup
        self.onDismiss = onDismiss
    }
    
    func body(content: Content) -> some View {
        PopupLink(widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, touchOutsideDismisses:  touchOutsideDismisses, presentaionMode: presentationMode, popup: {
            popup()
        }, label: {
            content
        }, onDismiss: onDismiss)
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
    func popupLink<Popup: View>(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, presentationMode: PopupPresentationMode = .fromRect(), popup: @escaping () -> Popup, onDismiss: @escaping () -> () = {}) -> some View {
        modifier(Linked(widthMultiplier: widthMultiplier.clamped(to: 0.1...1.0), heightMultiplier: heightMultiplier.clamped(to: 0.1...1.0), touchOutsideDismisses: touchOutsideDismisses, presentationMode: presentationMode, popup: popup, onDismiss: onDismiss))
    }
}

#endif
