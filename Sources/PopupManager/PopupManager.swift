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
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                    content()
                        .environmentObject(stack)
                        .onAppear {
                            stack.pmMidpoint = CGPoint(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                            print(stack.pmMidpoint)
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                            // Without the delay pmMidpoint is updated to the old value
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                stack.pmMidpoint = CGPoint(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                                print(stack.pmMidpoint)
                            }
                        }
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
                            .environment(\.popupDismiss, {stack.pop()})
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
                .transition(.scale(scale: 0.1).combined(with: .offset(CGSize(width: stack.topSource?.x ?? 0, height: stack.topSource?.y ?? 0))))
                .zIndex(1)
            }
            .coordinateSpace(name: stack.coordinateNamespace)
        }
    }
}


#endif
