package eu.kanade.presentation.theme

import androidx.compose.ui.unit.dp

enum class CudyWindowClass { Compact, Medium, Expanded }

object CudyLayoutTokens {
    const val MEDIUM_MIN_WIDTH_DP = 600
    const val EXPANDED_MIN_WIDTH_DP = 840

    val gutter = 16.dp
    val cardRadius = 12.dp
    val heroMaxWidth = 920.dp

    fun windowClass(widthDp: Int) = when {
        widthDp >= EXPANDED_MIN_WIDTH_DP -> CudyWindowClass.Expanded
        widthDp >= MEDIUM_MIN_WIDTH_DP -> CudyWindowClass.Medium
        else -> CudyWindowClass.Compact
    }
}
