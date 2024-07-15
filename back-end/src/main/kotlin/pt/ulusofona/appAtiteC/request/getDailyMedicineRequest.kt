package pt.ulusofona.appAtiteC.request

import java.time.LocalDateTime

data class GetDailyMedicineRequest(
    val idZeus: Int,
    val dateTime: LocalDateTime
)
