package pt.ulusofona.appAtiteC.request

data class PostTreatmentRequest(val treatmentId: Int, val notes: String?, val cured: Boolean)
