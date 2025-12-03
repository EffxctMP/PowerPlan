package com.powerplan.calculators

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import com.powerplan.util.formatWithUnit
import com.powerplan.util.roundedToPlaces
import kotlin.math.sqrt

/**
 * Jetpack Compose port of the iOS `PowerCalculatorView`.
 *
 * This screen can be copied into an Android Studio project to offer
 * the same functionality: estimate power usage for single- or three-phase
 * circuits while accounting for power factor.
 */
@Composable
fun PowerCalculatorView(modifier: Modifier = Modifier) {
    var phase by rememberSaveable { mutableStateOf(Phase.SINGLE) }
    var voltage by rememberSaveable { mutableStateOf("230") }
    var current by rememberSaveable { mutableStateOf("10") }
    var powerFactor by rememberSaveable { mutableStateOf(0.95f) }
    var resultMessage by rememberSaveable {
        mutableStateOf("Enter voltage, current, and power factor to estimate power.")
    }

    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = "Power Calculator",
            style = MaterialTheme.typography.headlineMedium
        )

        InputCard(title = "Circuit") {
            PhaseSelector(
                selected = phase,
                onSelected = { phase = it }
            )

            PowerTextField(
                label = "Voltage (V)",
                value = voltage,
                onValueChange = { voltage = it }
            )
            PowerTextField(
                label = "Current (A)",
                value = current,
                onValueChange = { current = it }
            )

            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                    Text("Power Factor")
                    Text(String.format("%.2f", powerFactor))
                }
                Slider(
                    value = powerFactor,
                    onValueChange = { powerFactor = it },
                    valueRange = 0.5f..1.0f,
                    steps = 49
                )
                Text(
                    "Typical power factors range from 0.50 to 1.00.",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }

        Card {
            Button(
                modifier = Modifier.fillMaxWidth(),
                onClick = {
                    resultMessage = computePower(
                        phase = phase,
                        voltage = voltage,
                        current = current,
                        powerFactor = powerFactor
                    )
                }
            ) {
                Text("Estimate Power")
            }
        }

        InputCard(title = "Results") {
            Text(resultMessage, style = MaterialTheme.typography.bodyLarge)
        }
    }
}

@Composable
private fun PhaseSelector(selected: Phase, onSelected: (Phase) -> Unit) {
    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(12.dp)) {
        OutlinedButton(
            modifier = Modifier.weight(1f),
            onClick = { onSelected(Phase.SINGLE) },
            enabled = selected != Phase.SINGLE
        ) {
            Text("Single Phase")
        }
        OutlinedButton(
            modifier = Modifier.weight(1f),
            onClick = { onSelected(Phase.THREE) },
            enabled = selected != Phase.THREE
        ) {
            Text("Three Phase")
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun PowerTextField(label: String, value: String, onValueChange: (String) -> Unit) {
    OutlinedTextField(
        modifier = Modifier.fillMaxWidth(),
        label = { Text(label) },
        value = value,
        onValueChange = onValueChange,
        singleLine = true,
        keyboardOptions = KeyboardOptions.Default.copy(keyboardType = KeyboardType.Number)
    )
}

@Composable
private fun InputCard(title: String, content: @Composable () -> Unit) {
    Card {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text(title, style = MaterialTheme.typography.titleMedium)
            content()
        }
    }
}

private fun computePower(
    phase: Phase,
    voltage: String,
    current: String,
    powerFactor: Float
): String {
    val v = voltage.toDoubleOrNull()
    val i = current.toDoubleOrNull()
    if (v == null || i == null) {
        return "Please provide numeric values for voltage and current."
    }

    val multiplier = if (phase == Phase.SINGLE) 1.0 else sqrt(3.0)
    val watts = multiplier * v * i * powerFactor
    val kw = watts / 1000
    val breaker = (i * 1.25).roundedToPlaces(2)

    return listOf(
        "Power: ${watts.formatWithUnit("W", places = 2)} (${kw.formatWithUnit("kW", places = 3)})",
        "Recommended Breaker: ${breaker.formatWithUnit("A", places = 2)}",
        "Apparent Power: ${(multiplier * v * i).formatWithUnit("VA", places = 2)}"
    ).joinToString("\n")
}

private enum class Phase { SINGLE, THREE }
