/**
 * @brief Validates a \a token against the current \b session.
 *
 * The \c validate call is cheap. Use it before every request.
 * @note This function is thread-safe.
 * @warning Never pass a null pointer.
 * @deprecated Use validate_v2 instead.
 */
