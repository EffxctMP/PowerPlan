package com.powerplan.projects

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Checklist
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material.icons.filled.Notes
import androidx.compose.material.icons.filled.Power
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Card
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.mapSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import com.powerplan.components.ComponentDraft
import com.powerplan.components.ComponentDraftForm
import com.powerplan.components.ComponentItem
import com.powerplan.components.ComponentRow
import java.util.UUID

/**
 * Jetpack Compose recreation of the SwiftUI `ProjectDetailView`.
 *
 * Drop this file into an Android Studio project to mirror the project
 * detail experience from the iOS app: editable project metadata, grouped
 * component lists with acquisition tracking, bulk selection, and inline
 * component creation powered by the existing `ComponentDraftForm`.
 */
@Composable
fun ProjectDetailView(
    project: Project,
    modifier: Modifier = Modifier,
    tint: Color = MaterialTheme.colorScheme.primary,
    onProjectChange: (Project) -> Unit = {}
) {
    var editableProject by rememberSaveable(stateSaver = Project.Saver) {
        mutableStateOf(project)
    }
    var isEditing by rememberSaveable { mutableStateOf(false) }
    var isSelectingComponents by rememberSaveable { mutableStateOf(false) }
    var selectedComponents by rememberSaveable { mutableStateOf(setOf<UUID>()) }

    LaunchedEffect(project) { editableProject = project }

    Column(
        modifier = modifier.padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        HeaderRow(
            project = editableProject,
            isEditing = isEditing,
            isSelecting = isSelectingComponents,
            onToggleEditing = { isEditing = !isEditing },
            onToggleSelection = {
                isSelectingComponents = !isSelectingComponents
                if (!isSelectingComponents) selectedComponents = emptySet()
            },
            onDeleteSelected = {
                editableProject = editableProject.copy(
                    components = editableProject.components.filterNot { selectedComponents.contains(it.id) }
                )
                onProjectChange(editableProject)
                selectedComponents = emptySet()
                isSelectingComponents = false
            }
        )

        ProjectInfoCard(
            project = editableProject,
            isEditing = isEditing,
            onProjectChange = {
                editableProject = it
                onProjectChange(it)
            }
        )

        ComponentCard(
            project = editableProject,
            tint = tint,
            isSelecting = isSelectingComponents,
            selectedComponents = selectedComponents,
            onSelectToggle = { id ->
                selectedComponents = selectedComponents.toMutableSet().also { set ->
                    if (set.contains(id)) set.remove(id) else set.add(id)
                }
            },
            onToggleAcquired = { updated ->
                editableProject = editableProject.copy(
                    components = editableProject.components.map { item ->
                        if (item.id == updated.id) updated else item
                    }
                )
                onProjectChange(editableProject)
            },
            onAddComponent = { item ->
                editableProject = editableProject.copy(components = editableProject.components + item)
                onProjectChange(editableProject)
            }
        )
    }
}

@Composable
private fun HeaderRow(
    project: Project,
    isEditing: Boolean,
    isSelecting: Boolean,
    onToggleEditing: () -> Unit,
    onToggleSelection: () -> Unit,
    onDeleteSelected: () -> Unit
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
            Text(
                text = if (project.name.isBlank()) "Project" else project.name,
                style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
            )
            Text(
                text = project.voltage.ifBlank { "—" },
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }

        Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            AssistChip(
                onClick = onToggleEditing,
                label = { Text(text = if (isEditing) "Done" else "Edit") },
                leadingIcon = {
                    Icon(
                        imageVector = if (isEditing) Icons.Filled.Check else Icons.Filled.Edit,
                        contentDescription = null
                    )
                }
            )

            AssistChip(
                onClick = onToggleSelection,
                label = { Text(text = if (isSelecting) "Done" else "Select") },
                leadingIcon = {
                    Icon(
                        imageVector = Icons.Filled.Checklist,
                        contentDescription = null
                    )
                }
            )

            IconButton(
                onClick = onDeleteSelected,
                enabled = isSelecting,
                content = {
                    Icon(
                        imageVector = Icons.Filled.Delete,
                        contentDescription = null,
                        tint = if (isSelecting) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            )
        }
    }
}

