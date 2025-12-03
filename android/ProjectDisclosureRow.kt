package com.powerplan.projects

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CheckCircle
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.ExpandLess
import androidx.compose.material.icons.filled.ExpandMore
import androidx.compose.material.icons.filled.ModeEdit
import androidx.compose.material.icons.filled.RadioButtonUnchecked
import androidx.compose.material.icons.outlined.Circle
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Divider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardOptions
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import com.powerplan.components.ComponentDraft
import com.powerplan.components.ComponentDraftForm
import com.powerplan.components.ComponentItem
import com.powerplan.components.ComponentRow
import java.util.UUID

/**
 * Jetpack Compose port of the SwiftUI `ProjectDisclosureRow`.
 *
 * Drop this file into an Android Studio project to render an expandable
 * project card that mirrors the iOS editing experience, including inline
 * component management and multi-select support.
 */
@Composable
fun ProjectDisclosureRow(
    project: Project,
    onProjectChange: (Project) -> Unit,
    modifier: Modifier = Modifier,
    tint: Color = MaterialTheme.colorScheme.primary,
    isEditing: Boolean,
    onEditingChange: (Boolean) -> Unit,
    componentDraft: ComponentDraft,
    onComponentDraftChange: (ComponentDraft) -> Unit,
    isSelecting: Boolean = false,
    isSelected: Boolean = false,
    onToggleSelection: () -> Unit = {},
    initiallyExpanded: Boolean = true
) {
    var expanded by rememberSaveable(project.id) { mutableStateOf(initiallyExpanded) }

    Card(
        modifier = modifier,
        shape = RoundedCornerShape(12.dp),
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface)
    ) {
        Column(modifier = Modifier.fillMaxWidth()) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .clickable { expanded = !expanded }
                    .padding(horizontal = 16.dp, vertical = 12.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                if (isSelecting) {
                    IconButton(onClick = onToggleSelection) {
                        Icon(
                            imageVector = if (isSelected) Icons.Filled.CheckCircle else Icons.Outlined.Circle,
                            contentDescription = null,
                            tint = if (isSelected) tint else MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }

                Column(modifier = Modifier.weight(1f)) {
                    Text(
                        text = project.name.ifBlank { "Untitled Project" },
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.onSurface,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis
                    )
                    if (project.voltage.isNotBlank()) {
                        Text(
                            text = project.voltage,
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }

                IconButton(onClick = { expanded = !expanded }) {
                    Icon(
                        imageVector = if (expanded) Icons.Filled.ExpandLess else Icons.Filled.ExpandMore,
                        contentDescription = null
                    )
                }
            }

            AnimatedVisibility(visible = expanded) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.25f))
                        .padding(horizontal = 16.dp, vertical = 12.dp),
                    verticalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "Project details",
                            style = MaterialTheme.typography.titleSmall.copy(fontWeight = FontWeight.Bold)
                        )
                        IconButton(onClick = { onEditingChange(!isEditing) }) {
                            Icon(
                                imageVector = Icons.Filled.ModeEdit,
                                contentDescription = null,
                                tint = tint
                            )
                        }
                    }

                    if (isEditing) {
                        OutlinedTextField(
                            modifier = Modifier.fillMaxWidth(),
                            label = { Text("Project name") },
                            value = project.name,
                            onValueChange = { onProjectChange(project.copy(name = it)) }
                        )

                        OutlinedTextField(
                            modifier = Modifier.fillMaxWidth(),
                            label = { Text("Voltage") },
                            value = project.voltage,
                            onValueChange = { onProjectChange(project.copy(voltage = it)) },
                            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number)
                        )

                        OutlinedTextField(
                            modifier = Modifier.fillMaxWidth(),
                            label = { Text("Notes") },
                            value = project.notes,
                            onValueChange = { onProjectChange(project.copy(notes = it)) },
                            minLines = 2
                        )
                    } else {
                        InfoRow(title = "Voltage", value = project.voltage, tint = tint)
                        InfoRow(title = "Notes", value = project.notes, tint = tint)
                    }

                    Divider()

                    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                        Text(
                            text = "Components",
                            style = MaterialTheme.typography.titleSmall,
                            color = MaterialTheme.colorScheme.onSurface
                        )
                        if (project.components.isEmpty()) {
                            Text(
                                text = "Add items with the form below to start tracking a build.",
                                style = MaterialTheme.typography.bodySmall,
                                color = MaterialTheme.colorScheme.onSurfaceVariant
                            )
                        } else {
                            project.components.forEach { item ->
                                Row(
                                    verticalAlignment = Alignment.CenterVertically,
                                    horizontalArrangement = Arrangement.spacedBy(4.dp)
                                ) {
                                    ComponentRow(
                                        item = item,
                                        tint = tint,
                                        isSelecting = isSelecting,
                                        isSelected = isSelected,
                                        onToggleSelection = onToggleSelection,
                                        onToggleAcquired = { updated ->
                                            onProjectChange(
                                                project.copy(
                                                    components = project.components.map { existing ->
                                                        if (existing.id == updated.id) updated else existing
                                                    }
                                                )
                                            )
                                        }
                                    )
                                    IconButton(onClick = {
                                        onProjectChange(
                                            project.copy(components = project.components.filterNot { it.id == item.id })
                                        )
                                    }) {
                                        Icon(
                                            imageVector = Icons.Filled.Delete,
                                            contentDescription = "Delete component",
                                            tint = MaterialTheme.colorScheme.error
                                        )
                                    }
                                }
                            }
                        }
                    }

                    Divider()

                    ComponentDraftForm(
                        tint = tint,
                        initialDraft = componentDraft,
                        onAdd = { newItem ->
                            onProjectChange(project.copy(components = project.components + newItem))
                            onComponentDraftChange(ComponentDraft())
                        }
                    )

                    if (componentDraft != ComponentDraft()) {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.End
                        ) {
                            Button(onClick = { onComponentDraftChange(ComponentDraft()) }) {
                                Text("Reset draft")
                            }
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun InfoRow(title: String, value: String, tint: Color) {
    Column(verticalArrangement = Arrangement.spacedBy(4.dp)) {
        Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(8.dp)) {
            Icon(
                imageVector = Icons.Filled.RadioButtonUnchecked,
                contentDescription = null,
                tint = tint,
                modifier = Modifier.size(18.dp)
            )
            Text(
                text = title,
                style = MaterialTheme.typography.labelMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
        Text(
            text = value.ifBlank { "—" },
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurface,
            maxLines = 4,
            overflow = TextOverflow.Ellipsis
        )
    }
}

data class Project(
    val id: UUID = UUID.randomUUID(),
    val name: String = "",
    val voltage: String = "",
    val notes: String = "",
    val components: List<ComponentItem> = emptyList()
)
