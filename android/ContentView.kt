package com.powerplan

import androidx.compose.animation.Crossfade
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Bolt
import androidx.compose.material.icons.filled.Book
import androidx.compose.material.icons.filled.Folder
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.AssistChip
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Surface
import androidx.compose.material3.Tab
import androidx.compose.material3.TabRow
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.powerplan.calculators.OhmsLawCalculatorView
import com.powerplan.calculators.PowerCalculatorView
import com.powerplan.calculators.VoltageDropView
import com.powerplan.calculators.WattCalculatorView
import com.powerplan.components.ComponentDraft
import com.powerplan.components.ComponentDraftForm
import com.powerplan.components.ComponentItem
import com.powerplan.components.ComponentRow
import java.util.UUID

/**
 * Jetpack Compose port of the SwiftUI `ContentView` entry point.
 *
 * Drop this file into an Android Studio project to mirror the dashboard,
 * calculators hub, reference sheet, and lightweight project tracker from
 * the original iOS experience.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PowerPlanApp(modifier: Modifier = Modifier) {
    var selectedTab by rememberSaveable { mutableStateOf(PowerPlanTab.CALCULATORS) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(text = "Power Plan") },
                actions = {
                    AssistChip(
                        onClick = { /* Hook up to settings destination if desired */ },
                        label = { Text(text = "Settings") },
                        leadingIcon = {
                            Icon(imageVector = Icons.Default.Settings, contentDescription = null)
                        }
                    )
                }
            )
        }
    ) { padding ->
        Column(
            modifier = modifier
                .padding(padding)
                .fillMaxSize(),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            TabRow(selectedTabIndex = selectedTab.ordinal) {
                PowerPlanTab.entries.forEach { tab ->
                    Tab(
                        selected = selectedTab == tab,
                        onClick = { selectedTab = tab },
                        text = { Text(text = tab.title) },
                        icon = { Icon(imageVector = tab.icon, contentDescription = null) }
                    )
                }
            }

            Crossfade(targetState = selectedTab) { tab ->
                when (tab) {
                    PowerPlanTab.CALCULATORS -> CalculatorsTab()
                    PowerPlanTab.PROJECTS -> ProjectsTab()
                    PowerPlanTab.REFERENCE -> ReferenceTab()
                }
            }
        }
    }
}

