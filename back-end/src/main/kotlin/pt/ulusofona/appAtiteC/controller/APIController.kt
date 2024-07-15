package pt.ulusofona.appAtiteC.controller

import org.springframework.web.bind.annotation.*


@RestController
@RequestMapping("/api")
class APIController {

    // this endpoint exists only to facilitate credentials validation
    @GetMapping("/validateCredentials")
    fun validateCredentials(): String = "ok"
}