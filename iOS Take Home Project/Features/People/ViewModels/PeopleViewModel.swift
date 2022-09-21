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
        @Published var isError = false
        @Published var error: AppError? = nil
        
        private var networkingManager: NetworkingManager
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        @MainActor
        func fetchPeople(waitFor time: Double = 1.5) async {
            
            viewState = .loading
            do {
                let response = try await networkingManager.makeGetRequest(.people, type: UsersResponse.self)
                    
                DispatchQueue.main.async {
                    self.people = response.data
                    self.viewState = .success
                }
            }
            catch {
                isError = true
                
                if let error = error as? CreateValidatorErrors {
                    self.error = AppError(withMessage: error.errorDescription)
                } else {
                    self.error = AppError(withMessage: "Something went wrong, please try again.")
                }
            }
        }
    }
}
