package pt.ulusofona.appAtiteC.filters

import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.http.HttpStatus
import org.springframework.web.filter.OncePerRequestFilter

class APITokenFilter(val apiToken: String): OncePerRequestFilter() {

    var logger: Logger = LoggerFactory.getLogger(APITokenFilter::class.java)

    override fun doFilterInternal(request: HttpServletRequest, response: HttpServletResponse, filterChain: FilterChain) {
        val token = request.getHeader("x-api-token")
        if (token == null || token != apiToken) {
            response.status = HttpStatus.FORBIDDEN.value()
            return
        }

        filterChain.doFilter(request, response)
    }
}