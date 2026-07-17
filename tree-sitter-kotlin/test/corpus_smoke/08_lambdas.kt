fun main() {
    val nums = listOf(1, 2, 3, 4, 5)
    val result = nums
        .filter { it % 2 == 0 }
        .map { it * it }
        .fold(0) { acc, n -> acc + n }
    println(result)

    val clicks: (Int, String) -> Unit = { id, label -> println("$id:$label") }
    clicks(1, "ok")
}
