//
//  CreateView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-15.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = CreateView.ViewModel()
    
    var body: some View {
        NavigationView {
            
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Form {
                        firstName
                        lastName
                        job
                        Section {
                           submit
                        }
                    }
                }
            }
            
            .navigationTitle("Create")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .alert(viewModel.error?.errorDescription ?? "Something went wrong.", isPresented: $viewModel.isError, actions: {
                Button("OK", action: {})
            })
            .alert("User created Successfully 😀", isPresented: $viewModel.isSuccessfullySubmitted, actions: {
                Button("OK", action: { dismiss() })
            })
            
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}


private extension CreateView {
    
    var firstName: some View {
        TextField("First Name", text: $viewModel.firstName)
    }
    
    var lastName: some View {
        TextField("Last Name", text: $viewModel.lastName)
    }
    
    var job: some View {
        TextField("Job", text: $viewModel.job)
    }
    
    var submit: some View {
        Button("Submit") {
            viewModel.create()
        }
    }
}