@Composable
private fun CalculatorsTab() {
    var activeCalculator by rememberSaveable { mutableStateOf(CalculatorScreen.NONE) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.spacedBy(14.dp)
    ) {
        HeroHeader()

        CalculatorCard(
            title = "Ohm's Law",
            subtitle = "Solve for voltage, current, resistance, or power.",
            buttonLabel = "Open Ohm's Law",
            onClick = { activeCalculator = CalculatorScreen.OHMS }
        )

        CalculatorCard(
            title = "Power & Load",
            subtitle = "Single and three-phase circuits with power factor.",
            buttonLabel = "Open Power Calculator",
            onClick = { activeCalculator = CalculatorScreen.POWER }
        )

        CalculatorCard(
            title = "Wattage",
            subtitle = "Estimate watts from voltage, amps, and PF.",
            buttonLabel = "Open Watt Calculator",
            onClick = { activeCalculator = CalculatorScreen.WATT }
        )

        CalculatorCard(
            title = "Voltage Drop",
            subtitle = "Estimate drop based on conductor and load.",
            buttonLabel = "Open Voltage Drop",
            onClick = { activeCalculator = CalculatorScreen.DROP }
        )

        Surface(
            tonalElevation = 1.dp,
            shape = RoundedCornerShape(16.dp)
        ) {
            Column(modifier = Modifier.padding(16.dp)) {
                Text(
                    text = "Calculator",
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Spacer(modifier = Modifier.height(8.dp))
                when (activeCalculator) {
                    CalculatorScreen.NONE -> Text(
                        text = "Choose a calculator above to get started.",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )

                    CalculatorScreen.OHMS -> OhmsLawCalculatorView()
                    CalculatorScreen.POWER -> PowerCalculatorView()
                    CalculatorScreen.WATT -> WattCalculatorView()
                    CalculatorScreen.DROP -> VoltageDropView()
                }
            }
        }
    }
}

@Composable
private fun ProjectsTab() {
    val components = remember { mutableStateListOf<ComponentItem>() }
    var isSelecting by rememberSaveable { mutableStateOf(false) }
    var selectedIds by rememberSaveable { mutableStateOf(setOf<UUID>()) }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column {
                Text(
                    text = "Projects",
                    style = MaterialTheme.typography.headlineSmall
                )
                Text(
                    text = "Track project components and acquisition status.",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
            OutlinedButton(onClick = { isSelecting = !isSelecting }) {
                Text(if (isSelecting) "Done" else "Select")
            }
        }

        ComponentDraftForm(
            tint = MaterialTheme.colorScheme.primary,
            onAdd = { newItem ->
                components.add(newItem)
            }
        )

        Card {
            Column(
                modifier = Modifier.padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Text("Components", style = MaterialTheme.typography.titleMedium)
                if (components.isEmpty()) {
                    Text(
                        text = "Add items with the form above to start a project kit.",
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                } else {
                    LazyColumn(verticalArrangement = Arrangement.spacedBy(4.dp)) {
                        items(components, key = { it.id }) { item ->
                            val selected = selectedIds.contains(item.id)
                            ComponentRow(
                                item = item,
                                tint = MaterialTheme.colorScheme.primary,
                                isSelecting = isSelecting,
                                isSelected = selected,
                                onToggleSelection = {
                                    selectedIds = selectedIds.toMutableSet().also { set ->
                                        if (selected) set.remove(item.id) else set.add(item.id)
                                    }
                                },
                                onToggleAcquired = { updated ->
                                    val index = components.indexOfFirst { it.id == updated.id }
                                    if (index >= 0) {
                                        components[index] = updated
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun ReferenceTab() {
    ReferenceView(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    )
}

@Composable
private fun HeroHeader() {
    val gradient = Brush.linearGradient(
        colors = listOf(
            MaterialTheme.colorScheme.primary.copy(alpha = 0.95f),
            MaterialTheme.colorScheme.primary.copy(alpha = 0.7f)
        ),
        start = androidx.compose.ui.geometry.Offset.Zero,
        end = androidx.compose.ui.geometry.Offset.Infinite
    )

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(180.dp)
            .background(gradient, shape = RoundedCornerShape(24.dp))
            .padding(20.dp),
        contentAlignment = Alignment.CenterStart
    ) {
        Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp), verticalAlignment = Alignment.CenterVertically) {
                Icon(
                    imageVector = Icons.Default.Bolt,
                    contentDescription = null,
                    tint = Color.White
                )
                Text(
                    text = "Electrician Toolkit",
                    color = Color.White,
                    style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold)
                )
            }
            Text(
                text = "Advanced calculators for sizing loads, validating runs, and checking energy costs.",
                color = Color.White.copy(alpha = 0.9f),
                style = MaterialTheme.typography.bodyMedium
            )
            Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
                AssistChip(
                    onClick = {},
                    label = { Text("Offline ready") },
                    leadingIcon = {
                        Icon(Icons.Default.Folder, contentDescription = null, tint = MaterialTheme.colorScheme.primary)
                    }
                )
                AssistChip(
                    onClick = {},
                    label = { Text("Pro formulas") },
                    leadingIcon = {
                        Icon(Icons.Default.Book, contentDescription = null, tint = MaterialTheme.colorScheme.primary)
                    }
                )
            }
        }
    }
}

@Composable
private fun CalculatorCard(
    title: String,
    subtitle: String,
    buttonLabel: String,
    onClick: () -> Unit
) {
    Card { 
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Text(title, style = MaterialTheme.typography.titleMedium)
            Text(
                subtitle,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Button(
                modifier = Modifier.fillMaxWidth(),
                onClick = onClick
            ) {
                Text(buttonLabel, textAlign = TextAlign.Center)
            }
        }
    }
}

private enum class PowerPlanTab(val title: String, val icon: androidx.compose.ui.graphics.vector.ImageVector) {
    CALCULATORS("Calculators", Icons.Default.Bolt),
    PROJECTS("Projects", Icons.Default.Folder),
    REFERENCE("Reference", Icons.Default.Book)
}

private enum class CalculatorScreen {
    NONE,
    OHMS,
    POWER,
    WATT,
    DROP
}

fun sampleComponentItem(
    name: String,
    primary: String,
    secondary: String? = null,
    tag: String? = null,
    acquired: Boolean = false
): ComponentItem {
    return ComponentItem(
        id = UUID.randomUUID(),
        name = name,
        tag = tag,
        category = ComponentDraft.ComponentCategory.BREAKER,
        primary = primary,
        secondary = secondary,
        details = "",
        quantity = 1,
        acquired = acquired
    )
}
