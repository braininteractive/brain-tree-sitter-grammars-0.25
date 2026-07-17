sealed class Result<out T> {
    data class Ok<T>(val value: T) : Result<T>()
    data class Err(val cause: Throwable) : Result<Nothing>()
    object Pending : Result<Nothing>()
}

enum class Direction(val degrees: Int) {
    NORTH(0), EAST(90), SOUTH(180), WEST(270);

    fun opposite(): Direction = entries[(ordinal + 2) % entries.size]
}
