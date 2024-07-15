/*package pt.ulusofona.appAtiteC.controller

import org.springframework.data.repository.findByIdOrNull
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import pt.ulusofona.appAtiteC.dao.DailyMedicine
import pt.ulusofona.appAtiteC.repository.DailyMedicineRepository
import pt.ulusofona.appAtiteC.repository.TreatmentRepository
import pt.ulusofona.appAtiteC.repository.UserRepository
import pt.ulusofona.appAtiteC.request.DailyMedicineRequest

class CommentController(private val dailyMedicineRepository: DailyMedicineRepository,
                        private val treatmentRepository: TreatmentRepository) {

    @PostMapping("/new")
    fun addComment(@RequestBody dailyMedicineRequest: DailyMedicineRequest,
                            treatmentRepository: TreatmentRepository,
                   userRepository: UserRepository): ResponseEntity<String> {

        val treatment = treatmentRepository.findByIdOrNull(dailyMedicineRequest.treatmentId)

        if (treatment==null){
            throw IllegalArgumentException("Treatment doesn't exist")
        }

        val dailyMedicine = DailyMedicine(
            date = dailyMedicineRequest.date, notes


        = dailyMedicineRequest.notes,
            treatment = treatment)

        dailyMedicineRepository.save(dailyMedicine)
        return ResponseEntity("ok", HttpStatus.OK)
    }
}*/