package pt.ulusofona.appAtiteC.controller

import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping

@Controller
class GeneralController {

    @RequestMapping("/")
    fun root() = "home"

    @RequestMapping("/home")
    fun home() = "redirect:/web/expenseType/list"

    @GetMapping("/login")
    fun login() = "user/login-form"
}