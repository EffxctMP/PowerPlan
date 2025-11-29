import SwiftUI

struct NumericField: View {
    let title: String
    @Binding var value: String

    var body: some View {
        TextField(title, text: $value)
            .keyboardType(.decimalPad)
            .textInputAutocapitalization(.never)
            .textFieldStyle(FilledRoundedTextFieldStyle())
    }
}

struct FilledRoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}
