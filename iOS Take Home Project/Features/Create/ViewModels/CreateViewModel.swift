//
//  CreateViewModel.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//

import Foundation

extension CreateView {
    
    class ViewModel: ObservableObject {
        
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var job = ""
        @Published var isError = false
        @Published var error: AppError? = nil
        @Published var isSuccessfullySubmitted = false
        @Published var isLoading = false
        
        private var networkingManager: NetworkingManager
        private var createValidator: CreateValidator
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared, createValidator: CreateValidator = CreateValidator()) {
            self.networkingManager = networkingManager
            self.createValidator = createValidator
        }
        
        @MainActor
        func create() async {
            do {
                let newPerson = NewPerson(firstName: firstName, lastName: lastName, job: job)
                try createValidator.validate(newPerson)
                
                isLoading = true
                
                try await networkingManager.makePostRequest(.create(body: newPerson))
                
                DispatchQueue.main.async {
                    print("✅ Successfully saved User")
                    self.isSuccessfullySubmitted = true
                    self.isLoading = false
                }
                
            }
            catch {
                isError = true
                self.isLoading = false
                if let error = error as? CreateValidatorErrors {
                    self.error = AppError(withMessage: error.errorDescription)
                } else {
                    self.error = AppError(withMessage: "Something went wrong, please try again.")
                }
            }
        }
    }
}
