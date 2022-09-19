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
        @Published var errorMessage = ""
        @Published var isSuccessfullySubmitted = false
        
        private var networkingManager: NetworkingManager
        
        init(with networkingManager: NetworkingManager = NetworkingManager.shared) {
            self.networkingManager = networkingManager
        }
        
        func create() {
            
            if firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                print("❌ First Name cannot be empty")
                isError = true
                errorMessage = "❌ First Name cannot be empty"
                return
            }
            
            if lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                print("❌ Last Name cannot be empty")
                isError = true
                errorMessage = "❌ Last Name cannot be empty"
                return
            }
            
            if job.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                print("❌ Job cannot be empty")
                isError = true
                errorMessage = "❌ Job cannot be empty"
                return
            }
            
            let newPerson = NewPerson(firstName: firstName, lastName: lastName, job: job)
            networkingManager.makePostRequest("https://reqres.in/api/users", body: newPerson) { result in
                
                switch result {
                case .success():
                    print("✅ Successfully saved User")
                    self.isSuccessfullySubmitted = true
                case .failure(_):
                    print("❌ Failed to save user")
                    self.isError = true
                    self.errorMessage = "❌ Failed to save user"
                }
            }
        }
    }
}
