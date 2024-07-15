package pt.ulusofona.appAtiteC.request

import PatientRequest
import java.time.LocalDateTime

data class NewTestRequest(
    val type: Int,
    val result: Boolean? = null,
    val resultDate: LocalDateTime? = null,
    val testLocation: Int?,
    val testDate: LocalDateTime? = null,
    val patient: PatientRequest
)
