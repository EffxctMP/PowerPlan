package com.powerplan.calculators

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.icons.Icons
import androidx.compose.material3.icons.filled.Equalizer
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.powerplan.components.NumericField
import com.powerplan.util.formatWithUnit
import kotlin.math.sqrt

/**
 * Jetpack Compose reimplementation of the iOS `OhmsLawCalculatorView`.
 *
 * This screen can be dropped into an Android Studio project and provides
 * equivalent behavior: enter any two Ohm's Law values and the remaining
 * values are calculated and displayed.
 */
@Composable
fun OhmsLawCalculatorView(modifier: Modifier = Modifier) {
    var voltage by rememberSaveable { mutableStateOf("") }
    var current by rememberSaveable { mutableStateOf("") }
    var resistance by rememberSaveable { mutableStateOf("") }
    var power by rememberSaveable { mutableStateOf("") }
    var resultMessage by rememberSaveable {
        mutableStateOf("Provide at least two values to solve Ohm's Law.")
    }

    val scrollState = rememberScrollState()

    Column(
        modifier = modifier
            .verticalScroll(scrollState)
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        Text(
            text = "Ohm's Law Calculator",
            style = MaterialTheme.typography.headlineMedium
        )

        InputCard(title = "Inputs") {
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
            NumericField(
                label = "Resistance (Ω)",
                value = resistance,
                onValueChange = { resistance = it }
            )
            NumericField(
                label = "Power (W)",
                value = power,
                onValueChange = { power = it }
            )
        }

        Card {
            Button(
                modifier = Modifier.fillMaxWidth(),
                onClick = {
                    resultMessage = computeOhmsLaw(
                        voltage = voltage,
                        current = current,
                        resistance = resistance,
                        power = power
                    )
                }
            ) {
                Icon(
                    imageVector = Icons.Default.Equalizer,
                    contentDescription = null
                )
                Text("Calculate")
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
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text(title, style = MaterialTheme.typography.titleMedium)
            content()
        }
    }
}

private fun computeOhmsLaw(
    voltage: String,
    current: String,
    resistance: String,
    power: String
): String {
    val v = voltage.toDoubleOrNull()
    val i = current.toDoubleOrNull()
    val r = resistance.toDoubleOrNull()
    val p = power.toDoubleOrNull()

    val providedCount = listOf(v, i, r, p).count { it != null }
    if (providedCount < 2) {
        return "Enter at least two values to compute the others."
    }

    var V = v
    var I = i
    var R = r
    var P = p

    when {
        V != null && I != null -> {
            R = V!! / I!!
            P = V!! * I!!
        }
        V != null && R != null -> {
            I = V!! / R!!
            P = V!! * (I ?: 0.0)
        }
        V != null && P != null -> {
            I = P!! / V!!
            R = V!! / (I ?: 0.0)
        }
        I != null && R != null -> {
            V = I!! * R!!
            P = (V ?: 0.0) * I!!
        }
        I != null && P != null -> {
            V = P!! / I!!
            R = (V ?: 0.0) / I!!
        }
        R != null && P != null -> {
            I = sqrt(P!! / R!!)
            V = (I ?: 0.0) * R!!
        }
    }

    fun format(value: Double?, unit: String): String =
        value?.formatWithUnit(unit, places = 3) ?: "-"

    return listOf(
        "Voltage: ${format(V, "V")}",
        "Current: ${format(I, "A")}",
        "Resistance: ${format(R, "Ω")}",
        "Power: ${format(P, "W")}" 
    ).joinToString("\n")
}
