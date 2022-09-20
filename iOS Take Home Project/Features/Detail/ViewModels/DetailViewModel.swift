//
//  DetailViewModel.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//

import Foundation

extension DetailView {
    
    class ViewModel: ObservableObject {
        
        @Published var viewState: ViewState = .empty
        @Published var user: User? = nil
        
        private var networkingManager: NetworkingManager
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        func fetchDetails(withId id: Int, andTime time: Double = 1.5) {
            viewState = .loading
            
            networkingManager.makeGetRequest("https://reqres.in/api/users/\(id)?delay=1.75",
                                             type: UserDetailResponse.self) { [weak self] result in
                
                guard let self = self else { return }
                
                switch result {
                    
                case .success(let response):
                    DispatchQueue.main.async {
                        self.user = response.data
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
