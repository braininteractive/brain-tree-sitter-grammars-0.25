fun risky(input: String): Int = try {
    input.trim().toInt()
} catch (e: NumberFormatException) {
    -1
} finally {
    println("done")
}

val template = """
    multi-line ${1 + 2}
    raw "quotes" fine
""".trimIndent()

val escaped = "tab\tnewline\nunicodeé"
