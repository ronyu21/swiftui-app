//
//  PageViewHost.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-04.
//

import SwiftUI

struct PageViewHost: View {
    
    let range = (0 ..< 5)
    
    var body: some View {
//        VStack {
//            Spacer()
//            Text("Above")
            
            PageView<DummyView>(
                range.map{DummyView(index: $0)}
            ).frame(width: 300, height: 300)
            
//            Text("Below")
//            Spacer()
//        }
        .navigationBarTitle("Page View Example")
    }
}

struct PageViewHost_Previews: PreviewProvider {
    static var previews: some View {
        PageViewHost()
    }
}
