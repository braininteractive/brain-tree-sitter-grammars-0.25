interface Repository<T : Any, ID> {
    fun save(entity: T): T
    fun findById(id: ID): T?
}

inline fun <reified T> parse(json: String): T? = null

fun <K, V : Comparable<V>> maxValue(map: Map<K, V>): V? = map.values.maxOrNull()
