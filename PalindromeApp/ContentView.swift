//
//  ContentView.swift
//  PalindromeApp
//
//  Created by Bruno Silva on 27/04/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var input: String = ""
    @State private var isPalindrome: Bool = false
    @State private var showHowItWorks: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            VStack(spacing: 10) {
                Text("PALINDROME")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.primary)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter string payload")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    HStack {
                        Image(systemName: "textformat")
                            .foregroundStyle(.secondary)
                        TextField("Racecar, Madam, 12321...", text: $input)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .submitLabel(.done)
                            .onSubmit { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) }
                            .onChange(of: input) { oldValue, newValue in
                                let normalized = newValue.lowercased().filter { $0.isLetter || $0.isNumber }
                                isPalindrome = !normalized.isEmpty && normalized == String(normalized.reversed())
                            }
                        if !input.isEmpty {
                            Button {
                                input = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.tertiary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel("Clear input")
                        }
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.background.secondary)
                        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
                )
                .padding(.vertical, 6)
            }
            .frame(maxWidth: .infinity)
            
            Spacer(minLength: 16)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Validation Status")
                    .font(.headline)
                Group {
                    if !input.isEmpty && isPalindrome {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                            Text("SYMMETRICAL STRING")
                        }
                        .foregroundStyle(.green)
                    } else if !input.isEmpty {
                        HStack(spacing: 10) {
                            Image(systemName: "xmark.octagon.fill")
                                .foregroundStyle(.red)
                            Text("ASYMMETRICAL STRING")
                        }
                        .foregroundStyle(.red)
                    } else {
                        HStack(spacing: 10) {
                            Image(systemName: "info.circle")
                                .foregroundStyle(.secondary)
                            Text("Start typing to validate…")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(.thinMaterial)
            )
            .padding(.vertical, 6)
            
            Spacer()

            Button(action: { showHowItWorks = true }) {
                Text("How It Works")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                    .underline()
            }
            .buttonStyle(.plain)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
        .sheet(isPresented: $showHowItWorks) {
            HowItWorksView()
                .presentationDetents([.medium, .large])
        }
        .padding(.horizontal, 24)
    }
}

struct HowItWorksView: View {
    private let code: String = """
    
    let normalized = input
        .lowercased()
        .filter { $0.isLetter || $0.isNumber }

    let isPalindrome = !normalized.isEmpty && normalized == String(normalized.reversed())
    
    """

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Swift Palindrome Check")
                        .font(.headline)
                    Text(code)
                        .font(.system(.body, design: .monospaced))
                        .foregroundStyle(Color.white)
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.ide)
                        .padding(.all, 10)
                }
                .padding()
            }
            .navigationTitle("How It Works")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

