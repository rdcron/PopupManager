//
//  AdHocLinkView.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 9/23/23.
//

import SwiftUI
import PopupManager

struct AdHocView: View {
    @Environment(\.adHocPopup) var adHoc
    
    
    @State private var currentTouch = CGPoint.zero
    @State private var isDragging = false
    
    let infoText: LocalizedStringKey = "_Code for these links can be found in:_\n**/Basics/AdHocLinkView.swift**"
    
    let adHocClosureTypeText =
"""
public typealias AdHocPopup = (_ widthMultiplier:CGFloat,
                               _ heightMultiplier:CGFloat,
                               _ touchesOutsideDismiss:Bool,
                               _ presentationMode:PopupPresentationMode,
                               _ popup:@escaping () -> any View,
                               _ onDismiss:@escaping ()-> ())-> ()
"""
    
    let adHodCodeBlock =
"""
@Environment(\\.adHocPopup) var adHoc
...
adHoc(0.6, 0.6, true, .fromTop, {
    PopupView {
        AlertPopup()
    }
}, {})
"""
    
    var text = {
        if var txt = try? AttributedString(markdown:
"""
Ad hoc popup can be created by using the [adHocPopup](popup1) Environment Value. Because Swift currently doesn't allow argument labels([SE-0111](https://github.com/apple/swift-evolution/blob/main/proposals/0111-remove-arg-label-type-significance.md)) or default values for parameters in closures , the [code](popup4) for ad hoc popups is not very pretty. It does, however, allow a popup to be activated by a function call or system event. One use is to create [in-line links](popup2) using AttributedString and accessing the openURL environment value to intercept the link and open a [popup](popup3).
""") {
            var linkRange = txt.range(of: "adHocPopup")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "code")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "in-line links")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            linkRange = txt.range(of: "popup.")
            txt[linkRange!].underlineStyle = Text.LineStyle.single
            return txt
        } else {
            return ""
        }
    }
    
    var openUrlExample: String =
"""
@Environment(\\.adHocPopup) var adHoc
@State private var currentTouch = CGPoint.zero //<==used with adHocTouchTracker
                                    // to get point for presentation
var inlineLinks = {
    if let txt = try? AttributedString(markdown:
\"\"\"
Here's a [link](link1), and here's another [link](link2).
\"\"\") {
            return txt
    } else {
        return \"\"
    }
}

var body: some View {
    Text(text())
        .environment(\\.openURL, OpenURLAction { url in
            switch url.absolutString {
            case "link1":
                adHoc(0.75, 0.75, true, .fromProvided(point: currentTouch), {
                Text("One tapped")
            }, {})
                return .handled
            case "link2":
                adHoc(0.75, 0.75, true, .fromProvided(point: currentTouch), {
                Text("Two tapped")
            }, {})
                return .handled
            default:
                return .discarded // or .systemAction to forward an unhandled url
            }
        }
        .adHocTouchTracker(touchLocation: $currentTouch) //<== tracks the latest touch within
                                            // the root PopupManager
}
"""
    
    var body: some View {
        PopupView(infoText: infoText) {
            Text(text())
                
                .environment(\.openURL, OpenURLAction { url in
                    switch url.absoluteString {
                    case "popup1":
                        adHoc(0.85, 0.6, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                VStack {
                                    CodeBlock(text: adHocClosureTypeText)
                                        .minimumScaleFactor(0.4)
                                 
                                    Text("This closely matches the init() for a PopupLink, however since there isn't a link there is no closure for a label. If an animation from a specific point is desired(such as a link in an AttributedString), the adHocTouchTracker view modifier can be applied to a view. This modifier takes a Binding<CGPoint> which is set to the most recent touch within the modified view, and that point can be passed as the presentationMode parameter via the .fromProvided(point:) case.")
                                }
                            }
                        }, {})
                        return .handled
                    case "popup2":
                        adHoc(0.85, 0.95, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                CodeBlock(text: openUrlExample)
                                    .minimumScaleFactor(0.5)
                                    
                            }
                        }, {})
                        return .handled
                    case "popup3":
                        adHoc(0.5, 0.5, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                Text("Since ad hoc popups don't have a specific link, there is no view center to animate from. Therefore, setting presentaionMode to either .fromPoint or .fromRect has the effect of presenting from the root PopupManager's origin. An animation source point can be specified with the .fromProvided(point:) PopupPresentationMode case, and a touch point can be found by applying the adHocTouchTracker modifier to the view. The other presentation modes work as expected.")
                            }
                        }, {})
                        return .handled
                    case "popup4":
                        adHoc(0.5, 0.5, true, .fromProvided(point: currentTouch), {
                            PopupView {
                                VStack {
                                    CodeBlock(text: adHodCodeBlock)
                                    Text("Even if no 'onDismiss' callback is set, an empty closure must be provided as the final argument.")
                                }
                            }
                        }, {})
                        return .handled
                    default:
                        return .systemAction
                    }
                })
                .tint(Color("LinkYellow"))
                .adHocTouchTracker(touchLocation: $currentTouch)
        }
        
    }
}

