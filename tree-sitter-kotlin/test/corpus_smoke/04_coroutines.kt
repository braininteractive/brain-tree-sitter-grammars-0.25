import kotlinx.coroutines.*

suspend fun fetch(url: String): String = withContext(Dispatchers.IO) {
    delay(100)
    "body of $url"
}

fun main() = runBlocking {
    val jobs = List(3) { async { fetch("https://example.com/$it") } }
    jobs.awaitAll().forEach(::println)
}