@Composable
private fun ProjectInfoCard(
    project: Project,
    isEditing: Boolean,
    onProjectChange: (Project) -> Unit
) {
    Card(shape = RoundedCornerShape(16.dp)) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text(
                text = "Project details",
                style = MaterialTheme.typography.titleMedium
            )

            if (isEditing) {
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text(text = "Project name") },
                    value = project.name,
                    onValueChange = { onProjectChange(project.copy(name = it)) }
                )
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text(text = "Supply voltage") },
                    value = project.voltage,
                    onValueChange = { onProjectChange(project.copy(voltage = it)) }
                )
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text(text = "Notes") },
                    value = project.notes,
                    onValueChange = { onProjectChange(project.copy(notes = it)) },
                    minLines = 2
                )
            } else {
                InfoRow(
                    icon = Icons.Filled.Power,
                    title = "Voltage",
                    value = project.voltage
                )
                InfoRow(
                    icon = Icons.Filled.Notes,
                    title = "Notes",
                    value = project.notes
                )
            }
        }
    }
}

@Composable
private fun ComponentCard(
    project: Project,
    tint: Color,
    isSelecting: Boolean,
    selectedComponents: Set<UUID>,
    onSelectToggle: (UUID) -> Unit,
    onToggleAcquired: (ComponentItem) -> Unit,
    onAddComponent: (ComponentItem) -> Unit
) {
    Card(shape = RoundedCornerShape(16.dp)) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text(
                text = "Components",
                style = MaterialTheme.typography.titleMedium
            )

            if (project.components.isEmpty()) {
                Text(
                    text = "No component logged for this project.",
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            } else {
                Surface(shape = RoundedCornerShape(12.dp), tonalElevation = 1.dp) {
                    LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        componentGroups(project).forEach { (category, items) ->
                            item("header-${category.title}") {
                                Text(
                                    text = category.title,
                                    style = MaterialTheme.typography.labelLarge,
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                    modifier = Modifier
                                        .fillMaxWidth()
                                        .padding(top = 12.dp, start = 16.dp, end = 16.dp)
                                )
                            }
                            itemsIndexed(items, key = { _, item -> item.id }) { index, item ->
                                ComponentRow(
                                    item = item,
                                    tint = tint,
                                    isSelecting = isSelecting,
                                    isSelected = selectedComponents.contains(item.id),
                                    onToggleSelection = { onSelectToggle(item.id) },
                                    onToggleAcquired = onToggleAcquired
                                )
                                if (index != items.lastIndex) {
                                    Divider(modifier = Modifier.padding(horizontal = 16.dp))
                                }
                            }
                        }
                    }
                }
            }

            Divider()

            ComponentDraftForm(
                tint = tint,
                initialDraft = ComponentDraft(),
                onAdd = onAddComponent
            )
        }
    }
}

private fun componentGroups(project: Project): List<Pair<com.powerplan.components.ComponentCategory, List<ComponentItem>>> {
    return project.components
        .groupBy { it.category }
        .toSortedMap(compareBy { it.title })
        .map { entry -> entry.key to entry.value }
}

@Composable
private fun InfoRow(icon: androidx.compose.ui.graphics.vector.ImageVector, title: String, value: String) {
    Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
        Icon(icon, contentDescription = null, tint = MaterialTheme.colorScheme.primary)
        Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
            Text(title, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurfaceVariant)
            Text(value.ifBlank { "—" }, style = MaterialTheme.typography.bodyMedium)
        }
    }
}

/** Simple container that mirrors the Swift `ProjectsView.Project` model. */
data class Project(
    val id: UUID = UUID.randomUUID(),
    val name: String = "",
    val voltage: String = "",
    val notes: String = "",
    val components: List<ComponentItem> = emptyList()
) {
    companion object {
        val Saver = mapSaver(
            save = { project ->
                mapOf(
                    "id" to project.id.toString(),
                    "name" to project.name,
                    "voltage" to project.voltage,
                    "notes" to project.notes,
                    "components" to project.components
                )
            },
            restore = { map ->
                Project(
                    id = UUID.fromString(map["id"] as String),
                    name = map["name"] as String,
                    voltage = map["voltage"] as String,
                    notes = map["notes"] as String,
                    components = map["components"] as List<ComponentItem>
                )
            }
        )
    }
}
