package pt.ulusofona.appAtiteC.controller

import org.slf4j.LoggerFactory
import org.springframework.data.repository.findByIdOrNull
import org.springframework.format.annotation.DateTimeFormat
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pt.ulusofona.appAtiteC.dao.DailyMedicine
import pt.ulusofona.appAtiteC.repository.DailyMedicineRepository
import pt.ulusofona.appAtiteC.repository.PatientRepository
import pt.ulusofona.appAtiteC.repository.TreatmentRepository
import pt.ulusofona.appAtiteC.request.DailyMedicineRequest
import java.time.LocalDate


@RestController
@RequestMapping("/api/dailyMedicine")
class DailyMedicineController(
    private val dailyMedicineRepository: DailyMedicineRepository,
    private val patientRepository: PatientRepository,
    private val treatmentRepository: TreatmentRepository,
    private val treatmentController: TreatmentController,
) {

    private val logger = LoggerFactory.getLogger(DailyMedicineController::class.java)

    @PostMapping("/new")
    fun insertDailyMedicine(@RequestBody dailyMedicineRequest: DailyMedicineRequest): ResponseEntity<String> {
        logger.info("Received new daily medicine request: {}", dailyMedicineRequest)

        val patient = patientRepository.findByIdOrNull(dailyMedicineRequest.patientId)
            ?: run {
                logger.error("Patient with ID {} doesn't exist", dailyMedicineRequest.patientId)
                return ResponseEntity("Patient doesn't exist", HttpStatus.NOT_FOUND)
            }

        val treatmentId = patient.currentTreatmentId

        val treatment = treatmentController.getCurrentTreatmentFun(patient.idZeus)
            ?: run {
                logger.error("Treatment for patient ID {} doesn't exist", dailyMedicineRequest.patientId)
                return ResponseEntity("Treatment doesn't exist", HttpStatus.NOT_FOUND)
            }


        val dailyMedicine = DailyMedicine(
            date = dailyMedicineRequest.date,
            notes = dailyMedicineRequest.notes,
            patientId = patient.idZeus,
            treatmentId = treatment.id,
            tookMedicine = dailyMedicineRequest.tookMedicine,
            takeAtHome = dailyMedicineRequest.takeAtHome
        )

        dailyMedicineRepository.save(dailyMedicine)
        logger.info("Successfully saved daily medicine for patient ID {}", dailyMedicineRequest.patientId)
        return ResponseEntity("ok", HttpStatus.OK)
    }

    @ExceptionHandler(Exception::class)
    fun handleException(e: Exception): ResponseEntity<String> {
        logger.error("An error occurred: {}", e.message)
        return ResponseEntity("An error occurred: ${e.message}", HttpStatus.INTERNAL_SERVER_ERROR)
    }


    @GetMapping("/get")
    fun getDailyMedicine(
        @RequestParam idZeus: Int,
        @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) date: LocalDate
    ): ResponseEntity<DailyMedicine> {
        logger.info("Fetching daily medicine for patient ID {} on {}", idZeus, date)

        val dailyMedicine = dailyMedicineRepository.findByPatientIdAndDate(idZeus, date)
        return if (dailyMedicine == null) {
            logger.error("No daily medicine found for patient ID {} on {}", idZeus, date)
            ResponseEntity(HttpStatus.NOT_FOUND)
        } else {
            ResponseEntity(dailyMedicine, HttpStatus.OK)
        }
    }
}
