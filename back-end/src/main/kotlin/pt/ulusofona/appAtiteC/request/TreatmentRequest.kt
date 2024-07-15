package pt.ulusofona.appAtiteC.request

import java.time.LocalDateTime

data class TreatmentRequest(
    val startDate: LocalDateTime,
    val nameMedication: Int?,
    val patientId: Int,
    val treatmentDuration: Int?
)
