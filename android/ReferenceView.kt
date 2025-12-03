package com.powerplan

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Bolt
import androidx.compose.material.icons.filled.Functions
import androidx.compose.material3.Card
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp

/**
 * Jetpack Compose recreation of the SwiftUI `ReferenceView` screen.
 *
 * Drop this into Android Studio to present the same quick constants and
 * usage tips shown in the original iOS build.
 */
@Composable
fun ReferenceView(modifier: Modifier = Modifier) {
    Column(
        modifier = modifier,
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Text(
            text = stringResource(id = R.string.tab_reference),
            style = MaterialTheme.typography.headlineSmall
        )

        Card {
            Column(
                modifier = Modifier.padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Text(
                    text = stringResource(id = R.string.reference_quick),
                    style = MaterialTheme.typography.titleMedium
                )
                ReferenceRow(
                    icon = Icons.Default.Functions,
                    text = stringResource(id = R.string.reference_copper)
                )
                ReferenceRow(
                    icon = Icons.Default.Bolt,
                    text = stringResource(id = R.string.reference_pf_range)
                )
                ReferenceRow(
                    icon = Icons.Default.Functions,
                    text = stringResource(id = R.string.reference_multiplier)
                )
            }
        }

        Card {
            Column(
                modifier = Modifier.padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Text(
                    text = stringResource(id = R.string.reference_tips),
                    style = MaterialTheme.typography.titleMedium
                )
                Text(text = stringResource(id = R.string.reference_tip_ohms))
                Text(text = stringResource(id = R.string.reference_tip_breaker))
                Text(text = stringResource(id = R.string.reference_tip_drop))
            }
        }
    }
}

@Composable
private fun ReferenceRow(icon: androidx.compose.ui.graphics.vector.ImageVector, text: String) {
    Row(
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(icon, contentDescription = null, tint = MaterialTheme.colorScheme.primary)
        Text(text)
    }
}
