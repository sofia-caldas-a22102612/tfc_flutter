package pt.ulusofona.appAtiteC.service

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.mail.SimpleMailMessage
import org.springframework.mail.javamail.JavaMailSender
import org.springframework.stereotype.Service


@Service
class EmailService(val mailSender: JavaMailSender) {

    var logger: Logger = LoggerFactory.getLogger(EmailService::class.java)

    fun send(recipient: String, subject: String, body: String) {
        val message = SimpleMailMessage()
        message.from = "deisi.labs@gmail.com"
        message.setTo(recipient)
        message.subject = subject
        message.text = body

        mailSender.send(message)

        logger.info("Sent email to $recipient (subject: $subject)")
    }
}