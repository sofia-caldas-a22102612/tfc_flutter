package pt.ulusofona.appAtiteC.form

import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.Positive


data class ExpenseForm(
    @field:NotEmpty(message = "Error: Please fill in the title")
    val title: String? = null,

    @field:Positive(message = "Error: Please fill in the type")
    val type: Long? = null,

    @field:Positive(message = "Error: Please fill in a valid amount")
    val amount: Double? = null
)
