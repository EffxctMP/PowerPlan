import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    @Binding var isEditing: Bool
    var tint: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                projectInfoCard
                equipmentCard
            }
            .padding()
        }
        .navigationTitle(project.name.isEmpty ? L10n.projectDetails : project.name)
        .groupBoxStyle(.card)
        .toolbar {
            Button {
                withAnimation { isEditing.toggle() }
            } label: {
                Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil.circle")
            }
            .accessibilityLabel(isEditing ? L10n.projectsEditingDone : L10n.projectsEditingStart)
        }
    }

    private var projectInfoCard: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(L10n.projectDetails)
                        .font(.headline)
                    Spacer()
                }

                if isEditing {
                    TextField(L10n.projectName, text: $project.name)
                        .textInputAutocapitalization(.words)

                    TextField(L10n.projectVoltage, text: $project.voltage)
                        .textInputAutocapitalization(.never)

                    TextField(L10n.projectNotes, text: $project.notes, axis: .vertical)
                        .lineLimit(2, reservesSpace: true)
                } else {
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
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var equipmentCard: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(L10n.projectEquipmentHeader)
                        .font(.headline)
                    Spacer()
                }

                if project.equipment.isEmpty {
                    Text(L10n.projectEquipmentProjectEmpty)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(project.equipment.enumerated()), id: \.element.id) { index, _ in
                        EquipmentRow(item: $project.equipment[index], tint: tint)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    project.equipment.remove(at: index)
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
            .frame(maxWidth: .infinity, alignment: .leading)
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

