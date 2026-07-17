fun String.titlecase(): String =
    replaceFirstChar { if (it.isLowerCase()) it.titlecase() else it.toString() }

val <T> List<T>.secondOrNull: T?
    get() = if (size >= 2) this[1] else null

infix fun Int.pow(exp: Int): Long {
    var acc = 1L
    repeat(exp) { acc *= this }
    return acc
}
