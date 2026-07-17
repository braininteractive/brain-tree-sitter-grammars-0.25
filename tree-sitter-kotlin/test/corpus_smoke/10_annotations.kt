@Target(AnnotationTarget.CLASS, AnnotationTarget.FUNCTION)
@Retention(AnnotationRetention.RUNTIME)
annotation class Route(val path: String, val method: String = "GET")

@Route("/users")
class UserController {
    @Route("/users/{id}", method = "DELETE")
    fun delete(@Suppress("UNUSED_PARAMETER") id: Long) = Unit
}
