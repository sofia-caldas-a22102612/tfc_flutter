package pt.ulusofona.appAtiteC.request

import java.time.LocalDateTime

data class NewPatientRequest(val name: String, val birthDate: LocalDateTime, val age: Int, val gender: String,
                             val realId: String, val documentType: Int, val lastProgramName: String, val userId: Long)
