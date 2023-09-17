# **PopupManager**

## **Overview**

PopupManager is a Swift package that adds a new type of modal view to SwiftUI iOS projects. Popup views are provided by the user of the package, and are presented by animating the popup from the initiating view. When dismissed, the reverse animation to the initiating view is performed. The PopupManager API is loosely based on the `NavigationView` and `NavigationLink` APIs. The `PopupManager` struct manages a stack of active popups and handles the animation for presentation and dismissal of popup views. Each PopupManager maintains it's own named coordinate space, so multiple PopupManagers can be used, either on the same screen or on separate screens in the app. They cannot, however, be nested.

## **Usage**

PopupManagers are created with the init(content:) initializer. Within the content view, PopupLinks can be defined with a label(the tappable view) and a popup(the view presented when the label is tapped).

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

This will create a tappable Text view which, when tapped, will present a blue rectangle to the screen. When popups are presented, the rest of the contents of the `PopupManager` is grayed-out. By default, tapping outside of the popup view itself will dismiss the popup. Alternate methods for dismissing popups will be covered below.

Because PopupManager is stack-based, a popup view can itself contain a `PopupLink` which will open a new popup. All active popups except the top one is grayed-out.

There are multiple ways to define a PopupLink, and multiple optional parameters that can be used to customize the popup. In the above example, no size information was provided for the popup; this is because sizing of popups is realative to the PopupMangers content and is set to a default value. the parameters `widthMultiplier` and `heightMultiplier` can be set to a value from 0.1 to 1.0(the parameter values are clamped to this range), and specifies that particular dimension realative to the `PopupManager`. The default value for these parameters is 0.75.

### **PopupLink**

---

One alternate PopupLink (example below) alows a `String` to be specified for the label.

```Swift
PopupLink(widthMultiplier: 0.25, "Popup") {
    Rectangle()
        .fill(.red)
}
.font(.largeTitle)
.frame(width: 150, height: 60)
```

In this example, the `widthMultiplier` parameter has been set (the `heightMultiplier` will remain at the default) and a `String` "Popup" has been specified. This will result in the tapple text "Popup" appearing on the screen which will present a red rectangle. The modifiers at the end of the example set the "Popup" text and do not affect the popup view.

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

### **Dismissing popups**

---

As stated before, tapping outside the popup view will dismiss the popup by default. This behavior can be changed by setting the `touchOutsideDismisses` parameter of PopupLink to false. This of course would require an alternate method of dismissing the popup. For this, PopupManager injects the `popupDismiss` EnvironmentValue which can be accessed via the `@Environment(\.popupDismiss)` environment key.

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

## **Known issues**

- Currently popup presentations are animated from the tapped point, not necessarily from the center of the label view. This mostly doesn't seem to matter but if the label is very large, tapping it in different locations causes very different animation effects. This behavior is probably fine as an option but eventually it would be good to have the animations occur from the center of the label view as one, if not the default, behavior.
- More will be added as necessary.