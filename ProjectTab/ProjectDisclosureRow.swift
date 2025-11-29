//
//  ProjectDisclosureRow.swift
//  Power Plan
//
//  Created by Matisse Petereyns on 29/11/2025.
//


import SwiftUI

struct ProjectDisclosureRow: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    var tint: Color

    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading, spacing: 8) {

                if !project.voltage.isEmpty {
                    Label(project.voltage, systemImage: "bolt")
                        .foregroundStyle(.secondary)
                }

                if !project.notes.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text(project.notes)
                        .foregroundStyle(.secondary)
                }

                Section(header: Text(L10n.projectEquipmentHeader)) {
                    if project.equipment.isEmpty {
                        Text(L10n.projectEquipmentProjectEmpty)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(project.equipment.indices, id: \.self) { index in
                            EquipmentRow(
                                item: $project.equipment[index],
                                tint: tint
                            )
                            .swipeActions {
                                Button(role: .destructive) {
                                    project.equipment.remove(at: index)
                                } label: {
                                    Label(L10n.delete, systemImage: "trash")
                                }
                            }
                        }
                    }
                }

                EquipmentDraftForm(draft: draft, tint: tint) { item in
                    project.equipment.append(item)
                }
            }
        } label: {
            Text(project.name).font(.headline)
        }
    }
}
