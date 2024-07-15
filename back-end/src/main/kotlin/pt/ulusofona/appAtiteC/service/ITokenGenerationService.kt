package pt.ulusofona.appAtiteC.service


interface ITokenGenerationService {
    fun generateToken(size: Int = TOKEN_LENGTH): String
}