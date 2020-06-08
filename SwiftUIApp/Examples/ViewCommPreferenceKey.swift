//
//  VIewCommPreferenceKey.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-07.
//

import SwiftUI

struct ViewCommPreferenceKey: View {
    @State private var alert: PresentableAlert?
    
    var body: some View {
        IntermediateView()
            .onPreferenceChange(AlertPreferenceKey.self) { self.alert = $0 }
            .alert(item: $alert) { alert in
                Alert(title: Text(alert.title), message: alert.message.map(Text.init))
        }
    }
}

struct ViewCommPreferenceKey_Previews: PreviewProvider {
    static var previews: some View {
        ViewCommPreferenceKey()
    }
}


struct AlertPreferenceKey: PreferenceKey {
    static var defaultValue: PresentableAlert?

    static func reduce(value: inout PresentableAlert?, nextValue: () -> PresentableAlert?) {
        value = nextValue()
    }
}


struct PresentableAlert: Equatable, Identifiable {
    let id = UUID()
    let title: String
    let message: String?
    
    static func == (lhs: PresentableAlert, rhs: PresentableAlert) -> Bool {
        lhs.id == rhs.id
    }
}

struct ViewWithAlert: View {
    @State private var alert: PresentableAlert?
    
    var body: some View {
        Button("Show alert", action: { self.alert = PresentableAlert(title: "Title", message: "Message") })
            .preference(key: AlertPreferenceKey.self, value: alert)
    }
}

struct HelloWorldView: View {
    var body: some View {
        ZStack {
            Color.yellow
            VStack {
                Text("Hello, World!")
                ViewWithAlert()
            }
        }
    }
}

struct IntermediateView: View {
    var body: some View {
        HelloWorldView()
    }
}
