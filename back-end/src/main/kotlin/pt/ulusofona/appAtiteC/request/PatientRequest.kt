import java.time.LocalDateTime

data class PatientRequest(
    val idZeus: Int,
    val name: String,
    val birthDate: LocalDateTime,  // Ensure proper parsing
    val gender: String,
    val realId: String? = null,
    val documentType: String? = null,
    //todo add when lastProgram info is available
    //val lastProgramName: String? = null,
    //val lastProgramDateTime: LocalDateTime? = null // Ensure proper parsing
)