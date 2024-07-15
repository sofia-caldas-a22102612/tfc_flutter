package pt.ulusofona.appAtiteC.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import pt.ulusofona.appAtiteC.dao.DailyMedicine
import java.time.LocalDate


interface DailyMedicineRepository : JpaRepository<DailyMedicine, Int> {

    @Query("SELECT d FROM DailyMedicine d WHERE d.patientId = :patientId AND DATE(d.date) = :date")
    fun findByPatientIdAndDate(
        @Param("patientId") patientId: Int,
        @Param("date") date: LocalDate?,
    ): DailyMedicine?
}
