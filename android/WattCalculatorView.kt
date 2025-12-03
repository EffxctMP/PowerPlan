package com.powerplan.calculators

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.powerplan.components.NumericField
import com.powerplan.util.formatWithUnit

/**
 * Jetpack Compose port of the iOS `WattCalculatorView`.
 *
 * This composable can be copied into an Android Studio project to provide
 * a simple wattage calculator: supply voltage, current, and power factor
 * to estimate real power in watts and kilowatts.
 */
@Composable
fun WattCalculatorView(modifier: Modifier = Modifier) {
    var voltage by rememberSaveable { mutableStateOf("230") }
    var current by rememberSaveable { mutableStateOf("10") }
    var powerFactor by rememberSaveable { mutableStateOf(1.0f) }
    var resultMessage by rememberSaveable {
        mutableStateOf("Enter voltage, current, and power factor to compute watts.")
    }

    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = "Watt Calculator",
            style = MaterialTheme.typography.headlineMedium
        )

        InputCard(title = "Load") {
            NumericField(
                label = "Voltage (V)",
                value = voltage,
                onValueChange = { voltage = it }
            )
            NumericField(
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
                    resultMessage = computeWatts(
                        voltage = voltage,
                        current = current,
                        powerFactor = powerFactor
                    )
                }
            ) {
                Text("Calculate Watts")
            }
        }

        InputCard(title = "Results") {
            Text(resultMessage, style = MaterialTheme.typography.bodyLarge)
        }
    }
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

private fun computeWatts(
    voltage: String,
    current: String,
    powerFactor: Float
): String {
    val v = voltage.toDoubleOrNull()
    val i = current.toDoubleOrNull()
    if (v == null || i == null) {
        return "Please provide numeric values for voltage and current."
    }

    val watts = v * i * powerFactor
    val kw = watts / 1000

    return listOf(
        "Real Power: ${watts.formatWithUnit("W", places = 2)} (${kw.formatWithUnit("kW", places = 3)})",
        "Assuming power factor: ${String.format("%.2f", powerFactor)}"
    ).joinToString("\n")
}
