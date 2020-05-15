//
//  Assembler.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-05-08.
//

import Foundation

class Assembler: ContactsSceneAssembler { }

class User {}
class ContactsListViewController {
    
    init(presenter: ContactsListPresenter) {}
}
class ContactsListPresenter {
    init(user: User, getAllContacts: GetAllContacts) {}
}
class GetAllContacts {
    init(contactsDataSource: ContactsDataSource) {}
}
protocol ContactsDataSource {}

class NetworkContactsDataSource: ContactsDataSource {}

protocol ContactsSceneAssembler {
    func resolve(user: User) -> ContactsListViewController

    func resolve(user: User) -> ContactsListPresenter

    func resolve() -> GetAllContacts

    func resolve() -> ContactsDataSource
}

extension ContactsSceneAssembler {
    func resolve(user: User) -> ContactsListViewController {
        // Nice! We can and must use the assembler itself to resolve the dependencies
        return ContactsListViewController(presenter: resolve(user: user))
    }

    func resolve(user: User) -> ContactsListPresenter {
        return ContactsListPresenter(user: user, getAllContacts: resolve())
    }

    func resolve() -> GetAllContacts {
        return GetAllContacts(contactsDataSource: resolve())
    }

    func resolve() -> ContactsDataSource {
        return NetworkContactsDataSource()
    }
}

class StubContactsDataSource: ContactsDataSource {}

class TestAssembler: ContactsSceneAssembler {
    func resolve() -> ContactsDataSource {
        return StubContactsDataSource()
    }
}
