//
//  SwiftUIView.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-07.
//

import SwiftUI

struct CombineExamples: View {
    var body: some View {
        List{
            NavigationLink("URL Session Data Task Publisher", destination: UrlSessionDataTaskPublisher())
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CombineExamples()
    }
}
