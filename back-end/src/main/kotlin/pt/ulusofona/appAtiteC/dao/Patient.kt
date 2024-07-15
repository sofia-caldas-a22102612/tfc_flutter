package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*
import java.time.LocalDateTime

enum class PatientStatus {
    NED,
    POSITIVE_SCREENING,
    POSITIVE_DIAGNOSIS,
    TREATMENT,
    POST_TREATMENT_ANALYSIS,
    FINISHED,
    NOT_IN_DATABASE
}



enum class Gender {
    MALE,
    FEMALE,
    OTHER
}

@Entity
data class Patient(
    @Id
    @Column(name = "zeusId", unique = true)
    val idZeus: Int = 0,

    @Column(name = "name", length = 100, nullable = false)
    val name: String = "",

    @Column(name = "birth_date")
    val birthDate: LocalDateTime? = null,

    @Column(name = "real_id")
    val realId: String? = null,

    @Column(name = "document_type")
    val documentType: String? = null,

    @Column(name = "last_program_name", length = 100)
    val lastProgramName: String? = null,

    @Column(name = "last_program_date")
    val lastProgramDate: LocalDateTime? = null,

    @Column(name = "id_user", nullable = true)
    val userId: Long = 0,

    @Column(name = "current_treatment_id", nullable = true)
    var currentTreatmentId: Int? = 0,

    @ManyToOne
    @JoinColumn(name = "last_Screening_id", nullable = true) //todo change this to treatment_Id
    var lastScreening: Test? = null,

    @Enumerated(EnumType.STRING)
    @Column(length = 100)
    var state: PatientStatus = PatientStatus.NOT_IN_DATABASE,

    @Column(name = "gender", nullable = true) //todo change to enum
    val gender: String? = null,

    @Column(name = "statusDate", nullable = true)
    var statusDate: LocalDateTime? = null,
)
