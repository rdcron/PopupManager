# **PopupManager**

## **Overview**

![](../Media/PopupIntro.mov)

PopupManager is a Swift package that adds a new type of modal view to SwiftUI iOS projects. Popup views are defined by the user of the package, and can be presented in a number of ways. When dismissed, the reverse animation is performed. The `PopupManager` API is loosely based on the `NavigationStack` and `NavigationLink` APIs. The `PopupManager` struct manages a stack of active popups and handles the animation for presentation and dismissal of popup views. Each `PopupManager` maintains it's own named coordinate space, so multiple `PopupManager`s can be used, either on the same screen or on separate screens in the app. They cannot, however, be nested.

![](../Media/MultiPopups.mov)

## **Usage**

`PopupManager`s are created with the init(content:) initializer. Within the content view, PopupLinks can be defined with a label(the tappable view) and a popup(the view presented when the label is tapped).

```Swift
PopupManager {
    PopupLink {
        Rectangle()
        .fill(.blue)
    } label: {
        Text("Popup")
    }
}
```

The above example will create a tappable Text view which, when tapped, will present a blue rectangle to the screen. When popups are presented, the rest of the contents of the `PopupManager` is grayed-out. By default, tapping outside of the popup view itself will dismiss the popup. Alternate methods for dismissing popups will be covered below.

Because `PopupManager` is stack-based, a presented popup can itself contain a `PopupLink` which will open a new popup. All active popups except the top one is grayed-out.

There are multiple ways to define a PopupLink, and multiple optional parameters that can be used to customize the popup. In the above example, no size information was provided for the popup; this is because sizing of popups is realative to the PopupMangers content and is set to a default value. the parameters `widthMultiplier` and `heightMultiplier` can be set to a value from 0.1 to 1.0(the parameter values are clamped to this range), and specifies that particular dimension realative to the `PopupManager`. The default value for these parameters is 0.75.

### **Presenting Popups**

#### **PopupLink**

---

The `PopupManager` example above used a link with the primary initializer for the `PopupLink` struct:

```Swift
public init(widthMultiplier: CGFloat = 0.75,
            heightMultiplier: CGFloat = 0.75, 
            touchOutsideDismisses: Bool = true, 
            presentaionMode: PopupPresentationMode = .fromRect(), 
            popup: @escaping () -> Popup, 
            label: @escaping () -> LabelView, 
            onDismiss: @escaping () -> () = {})
```

Most parameters have default values and can be skipped when declaring a `PopupLink`. All of the ways to declare a `PopupLink`(discussed below) ultimately call this initializer. The parameters are:

* widthMultiplier: The width of the presented popup realative to the enclosing `PopupManager`(clampped between 0.1 and 1.0).
* heightMultiplier: The height of the presented popup realative to the enclosing `PopupManager`(clampped between 0.1 and 1.0).
* touchOutsideDismisses: Boolean that determines if tapping outside the presented popup(in the grayed-out area) dissmisses the popup.
* presentationMode: An enum value that determines how the popup is presented, details below.
* popup: A closure defining the popup view to be presented.
* label: A closure defining the tappable label that will activate the popup.
* onDismiss: A callback closure that is called when the presented popup is dismissed.

One alternate PopupLink (example below) alows a `String` to be specified for the label.

```Swift
PopupLink(widthMultiplier: 0.25, "Popup") {
    Rectangle()
        .fill(.red)
}
.font(.largeTitle)
.frame(width: 150, height: 60)
```

In this example, the `widthMultiplier` parameter has been set (the `heightMultiplier` will remain at the default) and a `String` "Popup" has been specified. This will result in the tappable text "Popup" appearing on the screen which will present a red rectangle. The modifiers at the end of the example set the "Popup" text and do not affect the popup view.

Another method for using PopupLink is with the .popupLink view modifier. Using this method, the lable view is defined in place, and the .popupLink modifier is applied to it including parameters and the popup view itself.

```Swift
Image(systemName: "mic") 
    .resizable()
    .frame(width: 100, height: 100)
    .popupLink(widthMultiplier: 0.5, heightMultiplier: 0.5) {
        AudioInputSettingsView()
    }
```

This will place the "mic" SF Symbol image on the screen. When tapped, the AudioInputSettingsView() will be presented as a popup.

#### **Ad Hoc Popups**

Using the `@Environment(\.addHocPopup)` Environment Value, popups can be initiated directly without a PopupLink. This allow a popup to be activated in a function call. Because Swift doesn't allow argument labels or default parameter values in closures, the code for an ad hoc popup isn't very 'Swifty'. However, ad hoc popups add some flexibilty in how popups can be used, allowing things like custom alert views.

```Swift
func onMessageRecieve(_ message: String) {
    adHoc(0.3, 0.3, true, .fromTop(), {
        AlertView(message)
    }, {})
}
```

