import SwiftUI

struct EquipmentRow: View {
    @Binding var item: ProjectsView.EquipmentItem
    var tint: Color

    var body: some View {
        Button(action: { item.acquired.toggle() }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: item.acquired ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.acquired ? tint : Color.secondary)
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.body)
                    if !item.detailLine.isEmpty {
                        Text(item.detailLine)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                Text(L10n.equipmentQuantityValue(item.quantity))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.title)
        .accessibilityHint(L10n.equipmentMarkHint)
    }
}
