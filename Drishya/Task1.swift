//  Task1.swift
//  Drishya
//  Created by UDIT PANDEY on 12/10/26.

import SwiftUI

struct Task1: View {
    @State private var viewModel = formsViewModel()

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    ForEach($viewModel.forms) { $form in
                        TaskOneHelpher(
                            form: $form,
                            onDelete: viewModel.forms.count > 1
                                ? { viewModel.removeForm(id: form.id) }
                                : nil,
                            errors: viewModel.errors[form.id] ?? [:]
                        )
                        .id(form.id)
                    }

                    Button {
                        viewModel.addForm()
                    } label: {
                        Text("Add New Forms")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            }
                    }

                    Button {
                        viewModel.save()
                    } label: {
                        Text("Save Data")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.red)
                            .padding(.vertical, 12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 1)
                            }
                    }
                }
                .font(.headline)            
                .padding(.horizontal, 10 )
            }
            .scrollDismissesKeyboard(.interactively)
//            .onChange(of: viewModel.forms.count) { oldCount, newCount in
//                guard newCount > oldCount, let last = viewModel.forms.last else { return }
//                withAnimation {
//                    proxy.scrollTo(last.id, anchor: .bottom)
//                }
            //}
        }
    }
}

#Preview {
    Task1()
}
