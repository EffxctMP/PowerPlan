package com.powerplan

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface

/**
 * Android entry point mirroring the original SwiftUI `Power_PlanApp`.
 *
 * Drop this into an Android Studio project to launch the shared Compose
 * dashboard defined in [PowerPlanApp].
 */
class PowerPlanActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            MaterialTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    PowerPlanApp()
                }
            }
        }
    }
}
