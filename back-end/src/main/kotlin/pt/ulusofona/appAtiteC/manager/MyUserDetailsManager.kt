package pt.ulusofona.appAtiteC.manager

import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.provisioning.UserDetailsManager
import pt.ulusofona.appAtiteC.dao.User
import pt.ulusofona.appAtiteC.repository.UserRepository
import pt.ulusofona.appAtiteC.service.EmailService
import pt.ulusofona.appAtiteC.service.ITokenGenerationService


class MyUserDetailsManager(
    val userRepository: UserRepository,
    val tokenGenerationService: ITokenGenerationService,
    val emailService: EmailService
) : UserDetailsManager {

    override fun loadUserByUsername(username: String?): UserDetails {

        if (username == null) {
            throw IllegalArgumentException("username must be filled")
        }

        val user = userRepository.findByEmail(username) ?: throw UsernameNotFoundException("Couldn't find a user whose email is $username")

        if (!user.emailConfirmed) {
            throw UsernameNotFoundException("Couldn't find a user whose email is $username")
        }

        return user
    }

    override fun createUser(user: UserDetails?) {
        if (user == null || user !is User) {
            throw IllegalArgumentException("user must not be null and must be an instance of ${User::class.java.name}")
        }

        // generate email token
        if (!user.emailConfirmed) {
            val token = tokenGenerationService.generateToken(5)
            user.emailToken = token
            userRepository.save(user)

            // send email
            emailService.send(
                recipient = user.email,
                subject = "Please confirm your email",
                body = "Copy this code to the signup page: ${user.emailToken}"
            )
        } else {
            userRepository.save(user)
        }
    }

    override fun updateUser(user: UserDetails?) {
        if (user == null || user !is User) {
            throw IllegalArgumentException("user must not be null and must be an instance of ${User::class.java.name}")
        }
        TODO("Not yet implemented")
    }

    override fun deleteUser(username: String?) {
        if (username == null) {
            throw IllegalArgumentException("username must be filled")
        }
        TODO("Not yet implemented")
    }

    override fun changePassword(oldPassword: String?, newPassword: String?) {
        TODO("Not yet implemented")
    }

    override fun userExists(username: String?): Boolean {
        if (username == null) {
            throw IllegalArgumentException("username must be filled")
        }

        return userRepository.existsByEmail(username)
    }
}