package pt.ulusofona.appAtiteC.request

data class EndTreatmentRequest(val idZeus: Int, val desistencia: Boolean, val dropoutReason: Int?,
                               val notes: String?)
