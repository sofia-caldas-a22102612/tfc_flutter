package pt.ulusofona.appAtiteC.service

import org.springframework.context.annotation.Profile
import org.springframework.stereotype.Service
import pt.ulusofona.appAtiteC.repository.UserRepository

const val TOKEN_LENGTH = 20

@Service
@Profile("!test")
class TokenGenerationService(val userRepository: UserRepository) : ITokenGenerationService {

    private val charPool : List<Char> = ('a'..'z') + ('A'..'Z') + ('0'..'9') // for token generation

    override fun generateToken(size: Int) : String {
        // make sure we generate a unique token
        var randomToken: String
        do {
            randomToken = (1..size)
                .map { _ -> kotlin.random.Random.nextInt(0, charPool.size) }
                .map(charPool::get)
                .joinToString("");
        } while (userRepository.existsByEmailToken(randomToken))

        return randomToken
    }
}