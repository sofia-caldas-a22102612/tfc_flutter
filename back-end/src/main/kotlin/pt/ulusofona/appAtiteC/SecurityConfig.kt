package pt.ulusofona.appAtiteC

import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.web.util.matcher.AntPathRequestMatcher
import pt.ulusofona.appAtiteC.filters.APITokenFilter
import pt.ulusofona.appAtiteC.manager.MyUserDetailsManager
import pt.ulusofona.appAtiteC.repository.UserRepository
import pt.ulusofona.appAtiteC.service.EmailService
import pt.ulusofona.appAtiteC.service.ITokenGenerationService

@Configuration
@EnableWebSecurity
class SecurityConfig {

    @Value("\${api.token}")
    val apiToken: String = ""

    @Bean
    fun webSecurityFilterChain(http: HttpSecurity): SecurityFilterChain {
        return http
            .securityMatcher("/web/**", "/login", "/", "/error", "/logout")
            .authorizeHttpRequests { authorize ->
                authorize.requestMatchers(
                    "/web/expenseType/list",
                    "/web/user/new",
                    "/web/user/verify",
                    "/web/user/resetPassword",
                    "/web/user/changePasswordFromEmail",
                    "/error",
                    "/favicon.ico").permitAll()
                authorize.anyRequest().authenticated() }
//            .formLogin(Customizer.withDefaults())
            .formLogin()
                .loginPage("/login")
                .permitAll()
            .and()
                .logout()
                .logoutRequestMatcher(AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout")  // TODO
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession(true)
            .and()
            .build()

    }

    @Bean
    fun apiSecurityFilterChain(http: HttpSecurity): SecurityFilterChain {
        return http
            .securityMatcher("/api/**")
            .authorizeHttpRequests { authorize ->
                authorize.requestMatchers("/api/expenseType/list").permitAll()
                authorize.anyRequest().authenticated() }
            .httpBasic()
            .and()
            .addFilterBefore(APITokenFilter(apiToken), UsernamePasswordAuthenticationFilter::class.java)
            .csrf().disable()  // REST doesn't need this
            .build()

    }

//    @Bean
//    fun userDetailsService(): UserDetailsService {
//        return InMemoryUserDetailsManager(
//            User.builder()
//                .username("user")
//                .password("{noop}123")
//                .authorities("ROLE_USER")
//                .build()
//        )
//    }

//    @Bean
//    fun userDetailsManager(dataSource: DataSource) = JdbcUserDetailsManager(dataSource)

    @Bean
    fun userDetailsManager(userRepository: UserRepository,
                           tokenGenerationService: ITokenGenerationService,
                           emailService: EmailService) =
        MyUserDetailsManager(userRepository, tokenGenerationService, emailService)
}