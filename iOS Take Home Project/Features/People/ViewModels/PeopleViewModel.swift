//
//  PeopleViewModel.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//

import Foundation


extension PeopleView {
    
    final class ViewModel: ObservableObject {
        
        @Published var people: [User] = []
        @Published var viewState: ViewState = .empty
        
        private var networkingManager: NetworkingManager
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        func fetchPeople(waitFor time: Double = 1.5) {
            
            viewState = .loading
            
            self.networkingManager.makeGetRequest("https://reqres.in/api/users?page=1&per_page=20&delay=1.75",
                                             type: UsersResponse.self) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                    DispatchQueue.main.async {
                        self.people = response.data
                        self.viewState = .success
                    }
                case .failure(let error):
                    print(error)
                    self.viewState = .error(error: error)
                }
            }
        }
    }
}
