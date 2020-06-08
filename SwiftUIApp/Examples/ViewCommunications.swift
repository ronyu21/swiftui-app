//
//  ViewCommunications.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-07.
//

import SwiftUI

struct ViewCommunications: View {
    var body: some View {
        
        /// Good Rule of Thumb
        /*
         + From parent to direct child – use an initializer.
         + From parent to distant child – use @Environment.
         + From child to direct parent – use @Binding and callbacks.
         + From child to distant parent – use PreferenceKey.
         + Between children – lift the state up.
         */
        
        List{
            NavigationLink("Parent To Distant Child by Environemnt", destination: ViewCommEnvironment())
            
            NavigationLink("Child to Distant Parent by Environemnt", destination: ViewCommPreferenceKey())
        }
    }
}

struct ViewCommunications_Previews: PreviewProvider {
    static var previews: some View {
        ViewCommunications()
    }
}
