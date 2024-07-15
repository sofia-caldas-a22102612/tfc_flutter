package pt.ulusofona.appAtiteC.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import pt.ulusofona.appAtiteC.dao.Test

interface TestRepository : JpaRepository<Test, Int> {
    fun findByPatientId(patientId: Int): List<Test>?

    @Query("SELECT t FROM Test t WHERE t.patientId = :patientId ORDER BY t.testDate DESC")
    fun findLatestTestByPatient(patientId: Int): Test?
}
