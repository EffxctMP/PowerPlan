package com.powerplan.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.Divider
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.mapSaver
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.input.KeyboardOptions
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import java.util.UUID

/**
 * Jetpack Compose port of the iOS `ComponentDraftForm`.
 *
 * Drop this file into an Android Studio project to offer a compact
 * component builder that mirrors the SwiftUI experience. The form
 * supports the same component categories, option pickers, and derived
 * descriptions as the original iOS implementation.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ComponentDraftForm(
    modifier: Modifier = Modifier,
    tint: Color = MaterialTheme.colorScheme.primary,
    initialDraft: ComponentDraft = ComponentDraft(),
    onAdd: (ComponentItem) -> Unit
) {
    var draft by rememberSaveable(stateSaver = ComponentDraft.Saver) {
        mutableStateOf(initialDraft)
    }

    val breakerAmps = rememberSaveable { (1..1000).toList() }
    val transformerOptions = rememberSaveable {
        (50..1000 step 50).toList() + (1200..5000 step 200).toList()
    }
    val relayVoltages = rememberSaveable { listOf(12, 24, 48, 110, 120, 230) }

    Card(modifier = modifier) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text(
                text = "Add Component",
                style = MaterialTheme.typography.titleMedium
            )

            DropdownField(
                label = "Component Type",
                options = ComponentCategory.entries,
                selectedOption = draft.category,
                optionLabel = { it.title },
                onOptionSelected = { draft = draft.copy(category = it) }
            )

            Divider()

            ComponentOptions(
                draft = draft,
                breakerAmps = breakerAmps,
                transformerOptions = transformerOptions,
                relayVoltages = relayVoltages,
                onDraftChange = { draft = it }
            )

            Divider()

            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Tag (optional)") },
                value = draft.tag,
                onValueChange = { draft = draft.copy(tag = it) },
                singleLine = true
            )

            Divider()

            QuantitySelector(
                quantity = draft.quantity,
                onQuantityChange = { draft = draft.copy(quantity = it.coerceIn(1, 500)) }
            )

            Divider()

            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Additional Info") },
                value = draft.additionalInfo,
                onValueChange = { draft = draft.copy(additionalInfo = it) },
                minLines = 2
            )

            Button(
                modifier = Modifier.fillMaxWidth(),
                onClick = {
                    val item = draft.toComponentItem()
                    onAdd(item)
                    draft = ComponentDraft()
                },
                enabled = draft.canSave(),
                colors = ButtonDefaults.buttonColors(containerColor = tint)
            ) {
                Text("Save Component")
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun ComponentOptions(
    draft: ComponentDraft,
    breakerAmps: List<Int>,
    transformerOptions: List<Int>,
    relayVoltages: List<Int>,
    onDraftChange: (ComponentDraft) -> Unit
) {
    when (draft.category) {
        ComponentCategory.BREAKER -> {
            DropdownField(
                label = "Breaker Amps",
                options = breakerAmps,
                selectedOption = draft.amps,
                optionLabel = { ampsLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(amps = it)) }
            )
            Divider()
            DropdownField(
                label = "Breaker Curve",
                options = BreakerCurve.entries,
                selectedOption = draft.curve,
                optionLabel = { it.raw },
                onOptionSelected = { onDraftChange(draft.copy(curve = it)) }
            )
        }
        ComponentCategory.CONTACTOR -> {
            DropdownField(
                label = "Poles",
                options = (1..6).toList(),
                selectedOption = draft.poles,
                optionLabel = { polesLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(poles = it)) }
            )
            Divider()
            DropdownField(
                label = "Contactor Amps",
                options = breakerAmps,
                selectedOption = draft.amps,
                optionLabel = { ampsLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(amps = it)) }
            )
        }
        ComponentCategory.THERMAL_PROTECTION -> {
            DropdownField(
                label = "Thermal Setting",
                options = breakerAmps,
                selectedOption = draft.amps,
                optionLabel = { ampsLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(amps = it)) }
            )
        }
        ComponentCategory.TRANSFORMER -> {
            DropdownField(
                label = "Transformer Power",
                options = transformerOptions,
                selectedOption = draft.transformerWatts,
                optionLabel = { wattsLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(transformerWatts = it)) }
            )
        }
        ComponentCategory.BOARD_SOCKET -> {
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Socket Option") },
                value = draft.optionNote,
                onValueChange = { onDraftChange(draft.copy(optionNote = it)) },
                singleLine = true
            )
        }
        ComponentCategory.SWITCH_POSITIONS -> {
            DropdownField(
                label = "Switch Positions",
                options = (2..6).toList(),
                selectedOption = draft.switchPositions,
                optionLabel = { positionsLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(switchPositions = it)) }
            )
        }
        ComponentCategory.RELAY -> {
            DropdownField(
                label = "Relay Voltage",
                options = relayVoltages,
                selectedOption = draft.relayVoltage,
                optionLabel = { voltageLabel(it) },
                onOptionSelected = { onDraftChange(draft.copy(relayVoltage = it)) }
            )
            Divider()
            DropdownField(
                label = "Relay Coil",
                options = RelayCoilType.entries,
                selectedOption = draft.relayCoil,
                optionLabel = { it.raw },
                onOptionSelected = { onDraftChange(draft.copy(relayCoil = it)) }
            )
        }
        ComponentCategory.KWH_METER -> {
            DropdownField(
                label = "Configuration",
                options = listOf(1, 3),
                selectedOption = draft.kwhConfiguration,
                optionLabel = { if (it == 1) "Single Phase" else "Three Phase" },
                onOptionSelected = { onDraftChange(draft.copy(kwhConfiguration = it)) }
            )
            Divider()
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Notes") },
                value = draft.optionNote,
                onValueChange = { onDraftChange(draft.copy(optionNote = it)) },
                singleLine = true
            )
        }
        ComponentCategory.PLC_CARD -> {
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("PLC Brand") },
                value = draft.brand,
                onValueChange = { onDraftChange(draft.copy(brand = it)) },
                singleLine = true
            )
            Divider()
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("PLC Type/Model") },
                value = draft.model,
                onValueChange = { onDraftChange(draft.copy(model = it)) },
                singleLine = true
            )
            Divider()
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Notes") },
                value = draft.optionNote,
                onValueChange = { onDraftChange(draft.copy(optionNote = it)) },
                singleLine = true
            )
        }
        ComponentCategory.CIRCUIT_TERMINAL -> {
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Terminal Type") },
                value = draft.terminalType,
                onValueChange = { onDraftChange(draft.copy(terminalType = it)) },
                singleLine = true
            )
            Divider()
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Notes") },
                value = draft.optionNote,
                onValueChange = { onDraftChange(draft.copy(optionNote = it)) },
                singleLine = true
            )
        }
        ComponentCategory.CUSTOM -> {
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Custom Label") },
                value = draft.customLabel,
                onValueChange = { onDraftChange(draft.copy(customLabel = it)) },
                singleLine = true
            )
            Divider()
            OutlinedTextField(
                modifier = Modifier.fillMaxWidth(),
                label = { Text("Notes") },
                value = draft.optionNote,
                onValueChange = { onDraftChange(draft.copy(optionNote = it)) },
                singleLine = true
            )
        }
    }
}

@Composable
private fun QuantitySelector(quantity: Int, onQuantityChange: (Int) -> Unit) {
    Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(
            text = "Quantity: $quantity",
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
        Row(horizontalArrangement = Arrangement.spacedBy(12.dp)) {
            OutlinedTextField(
                value = quantity.toString(),
                onValueChange = { value ->
                    val parsed = value.toIntOrNull()
                    if (parsed != null) {
                        onQuantityChange(parsed)
                    }
                },
                label = { Text("Quantity") },
                singleLine = true,
                keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
                modifier = Modifier.weight(1f)
            )
            Button(onClick = { onQuantityChange((quantity - 1).coerceAtLeast(1)) }) {
                Text("-")
            }
            Button(onClick = { onQuantityChange((quantity + 1).coerceAtMost(500)) }) {
                Text("+")
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun <T> DropdownField(
    label: String,
    options: List<T>,
    selectedOption: T,
    optionLabel: (T) -> String,
    onOptionSelected: (T) -> Unit
) {
    var expanded by rememberSaveable { mutableStateOf(false) }

    ExposedDropdownMenuBox(expanded = expanded, onExpandedChange = { expanded = !expanded }) {
        OutlinedTextField(
            modifier = Modifier
                .menuAnchor()
                .fillMaxWidth(),
            value = optionLabel(selectedOption),
            onValueChange = {},
            readOnly = true,
            label = { Text(label) },
            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded) }
        )

        ExposedDropdownMenu(expanded = expanded, onDismissRequest = { expanded = false }) {
            options.forEach { option ->
                DropdownMenuItem(
                    text = { Text(optionLabel(option)) },
                    onClick = {
                        onOptionSelected(option)
                        expanded = false
                    }
                )
            }
        }
    }
}

data class ComponentItem(
    val id: UUID = UUID.randomUUID(),
    val name: String,
    val tag: String?,
    val category: ComponentCategory,
    val primary: String,
    val secondary: String?,
    val details: String,
    val quantity: Int,
    val acquired: Boolean
)

enum class ComponentCategory(val title: String) {
    BREAKER("Breaker"),
    CONTACTOR("Contactor"),
    THERMAL_PROTECTION("Thermal Protection"),
    TRANSFORMER("Transformer"),
    BOARD_SOCKET("Board Socket"),
    SWITCH_POSITIONS("Switch"),
    RELAY("Relay"),
    KWH_METER("kWh Meter"),
    PLC_CARD("PLC Card"),
    CIRCUIT_TERMINAL("Circuit Terminal"),
    CUSTOM("Custom");
}

enum class BreakerCurve(val raw: String) { B("B"), C("C"), D("D"), K("K"), Z("Z") }

enum class RelayCoilType(val raw: String) { AC("AC"), DC("DC") }

data class ComponentDraft(
    val category: ComponentCategory = ComponentCategory.BREAKER,
    val amps: Int = 63,
    val curve: BreakerCurve = BreakerCurve.C,
    val poles: Int = 3,
    val transformerWatts: Int = 400,
    val switchPositions: Int = 2,
    val relayVoltage: Int = 24,
    val relayCoil: RelayCoilType = RelayCoilType.AC,
    val kwhConfiguration: Int = 1,
    val quantity: Int = 1,
    val tag: String = "",
    val additionalInfo: String = "",
    val customLabel: String = "",
    val optionNote: String = "",
    val brand: String = "",
    val model: String = "",
    val terminalType: String = ""
) {
    fun displayName(): String {
        val custom = customLabel.trim()
        return when (category) {
            ComponentCategory.CUSTOM -> if (custom.isEmpty()) category.title else custom
            else -> category.title
        }
    }

    fun primaryDescription(): String {
        return when (category) {
            ComponentCategory.BREAKER -> ampsLabel(amps)
            ComponentCategory.CONTACTOR -> listOf(polesLabel(poles), ampsLabel(amps)).joinToString(" · ")
            ComponentCategory.THERMAL_PROTECTION -> ampsLabel(amps)
            ComponentCategory.TRANSFORMER -> wattsLabel(transformerWatts)
            ComponentCategory.BOARD_SOCKET -> optionNote.trim()
            ComponentCategory.SWITCH_POSITIONS -> positionsLabel(switchPositions)
            ComponentCategory.RELAY -> voltageLabel(relayVoltage)
            ComponentCategory.KWH_METER -> if (kwhConfiguration == 1) "Single Phase" else "Three Phase"
            ComponentCategory.PLC_CARD -> listOf(brand.trim(), model.trim()).filter { it.isNotEmpty() }.joinToString(" · ")
            ComponentCategory.CIRCUIT_TERMINAL -> terminalType.trim()
            ComponentCategory.CUSTOM -> customLabel.trim()
        }
    }

    fun secondaryDescription(): String? {
        return when (category) {
            ComponentCategory.BREAKER -> curve.raw
            ComponentCategory.CONTACTOR -> null
            ComponentCategory.THERMAL_PROTECTION -> null
            ComponentCategory.TRANSFORMER -> null
            ComponentCategory.BOARD_SOCKET -> null
            ComponentCategory.SWITCH_POSITIONS -> null
            ComponentCategory.RELAY -> relayCoil.raw
            ComponentCategory.KWH_METER -> optionNote.trim().ifEmpty { null }
            ComponentCategory.PLC_CARD -> optionNote.trim().ifEmpty { null }
            ComponentCategory.CIRCUIT_TERMINAL -> optionNote.trim().ifEmpty { null }
            ComponentCategory.CUSTOM -> optionNote.trim().ifEmpty { null }
        }
    }

    fun canSave(): Boolean {
        val primary = primaryDescription().trim()
        return when (category) {
            ComponentCategory.PLC_CARD -> brand.trim().isNotEmpty() && model.trim().isNotEmpty()
            ComponentCategory.CIRCUIT_TERMINAL, ComponentCategory.CUSTOM -> primary.isNotEmpty()
            else -> primary.isNotEmpty()
        }
    }

    fun toComponentItem(): ComponentItem {
        val cleanedTag = tag.trim().ifEmpty { null }
        return ComponentItem(
            name = displayName(),
            tag = cleanedTag,
            category = category,
            primary = primaryDescription(),
            secondary = secondaryDescription(),
            details = additionalInfo.trim(),
            quantity = quantity,
            acquired = false
        )
    }

    companion object {
        val Saver = mapSaver(
            save = { draft ->
                mapOf(
                    "category" to draft.category.name,
                    "amps" to draft.amps,
                    "curve" to draft.curve.name,
                    "poles" to draft.poles,
                    "transformerWatts" to draft.transformerWatts,
                    "switchPositions" to draft.switchPositions,
                    "relayVoltage" to draft.relayVoltage,
                    "relayCoil" to draft.relayCoil.name,
                    "kwhConfiguration" to draft.kwhConfiguration,
                    "quantity" to draft.quantity,
                    "tag" to draft.tag,
                    "additionalInfo" to draft.additionalInfo,
                    "customLabel" to draft.customLabel,
                    "optionNote" to draft.optionNote,
                    "brand" to draft.brand,
                    "model" to draft.model,
                    "terminalType" to draft.terminalType
                )
            },
            restore = { map ->
                ComponentDraft(
                    category = (map["category"] as? String)?.let { ComponentCategory.valueOf(it) }
                        ?: ComponentCategory.BREAKER,
                    amps = map["amps"] as? Int ?: 63,
                    curve = (map["curve"] as? String)?.let { BreakerCurve.valueOf(it) } ?: BreakerCurve.C,
                    poles = map["poles"] as? Int ?: 3,
                    transformerWatts = map["transformerWatts"] as? Int ?: 400,
                    switchPositions = map["switchPositions"] as? Int ?: 2,
                    relayVoltage = map["relayVoltage"] as? Int ?: 24,
                    relayCoil = (map["relayCoil"] as? String)?.let { RelayCoilType.valueOf(it) }
                        ?: RelayCoilType.AC,
                    kwhConfiguration = map["kwhConfiguration"] as? Int ?: 1,
                    quantity = map["quantity"] as? Int ?: 1,
                    tag = map["tag"] as? String ?: "",
                    additionalInfo = map["additionalInfo"] as? String ?: "",
                    customLabel = map["customLabel"] as? String ?: "",
                    optionNote = map["optionNote"] as? String ?: "",
                    brand = map["brand"] as? String ?: "",
                    model = map["model"] as? String ?: "",
                    terminalType = map["terminalType"] as? String ?: ""
                )
            }
        )
    }
}

private fun ampsLabel(value: Int) = "$value A"
private fun wattsLabel(value: Int) = "$value W"
private fun polesLabel(value: Int) = "$value poles"
private fun positionsLabel(value: Int) = "$value positions"
private fun voltageLabel(value: Int) = "$value V"
