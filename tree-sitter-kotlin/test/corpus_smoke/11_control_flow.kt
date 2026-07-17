fun classify(scores: IntArray): Pair<Int, Int> {
    var pass = 0
    var fail = 0
    for (s in scores) {
        if (s >= 60) pass++ else fail++
    }
    var i = 0
    while (i < scores.size) {
        i += 1
    }
    do {
        i -= 1
    } while (i > 0)
    outer@ for (a in 1..3) {
        for (b in 1..3) {
            if (a * b > 4) continue@outer
        }
    }
    return pass to fail
}
