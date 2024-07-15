package pt.ulusofona.appAtiteC.repository

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.data.repository.query.Param
import pt.ulusofona.appAtiteC.dao.Patient
import pt.ulusofona.appAtiteC.dao.PatientStatus

interface PatientRepository : JpaRepository<Patient, Int> {

    fun findByNameContainingIgnoreCase(name: String): List<Patient>
    fun findByIdZeus(idZeus: Int): Patient?

    @Query("SELECT p FROM Patient p WHERE p.state = :status OR p.state IS NULL")
    fun findByStateOrNull(@Param("status") status: PatientStatus): List<Patient>

}
