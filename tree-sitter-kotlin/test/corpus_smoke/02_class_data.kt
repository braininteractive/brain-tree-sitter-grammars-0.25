data class User(val id: Long, val name: String, val email: String? = null)

class Repo(private val users: MutableList<User> = mutableListOf()) {
    fun add(u: User): Boolean = users.add(u)
    fun find(id: Long): User? = users.firstOrNull { it.id == id }
}
