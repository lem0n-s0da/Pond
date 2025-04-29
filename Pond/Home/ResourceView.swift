//
//  ResourceView.swift
//  Pond
//
//  Created by HPro2 on 4/3/25.
//

import SwiftUI

struct Resource: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
}

struct ResourceView: View {
    let resources: [Resource] = [
        Resource(name: "Suicide and Crisis Lifeline", phoneNumber: "988"),
        Resource(name: "Crisis Text Line (Text \"HOME\")", phoneNumber: "741741"),
        Resource(name: "LGBTQ+ Crisis Line (Trevor Project)", phoneNumber: "1-866-488-7386"),
        Resource(name: "Sexual Assault Hotline (RAINN)", phoneNumber: "1-800-656-4673"),
        Resource(name: "National Domestic Violence Hotline", phoneNumber: "1-800-799-7233"),
        Resource(name: "Veterans Crisis Line", phoneNumber: "1-800-273-8255")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(resources) { resource in
                        ResourceCard(resource: resource)
                    }
                }
                .padding()
            }
            .navigationTitle("Resources")
        }
    }
    
    func callNumber(_ number: String) {
        let formattedString = "tel://" + number.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        if let url = URL(string: formattedString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct ResourceCard: View {
    let resource: Resource
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(resource.name)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Button(action: {
                callNumber(resource.phoneNumber)
            }) {
                Text(resource.phoneNumber)
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .underline()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.mint.opacity(0.1)))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
    
    func callNumber(_ number: String) {
        let formattedString = "tel://" + number.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
        if let url = URL(string: formattedString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct ResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        ResourceView()
    }
}

#Preview {
    ResourceView()
}
