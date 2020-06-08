//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-04.
//  Copyright © 2020 Nubix. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let views = [
        DummyView(index: 0),
        DummyView(index: 1),
        DummyView(index: 2),
        DummyView(index: 3),
        DummyView(index: 4)
        
    ]
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(NSLocalizedString("Image Picker Example", comment: "Image Picker Example"), destination: ImagePickerExampleView())
                
                NavigationLink(NSLocalizedString("Page View Example", comment: "Page View Example"), destination: PageViewHost())
                
                NavigationLink(NSLocalizedString("QR Code Generator", comment: "QR Code Generator"), destination: QrCodeGeneratorView())
                
                NavigationLink("Notification Center", destination: NotificationCenterExample())
                
                NavigationLink("Redux Counter", destination: ReduxCounterExample())
                
                NavigationLink("Custom Container", destination: CustomContainer())
                
                NavigationLink("View Communication", destination: ViewCommunications())
                
                NavigationLink("Combine", destination: CombineExamples())
            }
            .navigationBarTitle(NSLocalizedString("Examples", comment:"examples"))
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
