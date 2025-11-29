//
//  EquipmentRow.swift
//  Power Plan
//
//  Created by Matisse Petereyns on 29/11/2025.
//


import SwiftUI

struct EquipmentRow: View {
    @Binding var item: ProjectsView.EquipmentItem
    var tint: Color

    var body: some View {
        HStack(alignment: .top) {
            Button { item.acquired.toggle() } label: {
                Image(systemName: item.acquired ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.acquired ? tint : .secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading) {
                Text(item.title).font(.body)
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
}
