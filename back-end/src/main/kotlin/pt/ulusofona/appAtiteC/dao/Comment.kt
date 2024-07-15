package pt.ulusofona.appAtiteC.dao

import com.fasterxml.jackson.annotation.JsonIgnore
import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
data class Comment(

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    var id: Int? = null,

    @Column(name = "type", nullable = false)
    var comment: String = "",

    @Column(name = "date", nullable = false)
    var testDate: LocalDateTime? = null,

    @ManyToOne(optional = false)
    @JoinColumn(name = "staff_id", nullable = false)
    @JsonIgnore
    var author: User? = null,

    @ManyToOne(optional = false)
    @JoinColumn(name = "treatment_id", nullable = false)
    @JsonIgnore
    var treatment: Treatment? = null
)
