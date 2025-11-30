import SwiftUI

struct ProjectDisclosureRow: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    @Binding var isEditing: Bool
    var tint: Color
    var isSelecting: Bool = false
    var isSelected: Bool = false
    var toggleSelection: () -> Void = {}

    var body: some View {
        DisclosureGroup {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(L10n.projectDetails)
                        .font(.headline)
                    Spacer()
                    Button {
                        withAnimation { isEditing.toggle() }
                    } label: {
                        Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle")
                            .font(.title3)
                    }
                    .buttonStyle(.borderless)
                    .accessibilityLabel(isEditing ? L10n.projectsEditingDone : L10n.projectsEditingStart)
                }

                if isEditing {
                    TextField(L10n.projectName, text: $project.name)
                        .textInputAutocapitalization(.words)

                    TextField(L10n.projectVoltage, text: $project.voltage)
                        .textInputAutocapitalization(.never)

                    TextField(L10n.projectNotes, text: $project.notes, axis: .vertical)
                        .lineLimit(2, reservesSpace: true)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        infoRow(
                            title: L10n.projectVoltage,
                            value: project.voltage,
                            systemImage: "bolt"
                        )

                        infoRow(
                            title: L10n.projectNotes,
                            value: project.notes,
                            systemImage: "text.alignleft"
                        )
                    }
                }

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
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                if isSelecting {
                    Button(action: toggleSelection) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(isSelected ? tint : .secondary)
                            .imageScale(.large)
                    }
                    .buttonStyle(.plain)
                }

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

    @ViewBuilder
    private func infoRow(title: String, value: String, systemImage: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Label(title, systemImage: systemImage)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "—" : value)
                .font(.body)
                .multilineTextAlignment(.leading)
        }
    }
}
