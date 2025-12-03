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
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Slider
import androidx.compose.material3.Text
import androidx.compose.material3.icons.Icons
import androidx.compose.material3.icons.filled.Bolt
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.powerplan.components.NumericField
import com.powerplan.util.formatWithUnit
import com.powerplan.util.roundedToPlaces

/**
 * Jetpack Compose port of the iOS `VoltageDropView`.
 *
 * This screen can be used inside an Android Studio project to estimate
 * voltage drop based on conductor length, load current, conductor area,
 * and supply voltage.
 */
@Composable
fun VoltageDropView(modifier: Modifier = Modifier) {
    var length by rememberSaveable { mutableStateOf("30") }
    var load by rememberSaveable { mutableStateOf("16") }
    var supply by rememberSaveable { mutableStateOf("230") }
    var area by rememberSaveable { mutableStateOf(2.5f) }
    var resultMessage by rememberSaveable {
        mutableStateOf(
            "Enter circuit length, load current, conductor area, and supply voltage to estimate voltage drop."
        )
    }

    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = "Voltage Drop Calculator",
            style = MaterialTheme.typography.headlineMedium
        )

        InputCard(title = "Inputs") {
            NumericField(
                label = "Length (m)",
                value = length,
                onValueChange = { length = it }
            )
            NumericField(
                label = "Load Current (A)",
                value = load,
                onValueChange = { load = it }
            )
            NumericField(
                label = "Supply Voltage (V)",
                value = supply,
                onValueChange = { supply = it }
            )

            Column(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("Conductor Area")
                    Text(String.format("%.1f mm²", area))
                }
                Slider(
                    value = area,
                    onValueChange = { area = it },
                    valueRange = 1.5f..35f,
                    steps = 67
                )
                Text(
                    "Typical conductor areas range from 1.5 mm² to 35 mm².",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }

        Card {
            Button(
                modifier = Modifier.fillMaxWidth(),
                onClick = {
                    resultMessage = computeVoltageDrop(
                        length = length,
                        load = load,
                        supply = supply,
                        areaMm2 = area
                    )
                }
            ) {
                Icon(imageVector = Icons.Default.Bolt, contentDescription = null)
                Text("Estimate Drop")
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

private fun computeVoltageDrop(
    length: String,
    load: String,
    supply: String,
    areaMm2: Float
): String {
    val l = length.toDoubleOrNull()
    val i = load.toDoubleOrNull()
    val v = supply.toDoubleOrNull()

    if (l == null || i == null || v == null) {
        return "Enter numeric values for length, load current, and supply voltage."
    }

    val resistivity = 0.0175
    val roundTripLength = l * 2
    val resistance = (resistivity * roundTripLength) / areaMm2
    val voltageDrop = i * resistance
    val percentDrop = (voltageDrop / v) * 100

    return listOf(
        "Voltage Drop: ${voltageDrop.formatWithUnit("V", places = 3)}",
        "Percentage Drop: ${percentDrop.roundedToPlaces(2)} %",
        "Circuit Resistance: ${resistance.formatWithUnit("Ω", places = 4)}"
    ).joinToString("\n")
}
