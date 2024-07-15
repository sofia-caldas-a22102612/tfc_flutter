package pt.ulusofona.appAtiteC.request

import java.time.LocalDateTime

data class DailyMedicineRequest( val date: LocalDateTime,
                                 var tookMedicine: Boolean = false,
                                 val takeAtHome: Boolean = false,
                                 val notes: String? = null,
                                 var patientId: Int)
