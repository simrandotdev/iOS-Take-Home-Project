//
//  CreateView.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-15.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                firstName
                lastName
                job
                
                Section {
                   submit
                }
            }
            .navigationTitle("Create")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
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
        TextField("First Name", text: .constant(""))
    }
    
    var lastName: some View {
        TextField("Last Name", text: .constant(""))
    }
    
    var job: some View {
        TextField("Job", text: .constant(""))
    }
    
    var submit: some View {
        Button("Submit") {
            // TODO: Handle action later.
        }
    }
}
