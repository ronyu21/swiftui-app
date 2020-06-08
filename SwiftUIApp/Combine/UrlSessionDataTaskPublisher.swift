//
//  UrlSessionDataTaskPublisher.swift
//  SwiftUIApp
//
//  Created by Ron Yu on 2020-06-07.
//

import SwiftUI
import Combine


// Reference https://www.vadimbulavin.com/swift-combine-framework-tutorial-getting-started/
struct UrlSessionDataTaskPublisher: View {
    
    @State var user = ""
    
    @State var cancellable: AnyCancellable?
    
    @State var repos: [Repository] = []
    
    var body: some View {
        VStack{
            Text("Url Session Data Task Publisher")

            Text("User: \(user)")
            
            Text("Number of Repos: \(repos.count)")
            
            List(repos) { repo in
                Text(repo.name)
            }
        }
            .onAppear(){
                self.user = "ronyu21"
                
                let url = URL(string: "https://api.github.com/users/\(self.user)/repos")!
                
                self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data } // 3
                    .decode(type: [Repository].self, decoder: JSONDecoder())
                    .sink(receiveCompletion: { completion in
                        print(completion)
                    }, receiveValue: { repositories in
                        self.repos.append(contentsOf: repositories)
                    })
        }
    }
}

struct UrlSessionDataTaskPublisher_Previews: PreviewProvider {
    static var previews: some View {
        UrlSessionDataTaskPublisher()
    }
}


struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}
