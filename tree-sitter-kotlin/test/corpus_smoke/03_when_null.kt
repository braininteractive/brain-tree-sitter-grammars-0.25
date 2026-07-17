fun describe(x: Any?): String = when (x) {
    null -> "nothing"
    is Int -> "int ${x + 1}"
    in 1..10 -> "small"
    "hello" -> "greeting"
    else -> "unknown: $x"
}

fun len(s: String?): Int = s?.length ?: 0
