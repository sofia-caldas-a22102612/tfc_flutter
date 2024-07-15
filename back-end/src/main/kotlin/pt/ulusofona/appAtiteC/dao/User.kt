package pt.ulusofona.appAtiteC.dao

import jakarta.persistence.*
import org.springframework.security.core.GrantedAuthority
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.crypto.factory.PasswordEncoderFactories
import org.springframework.security.crypto.password.PasswordEncoder


val passwordEncoder: PasswordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder()

@Entity
class User(
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    val id: Long? = null,

    val firstName: String = "",
    val lastName: String = "",

    @Column(unique = true)
    val email: String = "",
    var pass: String = "",

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true, fetch = FetchType.EAGER)
    val roles: MutableSet<UserRole> = mutableSetOf(),

    @Transient
    val rolesAsList: List<Role> = emptyList(),

    var active: Boolean = true,

    var emailConfirmed: Boolean = false,
    var emailToken: String? = null,

    var resetPasswordToken: String? = null,
) : UserDetails {

    init {
        pass = passwordEncoder.encode(pass)
        rolesAsList.forEach { roles.add(UserRole(user = this, role = it)) }
    }

    override fun getUsername(): String  = email

    override fun getPassword(): String = pass

    override fun isAccountNonExpired() = true

    override fun isAccountNonLocked() = true

    override fun isCredentialsNonExpired() = true

    override fun getAuthorities(): MutableCollection<out GrantedAuthority>  =
        roles.map { SimpleGrantedAuthority(it.role?.name) }.toMutableList()

    override fun isEnabled() = active
}