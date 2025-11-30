import SwiftUI

struct ComponentRow: View {
    @Binding var item: ProjectsView.ComponentItem
    var tint: Color
    var isSelecting: Bool = false
    var isSelected: Bool = false
    var toggleSelection: () -> Void = {}

    var body: some View {
        Button(action: isSelecting ? toggleSelection : { item.acquired.toggle() }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: leadingIcon)
                    .foregroundStyle(leadingStyle)
                    .font(isSelecting ? .title3 : .body)
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
                Text(L10n.componentQuantityValue(item.quantity))
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(item.title)
        .accessibilityHint(isSelecting ? L10n.componentSelectionHint : L10n.componentMarkHint)
    }

    private var leadingIcon: String {
        if isSelecting {
            return isSelected ? "checkmark.circle.fill" : "circle"
        }
        return item.acquired ? "checkmark.circle.fill" : "circle"
    }

    private var leadingStyle: some ShapeStyle {
        if isSelecting {
            return isSelected ? tint : Color.secondary
        }
        return item.acquired ? tint : Color.secondary
    }
}
