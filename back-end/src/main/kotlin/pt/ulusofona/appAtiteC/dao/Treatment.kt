package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
data class Treatment(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Int = 0,

    @Column(name = "start_date", nullable = false)
    val startDate: LocalDateTime = LocalDateTime.now(),

    @Column(name = "real_end_date", nullable = true)
    var realEndDate: LocalDateTime? = null,

    @Column(name = "post_treatment_start_date", nullable = true)
    var postTreatmentStartDate: LocalDateTime? = null,

    @Column(name = "name_medication", nullable = true)
    val nameMedication: Int? = null,

    @Column(name = "reasons_dropout", nullable = true)
    var reasonsDropout: Int? = null,

    @Column(name = "end_treatment_comments", nullable = true)
    var endTreatmentComment: String? = null,

    @Column(name = "treatment_duration", nullable = true)
    var treatmentDuration: Int? = null,

    @Column(name = "patient_id", nullable = false)
    var patientId: Int = 0
)
