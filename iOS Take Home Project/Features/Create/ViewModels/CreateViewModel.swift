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
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        func create() {
            
            if firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                
                isError = true
                error = AppError(withMessage: "❌ First Name cannot be empty")
                return
            }
            
            if lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

                isError = true
                error = AppError(withMessage: "❌ Last Name cannot be empty")
                return
            }
            
            if job.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                
                isError = true
                error = AppError(withMessage: "❌ Job cannot be empty")
                return
            }
            
            isLoading = true
            let newPerson = NewPerson(firstName: firstName, lastName: lastName, job: job)
            networkingManager.makePostRequest("https://reqres.in/api/users?delay=1.5", body: newPerson) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        print("✅ Successfully saved User")
                        self.isSuccessfullySubmitted = true
                        self.isLoading = false
                    case .failure(let appError):
                        print("❌ Failed to save user")
                        self.isError = true
                        self.error = appError
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
