package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
data class Test(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Int? = null,

    @Column(name = "type", nullable = false)
    var type: Int,

    @Column(name = "test_date", nullable = true)
    var testDate: LocalDateTime? = null,

    @Column(name = "result_date", nullable = true)
    var resultDate: LocalDateTime? = null,

    @Column(name = "result", nullable = true)
    var result: Boolean? = null,

    @Column(name = "test_location", nullable = false)
    var testLocation: Int? = null,

    @Column(name = "patientId", nullable = false)
    var patientId: Int,

    @ManyToOne(optional = true)
    @JoinColumn(name = "staff_id", nullable = true)
    var user: User? = null
) {
    // Protected no-arg constructor for JPA
    protected constructor() : this(
        id = null,
        type = 0,
        testDate = null,
        resultDate = null,
        result = null,
        testLocation = null,
        patientId = 0,  // default value for patientId
        user = null
    )
}
