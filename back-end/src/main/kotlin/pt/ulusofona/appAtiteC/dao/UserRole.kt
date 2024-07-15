package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*


enum class Role {
    ROLE_USER, ROLE_ADMIN
}

@Entity
data class UserRole(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    val user: User? = null,

    @Enumerated(EnumType.STRING)
    val role: Role? = null
)
