object Config {
    const val VERSION = "1.0"
    var debug: Boolean = false
}

class Service private constructor() {
    companion object {
        @JvmStatic
        fun create(): Service = Service()
    }
}

val runnable = object : Runnable {
    override fun run() = println("running")
}
