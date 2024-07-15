package pt.ulusofona.appAtiteC.form

import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.Pattern


data class UserForm(
    @field:NotEmpty(message = "Error: Please fill in the name")
    val firstName: String = "",

    @field:NotEmpty(message = "Error: Please fill in the email")
    @Email(message = "Error: Please fill in a valid email")
    val email: String = "",

    @field:NotEmpty(message = "Error: Please fill in the password")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$", message = "Error: Password is not strong enough")
    val password: String = "",
)