The arguments relate directly to the `PopupLink` primary initializer except that the `label` parameter is omitted(ad hoc popups don't have labels). Note that even though there was no `onDismiss` closure needed, an empty closure was still passed as the last argument. As stated above, Swift doesn't allow default values for closure parameters. The closure definition for the `adHocPopup` EnvironmentValue is:

```Swift
public typealias AdHocPopup = (_ widthMultiplier:CGFloat,
                                _ heightMultiplier:CGFloat,
                                _ touchesOutsideDismiss:Bool,
                                _ presentationMode:PopupPresentationMode,
                                _ popup:@escaping () -> any View,
                                _ onDismiss:@escaping () -> ()) -> ()
```

Because there is no linked label associated with an ad hoc popup, the .fromRect and .fromPoint presentation modes give a presentation animation from the root `PopupManager`s origin. To animate from a specific point, the .fromProvided(point:) case can be used(PopupPresentationMode is covered in detail below). The touch point can be accessed by using the adHocTouchTracker view modifier(also covered below).

#### **adHocTouchTracker**

The adHocTouchTracker takes a `Binding<CGPoint>` argument which is set to the most recent touch location realative to the root `PopupManager`s named coordinate space. This can be used with the .fromProvided(point:) PopupPresentationMode case to animate the popup from the touch location when an ad hoc popup is used.

```Swift
@State private var currentTouch = CGPoint.zero

var body: some View {
	Button("Ad hoc popup example") {
		adHoc(0.25, 0.25, true, .fromProvided(point: currentTouch), {
			Text("Animating from: x: \(currentTouch.x), y: \(currentTouch.y)
		}, {})
	}
	.adHocTouchTracker(touchLocation: $currentTouch)	
}
```

This view modifier doesn't have to be used with an ad hoc popup. All it does is keep the `Binding<CGPoint>` value set to the most recent touch within the modified view realative to the root `PopupManager`.

>##### **Caution**

>Some built-in SwiftUI controls(Slider, .segmented and .wheel Picker styles, probably more) don't work with adHocTouchTracker. If one of these views has the adHocTouchTracker modifier attached, or if it is a  child of a view with that modifier, they won't respond to touch events. If touch tracking is needed within a parent view that includes such a control, attach the modifier directly to the views that need their touch location tracked, or to a container(HStack, VStack, etc.) that doesn't contain those controls.

### **Dismissing popups**

---

As stated before, tapping outside the popup view will dismiss the popup by default. This behavior can be changed by setting the `touchOutsideDismisses` parameter of PopupLink to false. This of course would require an alternate method of dismissing the popup. For this, the root `PopupManager` injects the `popupDismiss` EnvironmentValue which can be accessed via the `@Environment(\.popupDismiss)` environment value.

```Swift
struct DismissablePopup: View {
    @Environment(\.popupDismiss) var dismiss //<== set here
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray)
            
            VStack {
                HStack { //<== Vstack/HStack combo
                         // places 'X' button in upper right corner
                    Spacer()
                    Image(systemName: "x.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .padding()
                        .onTapGesture {
                            dismiss() // <== called here
                        }
                }
                Spacer()
            }
        }
    }
}
```

This allows customizing how the popup dismissal process works. It is of course possible to both use the `popupDismiss` EnvironmentValue and also leave `touchOutsideDismisses` set to true.

Simillarly, all active popups can be dismissed at once using the `@Environment(\.clearPopupStack)` environment value. The syntax is identical to using `popupDismiss`.

### **Presentation Modes**

The `PopupPresentationMode` enum declares several modes for presenting popup views. All cases have an `expand:Bool` associated value which determines whether the popup's scale animates at presentation or appears at full size. The default value of `expand` is `true`. The `.fromProvided` case has an additional `point:CGPoint` associated value, described below. The cases are:

* `.fromRect(expand:Bool))`: Popup presented from the center of the label(if applicable)
* `.fromPoint(expand:Bool))`: Popup presented from the tap location(not compatible with ad hoc popups)
* `.fromBottom(expand:Bool))`: Popup presented from the bottom of the `PopupManager` enclosed area.
* `.fromTop(expand:Bool))`: Popup presented from the top of the `PopupManager` enclosed area.
* `.fromLeading(expand:Bool))`: Popup presented from the leading edge of the `PopupManager` enclosed area.
* `.fromTrailing(expand:Bool))`: Popup presented from the trailing edge of the `PopupManager` enclosed area.
* `.fromCenter(expand:Bool))`: Popup presented from the center of the `PopupManager` enclosed area.
* `.fromProvided(point:CGPoint,expand:Bool)`: Popup presented from a specified point. Can be used in conjuction with the `adHocTouchTracker` view modifier to present an ad hoc popup from a touch location.

It's important to note that all of these presentations are realative to the `PopupManger` enclosed view. If the `PopupManager` takes up less that the entire screen, the presentations occur within and realative to that area.

## **Example Project**

This repository includes an example project, the creativly named PopupManagerExample. The project itelf demonstrates many ways to use the package, and running the app gives examples of how the library works.

## **Installing**

PopupManager is a Swift package and can be installed using the Swift Package Manager. In Xcode, from the project to which you want to add PopupManager,

1. Go to File/Add Packages...
2. in the search bar, enter [https://github.com/rdcron/PopupManager.git](https://github.com/rdcron/PopupManager.git)

Or you can clone the repository and use the package locally.

 PopupManager is an iOS specific package, as it doesn't seem to serve a purpose on Mac. Also, the developer of this package hasn't done any Mac development.

## **Dependancies**

The PopupManager package itself doesn't use any external dependancies. The example project uses John Sundell's [Splash](https://github.com/JohnSundell/Splash) Swift package for code highlighting.

## **Known issues**

* The ad hoc popup syntax isn't great, hopefully a way to make it more 'Swifty' can be found.
* More will be added as necessary.
