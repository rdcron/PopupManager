//
//  PopupManager.swift
//  WTSynth1
//
//  Created by Richard Cron on 9/7/23.
//

import SwiftUI

#if os(iOS)

// Popup dismiss environment key
public typealias PopupDismiss = (() -> ())

/// Environment key to allow popping the stack from within a popup view.
public struct PopupDismissKey: EnvironmentKey {
    public static let defaultValue: PopupDismiss = {}
}

public extension EnvironmentValues {
    var popupDismiss: PopupDismiss {
        get { self[PopupDismissKey.self] }
        set { self[PopupDismissKey.self] = newValue }
    }
}

// Clear stack environment key
public typealias ClearPopupStack = (() -> ())

/// Environment key to allow clearing the stack from within a popup view.
public struct ClearPopupStackKey: EnvironmentKey {
    public static let defaultValue: ClearPopupStack = {}
}

public extension EnvironmentValues {
    var clearPopupStack: ClearPopupStack {
        get { self[ClearPopupStackKey.self] }
        set { self[ClearPopupStackKey.self] = newValue }
    }
}

/// Environment key for ad hoc popups
public typealias AdHocPopup = (CGFloat, CGFloat, Bool, @escaping () -> any View) -> ()


public struct AdHocPopupKey: EnvironmentKey {
    public static let defaultValue: AdHocPopup = {_,_,_,_  in}
}

public extension EnvironmentValues {
    var adHocPopup: AdHocPopup {
        get { self[AdHocPopupKey.self] }
        set { self[AdHocPopupKey.self] = newValue }
    }
}

/// A wrapper view that manages and presents popup views.
/// Popup managers instantiate thier own PoupStack objects
/// to store all active popups as well as some location data.
/// Multiple PopupManagers can be used as each maintains it's
/// own named coordinateSpace. However they cannot be nested.
public struct PopupManager<Content: View>: View {
    @StateObject private var stack = PopupStack()
    
    
    public var content: () -> Content
    
    /// Initializes a PopupManager view.
    /// - Parameter content: The content view wrapped by PopupManager
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func adHoc(widthMultiplier: CGFloat = 0.75, heightMultiplier: CGFloat = 0.75, touchOutsideDismisses: Bool = true, popup: @escaping () -> any View) {
        stack.push(.init(popup: AnyView(popup()), widthMultiplier: widthMultiplier, heightMultiplier: heightMultiplier, touchOutsideDismisses: touchOutsideDismisses, source: nil))
    }
    
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                    content()
                        .environmentObject(stack)
                        .environment(\.adHocPopup, adHoc)
                        .frame(width: geo.size.width, height: geo.size.height)
                
                if !stack.items.isEmpty {
                    Color(white: 0, opacity: 0.5)
                        .onTapGesture(count: 1) {
                            if let item = stack.items.first {
                                if item.touchOutsideDismisses {
                                    stack.pop()
                                }
                            }
                        }
                }
                
                ForEach(stack.items.reversed()) { popup in
                    ZStack {
                        popup.popup
                            .environmentObject(stack)
                            .environment(\.popupDismiss, { stack.pop() })
                            .environment(\.clearPopupStack, { stack.clear() })
                            .environment(\.adHocPopup, adHoc)
                        if stack.items.count > 1 {
                            if let index = stack.items.firstIndex(of: popup) {
                                if index > 0 {
                                    // If there is more than one popup active, this grays-out all but the top popup
                                    Color(white: 0, opacity: 0.5)
                                        .onTapGesture(count: 1) {
                                            if stack.items[0].touchOutsideDismisses {
                                                stack.pop()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .frame(width: geo.size.width * popup.widthMultiplier, height: geo.size.height * popup.heightMultiplier)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
//                .transition(.scale(scale: 0.1).combined(with: .offset(CGSize(width: stack.topSource?.x ?? 0, height: stack.topSource?.y ?? 0))))
                .transition(
                    .scale(scale: 0.1)
                    .combined(with: .offset(
                        midOffset(CGPoint(x: geo.size.width / 2, y: geo.size.height / 2))
                    ))
                )
                .zIndex(1)
            }
            .coordinateSpace(name: stack.coordinateNamespace)
        }
    }
    
    func midOffset(_ midPoint: CGPoint) -> CGSize {
        if let point = stack.topSource {
            print(point)
            return CGSize(width: point.x - midPoint.x, height: point.y - midPoint.y)
        }
        
        return CGSize(width: 0, height: 0)
    }
}


#endif
