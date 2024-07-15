package pt.ulusofona.appAtiteC.controller

import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pt.ulusofona.appAtiteC.dao.Patient
import pt.ulusofona.appAtiteC.dao.PatientStatus
import pt.ulusofona.appAtiteC.dao.Test
import pt.ulusofona.appAtiteC.repository.PatientRepository
import pt.ulusofona.appAtiteC.repository.TestRepository
import pt.ulusofona.appAtiteC.repository.TreatmentRepository
import pt.ulusofona.appAtiteC.request.NewTestRequest
import java.time.LocalDateTime

@RestController
@RequestMapping("/api/tests")
class TestController(
    val testRepository: TestRepository,
    val patientRepository: PatientRepository,
    val treatmentRepository: TreatmentRepository,
) {

    @PostMapping("/new")
    fun insertNewTest(@RequestBody newTestRequest: NewTestRequest): ResponseEntity<String> {
        try {
            var patient = patientRepository.findByIdZeus(newTestRequest.patient.idZeus)
            if (patient == null) {
                /*val gender = when (newTestRequest.patient.gender?.toUpperCase()) {
                    "MALE", "MASCULINO" -> Gender.MALE
                    "FEMALE", "FEMININO" -> Gender.FEMALE
                    else -> Gender.OTHER
                }*/
                patient = Patient(
                    idZeus = newTestRequest.patient.idZeus,
                    name = newTestRequest.patient.name,
                    gender = newTestRequest.patient.gender,
                    birthDate = newTestRequest.patient.birthDate,
                    realId = newTestRequest.patient.realId,
                    documentType = newTestRequest.patient.documentType
                )
                patientRepository.save(patient)
            }

            if (newTestRequest.type == 1) {
                patient.state = if (newTestRequest.result == true) {
                    PatientStatus.POSITIVE_SCREENING
                } else {
                    PatientStatus.NED
                }
            } else {
                patient.state = if (newTestRequest.result == true) {
                    PatientStatus.POSITIVE_DIAGNOSIS
                } else {
                    PatientStatus.POSITIVE_SCREENING
                }
            }

            if (patient.state == PatientStatus.POST_TREATMENT_ANALYSIS){
                if (newTestRequest.result == true)
                    patient.state == PatientStatus.TREATMENT
                else
                    patient.state == PatientStatus.POSITIVE_SCREENING
            }


            val test = Test(
                type = newTestRequest.type,
                testDate = newTestRequest.testDate,
                testLocation = newTestRequest.testLocation,
                result = newTestRequest.result,
                resultDate = newTestRequest.resultDate,
                patientId = newTestRequest.patient.idZeus
            )

            val savedTest = testRepository.save(test)
            if (savedTest.id == null) {
                throw RuntimeException("Failed to save the test")
            }

            patient.statusDate = LocalDateTime.now()
            patient.lastScreening = savedTest
            patientRepository.save(patient)

            return ResponseEntity.ok("ok")
        } catch (e: Exception) {
            e.printStackTrace()  // Log the exception
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while saving the test: ${e.message}")
        }
    }

    @PutMapping("/update/{testId}")
    fun updateTest(@PathVariable testId: Int, @RequestBody updatedTest: Test): ResponseEntity<String> {
        return try {
            val testOptional = testRepository.findById(testId)
            if (testOptional.isPresent) {
                val test = testOptional.get()
                test.type = updatedTest.type
                test.testDate = updatedTest.testDate
                test.resultDate = updatedTest.resultDate
                test.result = updatedTest.result
                test.testLocation = updatedTest.testLocation
                test.patientId = updatedTest.patientId
                testRepository.save(test)
                ResponseEntity.ok("Test updated successfully")
            } else {
                ResponseEntity.status(HttpStatus.NOT_FOUND).body("Test not found")
            }
        } catch (e: Exception) {
            e.printStackTrace()
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while updating the test: ${e.message}")
        }
    }

    @GetMapping("/patient/{zeusId}")
    fun getTestsByPatient(@PathVariable zeusId: Int): ResponseEntity<Any> {
        return try {
            val patient = patientRepository.findByIdZeus(zeusId)
            if (patient == null) {
                ResponseEntity.status(HttpStatus.NOT_FOUND).body("Patient not found")
            } else {
                val tests = testRepository.findByPatientId(zeusId)
                ResponseEntity.ok(tests)
            }
        } catch (e: Exception) {
            e.printStackTrace()
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while fetching tests: ${e.message}")
        }
    }

    @GetMapping("/currentTest/{zeusId}")
    fun getCurrentTest(@PathVariable zeusId: Int): ResponseEntity<Any> {
        return try {
            val patient = patientRepository.findByIdZeus(zeusId)
            if (patient == null) {
                ResponseEntity.status(HttpStatus.NOT_FOUND).body("Patient not found")
            } else {
                val test = patient.lastScreening?.id?.let { testRepository.findById(it).orElse(null) }
                if (test == null) {
                    ResponseEntity.status(HttpStatus.NOT_FOUND).body("Current test not found")
                } else {
                    ResponseEntity.ok(test)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred while fetching current test: ${e.message}")
        }
    }

    @GetMapping("/all")
    fun getAllTests(): ResponseEntity<List<Test>?> {
        try {
            val tests = testRepository.findAll()
            return ResponseEntity.ok(tests)
        } catch (e: java.lang.Exception) {
            e.printStackTrace()
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null)
        }
    }
}
