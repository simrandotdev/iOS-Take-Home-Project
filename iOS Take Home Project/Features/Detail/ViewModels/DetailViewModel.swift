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
        @Published var isError = false
        @Published var error: AppError? = nil
        
        private var networkingManager: Networking
        
        init(with networkingManager: Networking = NetworkingManager()) {
            self.networkingManager = networkingManager
        }
        
        @MainActor
        func fetchDetails(withId id: Int, andTime time: Double = 1.5) async {
            viewState = .loading
            
            do {
                let response = try await networkingManager.makeGetRequest(.detail(id: id),
                                                                      type: UserDetailResponse.self)
                DispatchQueue.main.async {
                    self.user = response.data
                    self.viewState = .success
                }
                
            } catch {
                isError = true
                
                if let error = error as? CreateValidatorErrors {
                    self.error = AppError(withMessage: error.errorDescription)
                    self.viewState = .error(error: error)
                } else {
                    self.error = AppError(withMessage: "Something went wrong, please try again.")
                    self.viewState = .error(error: error)
                    self.viewState = .error(error: error)
                }
            }
        }
    }
}
