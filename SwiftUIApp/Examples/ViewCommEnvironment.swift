//
//  ViewCommEnvironment.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-06.
//

import SwiftUI

struct ViewCommEnvironment: View {
    @Environment(\.todoItems) var items: [TodoItem]
    var body: some View {
        ParentView()
        /// Example for setting the todoItems at the view
//            .environment(\.todoItems,
//            [
//                TodoItem(title: "from root item 1"),
//                TodoItem(title: "from root item 2"),
//                TodoItem(title: "from root item 3"),
//                TodoItem(title: "from root item 4"),
//            ])
    }
}

struct ViewCommEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        ViewCommEnvironment()
    }
}

struct ParentView: View {
    
    var body: some View {
        TodoList()
    }
}

struct TodoItemsKey: EnvironmentKey {
    static let defaultValue: [TodoItem] = [
        TodoItem(title: "item 1"),
        TodoItem(title: "item 2"),
        TodoItem(title: "item 3"),
        TodoItem(title: "item 4"),
    ]
}

extension EnvironmentValues {
    var todoItems: [TodoItem] {
        get { self[TodoItemsKey.self] }
        set { self[TodoItemsKey.self] = newValue } // for setting the values using .environment() method
    }
}

struct TodoList: View {

    @Environment(\.todoItems) var items: [TodoItem]
    
    var body: some View {
        List(items) { item in
            TodoItemView(item: item)
        }
    }
}

struct TodoItemView: View {
     
    let item: TodoItem
    
    var body: some View {
        Text(item.title)
    }
}

struct TodoItem: Identifiable {
    let id = UUID()
    let title: String
}
