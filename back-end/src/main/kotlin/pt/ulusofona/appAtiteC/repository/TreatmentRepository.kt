package pt.ulusofona.appAtiteC.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import pt.ulusofona.appAtiteC.dao.Treatment

interface TreatmentRepository : JpaRepository<Treatment, Int> {

    @Query("SELECT t FROM Treatment t WHERE t.patientId = :zeusId ORDER BY t.startDate DESC")
    fun findLatestTreatmentByZeusId(@Param("zeusId") zeusId: Int): Treatment?

    fun findByPatientId(patientId: Int): List<Treatment>
}
