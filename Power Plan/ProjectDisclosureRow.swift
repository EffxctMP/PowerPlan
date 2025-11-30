import SwiftUI

struct ProjectDisclosureRow: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    var tint: Color

    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading, spacing: 12) {
                TextField(L10n.projectName, text: $project.name)
                    .textInputAutocapitalization(.words)

                TextField(L10n.projectVoltage, text: $project.voltage)
                    .textInputAutocapitalization(.never)

                TextField(L10n.projectNotes, text: $project.notes, axis: .vertical)
                    .lineLimit(2, reservesSpace: true)

                Divider()

                if project.equipment.isEmpty {
                    Text(L10n.projectEquipmentProjectEmpty)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(project.equipment.indices, id: \.self) { equipmentIndex in
                        EquipmentRow(item: $project.equipment[equipmentIndex], tint: tint)
                            .swipeActions {
                                Button(role: .destructive) {
                                    project.equipment.remove(at: equipmentIndex)
                                } label: {
                                    Label(L10n.delete, systemImage: "trash")
                                }
                            }
                    }
                }

                Divider()

                EquipmentDraftForm(
                    draft: draft,
                    tint: tint
                ) { newItem in
                    project.equipment.append(newItem)
                }
            }
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(project.name)
                    .font(.headline)
                if !project.voltage.isEmpty {
                    Text(project.voltage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}
