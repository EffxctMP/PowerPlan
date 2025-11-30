import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: ProjectsView.Project
    var draft: Binding<ProjectsView.ComponentDraft>
    @Binding var isEditing: Bool
    var tint: Color
    @State private var isSelectingComponents = false
    @State private var selectedComponents = Set<ProjectsView.ComponentItem.ID>()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                projectInfoCard
                componentCard
            }
            .padding()
        }
        .navigationTitle(project.name.isEmpty ? L10n.projectDetails : project.name)
        .groupBoxStyle(.card)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isSelectingComponents {
                    Button(role: .destructive, action: deleteSelectedComponents) {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .disabled(selectedComponents.isEmpty)
                }
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    Button {
                        withAnimation { isEditing = false }
                    } label: {
                        Label(L10n.projectsEditingDone, systemImage: "checkmark.circle")
                    }
                }
            }

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
                        toggleComponentSelectionMode()
                    } label: {
                        Label(
                            isSelectingComponents ? L10n.componentSelectionDone : L10n.componentSelectionStart,
                            systemImage: "checklist"
                        )
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
                .accessibilityLabel(L10n.projectComponentActions)
            }
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

    private var componentCard: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(L10n.projectComponentHeader)
                        .font(.headline)
                    Spacer()
                }

                if project.components.isEmpty {
                    Text(L10n.projectComponentProjectEmpty)
                        .foregroundStyle(.secondary)
                } else {
                    let groups = componentGroups
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(groups.enumerated()), id: \.element.category) { groupIndex, group in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(group.category.title)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                ForEach(group.indices, id: \.self) { index in
                                    componentRow(for: index)
                                    if index != group.indices.last { Divider() }
                                }
                            }

                            if groupIndex != groups.indices.last { Divider() }
                        }
                    }
                }

                Divider()

                ComponentDraftForm(
                    draft: draft,
                    tint: tint
                ) { newItem in
                    project.components.append(newItem)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    @ViewBuilder
    private func componentRow(for index: Int) -> some View {
        let itemID = project.components[index].id
        ComponentRow(
            item: $project.components[index],
            tint: tint,
            isSelecting: isSelectingComponents,
            isSelected: selectedComponents.contains(itemID),
            toggleSelection: { toggleComponentSelection(itemID) }
        )
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                removeComponent(at: index)
            } label: {
                Label(L10n.delete, systemImage: "trash")
            }
        }
    }

    private var componentGroups: [(category: ProjectsView.ComponentCategory, indices: [Int])] {
        let grouped = Dictionary(grouping: project.components.indices, by: { project.components[$0].category })
        return grouped.keys.sorted { $0.title < $1.title }.compactMap { category in
            guard let indices = grouped[category]?.sorted() else { return nil }
            return (category, indices)
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

    private func toggleComponentSelection(_ id: ProjectsView.ComponentItem.ID) {
        if selectedComponents.contains(id) {
            selectedComponents.remove(id)
        } else {
            selectedComponents.insert(id)
        }
    }

    private func toggleComponentSelectionMode() {
        withAnimation {
            isSelectingComponents.toggle()
            if !isSelectingComponents {
                selectedComponents.removeAll()
            }
        }
    }

    private func deleteSelectedComponents() {
        guard !selectedComponents.isEmpty else { return }
        withAnimation {
            project.components.removeAll { selectedComponents.contains($0.id) }
            selectedComponents.removeAll()
            isSelectingComponents = false
        }
    }

    private func removeComponent(at index: Int) {
        let removedID = project.components[index].id
        project.components.remove(at: index)
        selectedComponents.remove(removedID)
    }
}

