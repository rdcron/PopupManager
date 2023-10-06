//
//  Page1View.swift
//  PopupManagerExample
//
//  Created by Richard Cron on 10/5/23.
//

import SwiftUI
import PopupManager

struct Page1View: View {
    var body: some View {
        GeometryReader { geo in
            PopupManager {
                    ZStack {
                        Color("AppBackground")
                            .ignoresSafeArea()
                        VStack {
                            HStack {
                                IntroView()
                                    .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
//                                        .padding()
                                
                                BasicsView()
                                    .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
//                                        .padding()
                            }
                            .padding()
                            
                            HStack {
                                DismissView()
                                    .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
//                                        .padding()
                                
                                DataPassingView()
                                    .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.4)
//                                        .padding()
                            }
//                                .padding()
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            .navigationTitle("PopupManager")
        }
    }
}

struct Page1View_Previews: PreviewProvider {
    static var previews: some View {
        Page1View()
    }
}
