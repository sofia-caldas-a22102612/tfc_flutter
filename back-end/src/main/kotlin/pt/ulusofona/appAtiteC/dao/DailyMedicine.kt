package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
data class DailyMedicine(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Int = 0,

    @Column(name = "date", nullable = false)
    val date: LocalDateTime = LocalDateTime.now(),

    @Column(name = "took_medicine", nullable = true)
    var tookMedicine: Boolean = false,

    @Column(name = "to_take_at_home", nullable = true)
    val takeAtHome: Boolean = false,

    @Column(name = "notes", length = 500, nullable = true)
    var notes: String? = null,

    @Column(name = "treatmentId", length = 500, nullable = false)
    var treatmentId: Int = 0,

    @Column(name = "patientId", length = 500, nullable = false)
    var patientId: Int = 0,
)
