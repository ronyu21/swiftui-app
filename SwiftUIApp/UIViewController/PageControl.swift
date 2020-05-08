//
//  PageControl.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-04.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int
        
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        control.pageIndicatorTintColor = UIColor.gray
        control.currentPageIndicatorTintColor = UIColor.blue

        return control
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var parent: PageControl

        init(_ parent: PageControl) {
            self.parent = parent
        }

        @objc func updateCurrentPage(sender: UIPageControl) {
            parent.currentPage = sender.currentPage
        }
    }
}

