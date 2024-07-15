package pt.ulusofona.appAtiteC.request

import pt.ulusofona.appAtiteC.dao.User
import javax.xml.stream.events.Comment

data class NewCommentRequest(val user: User, val comment: Comment)
