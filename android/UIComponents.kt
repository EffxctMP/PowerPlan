package com.powerplan.ui

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

/**
 * Jetpack Compose counterpart to the SwiftUI `CardGroupBoxStyle`.
 *
 * Drop this into an Android Studio project to wrap grouped content in a
 * softly elevated card with consistent padding, spacing, and a subtle border
 * that mirrors the iOS styling.
 */
@Composable
fun CardGroupBox(
    modifier: Modifier = Modifier,
    cornerRadius: Dp = 20.dp,
    backgroundColor: Color = MaterialTheme.colorScheme.surfaceVariant,
    borderColor: Color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.08f),
    content: @Composable () -> Unit
) {
    val shape = RoundedCornerShape(cornerRadius)

    Surface(
        modifier = modifier
            .fillMaxWidth()
            .shadow(elevation = 10.dp, shape = shape)
            .border(BorderStroke(1.dp, borderColor), shape = shape),
        shape = shape,
        color = backgroundColor,
        tonalElevation = 0.dp
    ) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            content()
        }
    }
}
