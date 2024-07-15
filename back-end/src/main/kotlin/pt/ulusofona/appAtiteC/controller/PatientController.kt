package pt.ulusofona.appAtiteC.controller

import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pt.ulusofona.appAtiteC.dao.Patient
import pt.ulusofona.appAtiteC.dao.PatientStatus
import pt.ulusofona.appAtiteC.dao.Test
import pt.ulusofona.appAtiteC.repository.PatientRepository
import pt.ulusofona.appAtiteC.repository.TestRepository
import java.time.LocalDateTime


@RestController
@RequestMapping("/api/patient")
class PatientController(
    val patientRepository: PatientRepository, val testRepository: TestRepository,
) {

    @GetMapping("/list")
    fun listPatients(): ResponseEntity<List<Patient>> {
        return try {
            val patients = patientRepository.findAll()
            ResponseEntity.ok(patients)
        } catch (e: Exception) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(emptyList())
        }
    }


    @GetMapping("/search/{input}")
    fun getPatients(@PathVariable input: String): ResponseEntity<out Any?> {

        if (input.all { it.isDigit() }) {
            val patient: Patient? = patientRepository.findByIdOrNull(input.toInt())
            return ResponseEntity(patient, HttpStatus.OK)
        } else {
            val patients: List<Patient> = patientRepository.findByNameContainingIgnoreCase(input)
            return ResponseEntity(patients, HttpStatus.OK)
        }
    }

    @GetMapping("/activeTreatment")
    fun getPatientsInTreatment(): ResponseEntity<List<Patient>?> {
        try {
            val patients: List<Patient> = patientRepository.findByStateOrNull(PatientStatus.TREATMENT)
            return if (patients.isEmpty()) {
                ResponseEntity.ok(null)
            } else {
                ResponseEntity.ok(patients)
            }
        } catch (e: java.lang.Exception) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null)
        }
    }



    @GetMapping("/activePostTreatment")
    fun getPatientsInPostTreatment(): ResponseEntity<List<Patient>?> {
        try {
            val patients: List<Patient> = patientRepository.findByStateOrNull(PatientStatus.POST_TREATMENT_ANALYSIS)
            val ninetyDaysAgo = LocalDateTime.now().minusDays(90)

            // Filter patients based on the post-treatment start date
            val filteredPatients = patients.filter { it.statusDate?.isBefore(ninetyDaysAgo) == true }

            return if (filteredPatients.isEmpty()) {
                ResponseEntity.ok(null)
            } else {
                ResponseEntity.ok(filteredPatients)
            }
        } catch (e: Exception) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null)
        }
    }



    //todo alterei para retornar NED se utente não existir na nossa base de dados
    @GetMapping("/currentStatus{zeusId}")
    fun getCurrentState(@RequestParam zeusId: Int): ResponseEntity<Map<String, Any?>> {
        val patient = patientRepository.findByIdZeus(zeusId)
        val status = patient?.state ?: PatientStatus.NOT_IN_DATABASE
        val statusDate = patient?.statusDate ?: LocalDateTime.now()
        val result = mapOf("status" to status.name, "statusDate" to statusDate)
        return ResponseEntity(result, HttpStatus.OK)
    }


    /* PALVES - Este endpoint não deveria existir, são os outros endpoints que mudam o estado do paciente
    @PostMapping("/updateStatus/{zeusId}")
    fun updatePatientStatus(@RequestParam zeusId: Int, @RequestParam patientStatus: String): ResponseEntity<String> {
        val patient = patientRepository.findByIdOrNull(zeusId)

        if (patient != null) {
            val newStatus = PatientStatus.valueOf(patientStatus)

            // Update patient status
            newStatus.also { patient.state = it }
            patientRepository.save(patient)

            return ResponseEntity.ok("Patient status updated successfully")
        } else {
            return ResponseEntity.badRequest().body("Patient not found")
        }
    }
*/

    @GetMapping("/lastScreening/{zeusId}")
    fun getLastScreening(@PathVariable zeusId: Int): ResponseEntity<Test?> {
        val patient: Patient? = patientRepository.findByIdZeus(zeusId)
        return if (patient != null) {
            val lastScreening: Test? = patient.lastScreening
            ResponseEntity(lastScreening, HttpStatus.OK)
        } else {
            ResponseEntity(HttpStatus.NOT_FOUND)
        }
    }
}
