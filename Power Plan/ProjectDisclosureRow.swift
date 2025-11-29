import SwiftUI

struct ProjectDisclosureRow: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    var tint: Color

    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading, spacing: 12) {
                if !project.voltage.isEmpty {
                    Label(project.voltage, systemImage: "bolt")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if !project.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    Text(project.notes)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Divider()

                Section(header: Text(L10n.projectEquipmentHeader)) {
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
