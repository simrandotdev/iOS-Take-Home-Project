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
        @Published var isLoading: Bool = false
        
        private var networkingManager: NetworkingManager
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        func fetchPeople(waitFor time: Double = 1.5) {
            
            isLoading = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + time) { [weak self] in
                
                guard let self = self else { return }
                
                self.networkingManager.request("https://reqres.in/api/users?page=1&per_page=20",
                                                 type: UsersResponse.self) { [weak self] result in
                    
                    guard let self = self else { return }
                    
                    switch result {
                        
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.people += response.data
                            self.isLoading = false
                        }
                    case .failure(let error):
                        print(error)
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
