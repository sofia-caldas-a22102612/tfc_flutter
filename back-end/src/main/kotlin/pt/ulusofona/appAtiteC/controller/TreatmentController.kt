package pt.ulusofona.appAtiteC.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import pt.ulusofona.appAtiteC.dao.PatientStatus
import pt.ulusofona.appAtiteC.dao.Treatment
import pt.ulusofona.appAtiteC.repository.PatientRepository
import pt.ulusofona.appAtiteC.repository.TreatmentRepository
import pt.ulusofona.appAtiteC.request.EndTreatmentRequest
import pt.ulusofona.appAtiteC.request.TreatmentRequest
import java.time.LocalDateTime

@RestController
@RequestMapping("/api/treatment")
class TreatmentController @Autowired constructor(
    val treatmentRepository: TreatmentRepository,
    val patientRepository: PatientRepository,
) {

    @PostMapping("/endTreatment")
    fun endTreatment(@RequestBody endTreatmentRequest: EndTreatmentRequest): ResponseEntity<String> {

        val patient = patientRepository.findByIdOrNull(endTreatmentRequest.idZeus)
            ?: return ResponseEntity("Patient doesn't exist", HttpStatus.NOT_FOUND)

        val treatment = getCurrentTreatmentFun(endTreatmentRequest.idZeus)
            ?: return ResponseEntity("Treatment doesn't exist", HttpStatus.NOT_FOUND)

        if (endTreatmentRequest.desistencia) {
            treatment.reasonsDropout = endTreatmentRequest.dropoutReason
        }

        if (endTreatmentRequest.notes != null) {
            treatment.endTreatmentComment = endTreatmentRequest.notes
        }

        treatment.postTreatmentStartDate = LocalDateTime.now()


        patient.state = PatientStatus.POST_TREATMENT_ANALYSIS
        patient.statusDate = LocalDateTime.now()

        patientRepository.save(patient)
        treatmentRepository.save(treatment)

        return ResponseEntity("ok", HttpStatus.OK)
    }

    @GetMapping("/history/{zeusId}")
    fun getTreatmentHistory(@PathVariable zeusId: Int): ResponseEntity<List<Treatment>> {
        val patient = patientRepository.findByIdZeus(zeusId) ?: return ResponseEntity(HttpStatus.NOT_FOUND)

        val treatmentList = treatmentRepository.findByPatientId(patient.idZeus)
        return ResponseEntity.ok(treatmentList)
    }

    @PostMapping("/new")
    fun createTreatment(@RequestBody treatmentRequest: TreatmentRequest): ResponseEntity<String> {
        return try {
            val patient = patientRepository.findByIdOrNull(treatmentRequest.patientId)
                ?: throw IllegalArgumentException("Patient doesn't exist")

            val treatment = Treatment(
                startDate = treatmentRequest.startDate,
                realEndDate = null,
                postTreatmentStartDate = null,
                reasonsDropout = 0,
                endTreatmentComment = null,
                nameMedication = treatmentRequest.nameMedication,
                patientId = treatmentRequest.patientId,
                treatmentDuration = treatmentRequest.treatmentDuration
            )

            patient.state = PatientStatus.TREATMENT
            patient.currentTreatmentId = treatment.id

            patientRepository.save(patient)
            treatmentRepository.save(treatment)

            ResponseEntity("Treatment created successfully", HttpStatus.OK)
        } catch (e: Exception) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error occurred: ${e.message}")
        }
    }

    @GetMapping("/current/{zeusId}")
    fun getCurrentTreatment(@PathVariable zeusId: Int): ResponseEntity<Treatment> {
        val patient = patientRepository.findByIdZeus(zeusId)
            ?: return ResponseEntity(HttpStatus.NOT_FOUND)

        val treatments = treatmentRepository.findByPatientId(patient.idZeus)
            .sortedByDescending { it.startDate }

        if (patient.state != PatientStatus.TREATMENT) {
            return ResponseEntity(HttpStatus.BAD_REQUEST)
        }

        if (treatments.isEmpty()) {
            return ResponseEntity(HttpStatus.NOT_FOUND)
        }

        patient.currentTreatmentId = treatments.first().id

        return ResponseEntity(treatments.first(), HttpStatus.OK)
    }

    fun getCurrentTreatmentFun(@PathVariable zeusId: Int): Treatment {

        val patient = patientRepository.findByIdZeus(zeusId)

        val treatments = patient?.let {
            treatmentRepository.findByPatientId(it.idZeus)
                .sortedByDescending { it.startDate }
        }


        if (patient != null) {
            patient.currentTreatmentId = treatments!!.first().id
        }

        return treatments!!.first()
    }

}
