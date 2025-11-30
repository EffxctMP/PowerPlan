import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.EquipmentDraft>
    @Binding var isEditing: Bool
    var tint: Color

    @State private var isSelectingEquipment = false
    @State private var equipmentSelection = Set<ProjectsView.EquipmentItem.ID>()

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
        .toolbar { toolbarMenu }
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
                        equipmentRow(at: index)
                        if index < project.equipment.indices.last ?? 0 {
                            Divider()
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

    @ViewBuilder
    private var toolbarMenu: some View {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Button {
                    withAnimation { isEditing.toggle() }
                } label: {
                    Label(
                        isEditing ? L10n.projectsEditingDone : L10n.projectsEditingStart,
                        systemImage: isEditing ? "checkmark.circle" : "pencil"
                    )
                }

                Button {
                    withAnimation {
                        isSelectingEquipment.toggle()
                        if !isSelectingEquipment {
                            equipmentSelection.removeAll()
                        }
                    }
                } label: {
                    Label(
                        isSelectingEquipment ? L10n.projectsSelectionDone : L10n.projectsSelectionStart,
                        systemImage: "checklist"
                    )
                }

                Button(role: .destructive) {
                    removeSelectedEquipment()
                } label: {
                    Label(L10n.projectsDeleteSelected, systemImage: "trash")
                }
                .disabled(equipmentSelection.isEmpty)
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .accessibilityLabel(L10n.projectsMoreActions)
        }
    }

    @ViewBuilder
    private func equipmentRow(at index: Int) -> some View {
        let itemID = project.equipment[index].id

        HStack(spacing: 12) {
            if isSelectingEquipment {
                Button(action: { toggleEquipmentSelection(itemID) }) {
                    Image(systemName: equipmentSelection.contains(itemID) ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(equipmentSelection.contains(itemID) ? tint : .secondary)
                        .imageScale(.large)
                }
                .buttonStyle(.plain)
            }

            EquipmentRow(item: $project.equipment[index], tint: tint)
                .allowsHitTesting(!isSelectingEquipment)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isSelectingEquipment {
                toggleEquipmentSelection(itemID)
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                removeEquipment(withID: itemID)
            } label: {
                Label(L10n.delete, systemImage: "trash")
            }
        }
    }

    private func toggleEquipmentSelection(_ id: ProjectsView.EquipmentItem.ID) {
        if equipmentSelection.contains(id) {
            equipmentSelection.remove(id)
        } else {
            equipmentSelection.insert(id)
        }
    }

    private func removeEquipment(withID id: ProjectsView.EquipmentItem.ID) {
        withAnimation {
            project.equipment.removeAll { $0.id == id }
            equipmentSelection.remove(id)
        }
    }

    private func removeSelectedEquipment() {
        guard !equipmentSelection.isEmpty else { return }
        withAnimation {
            project.equipment.removeAll { equipmentSelection.contains($0.id) }
            equipmentSelection.removeAll()
            isSelectingEquipment = false
        }
    }
}

