package pt.ulusofona.appAtiteC

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.context.annotation.Profile
import org.springframework.security.provisioning.UserDetailsManager
import org.springframework.stereotype.Component
import pt.ulusofona.appAtiteC.dao.Patient
import pt.ulusofona.appAtiteC.dao.Role
import pt.ulusofona.appAtiteC.dao.User
import pt.ulusofona.appAtiteC.repository.PatientRepository
import pt.ulusofona.appAtiteC.repository.UserRepository
import java.time.LocalDateTime


@Component
@Profile("!test")
class DataLoader(

    val userRepository: UserRepository,
    val userDetailsManager: UserDetailsManager,
    //aqui
    val patientRepository: PatientRepository,

) : ApplicationRunner {

    var logger: Logger = LoggerFactory.getLogger(DataLoader::class.java)

    override fun run(args: ApplicationArguments?) {

        logger.info("Environment variables:")
        for ((key, value) in System.getenv()) {
            logger.info("\t$key : $value")
        }

        val countUsers = userRepository.count()

        if (countUsers == 0L) {
            logger.info("No users yet, let's create two users")
            // let's create a super user
            userDetailsManager.createUser(
                User(firstName = "admin", email = "admin", pass = "123",
                    rolesAsList = listOf(Role.ROLE_USER, Role.ROLE_ADMIN),
                    emailConfirmed = true)
            )
            userDetailsManager.createUser(
                User(firstName = "user", email = "user", pass = "password",
                    rolesAsList = listOf(Role.ROLE_USER),
                    emailConfirmed = true)
            )
        } else {
            logger.info("Users already created, nothing to do here...")
        }



        if (patientRepository.findAll().isEmpty()) {
            logger.info("No patients yet, let's create three patients")
            patientRepository.save(Patient(
                idZeus = 123,
                name = "Patient One",
                birthDate = LocalDateTime.of(1990, 1, 1, 0, 0),
                realId = "123456789",
                documentType = "cc",
                lastProgramName = "Program XYZ",
                lastProgramDate = LocalDateTime.now(),
                userId = 1L,
                lastScreening = null
            ))
            patientRepository.save(
                Patient(
                idZeus = 231,
                name = "Patient Two",
                birthDate = LocalDateTime.of(1995, 5, 5, 0, 0),
                realId = "987654321",
                documentType = "cc",
                lastProgramName = "Program ABC",
                lastProgramDate = LocalDateTime.now(),
                userId = 2L,
                    lastScreening = null

            )
            )
            patientRepository.save(Patient(
                idZeus = 333,
                name = "Patient Three",
                birthDate = LocalDateTime.of(1985, 10, 10, 0, 0),
                realId = "111222333",
                documentType = "cc",
                lastProgramName = "Program 123",
                lastProgramDate = LocalDateTime.now(),
                userId = 3L,
                lastScreening = null

            ))
        } else {
            logger.info("Patients already created, nothing to do here...")
        }

    }
}