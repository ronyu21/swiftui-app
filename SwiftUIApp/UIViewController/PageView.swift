//
//  PageView.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-04.
//

import SwiftUI

struct DummyView: View {
    
    var index: Int
    
    var body: some View {
        Text("Hello, World! \(index)")
            .frame(width: 300, height: 300)
            .background(Color.gray)
            .transition(AnyTransition.opacity.animation(.easeInOut))
//            .border(Color.black, width: 1)
    }
}

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    @State var currentPage = 0
    
    init(_ views: [Page], pageController: PageControl? = nil){
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        let views = [
            DummyView(index: 0),
            DummyView(index: 1),
            DummyView(index: 2),
            DummyView(index: 3),
            DummyView(index: 4)
        ]
        return PageView(views.map { $0 })
    }
}
