setClass("Person", representation(name = "character", age = "numeric"))

setGeneric("describe", function(object) standardGeneric("describe"))

setMethod("describe", "Person", function(object) {
  paste(object@name, "is", object@age)
})

p <- new("Person", name = "Ada", age = 36)

Counter <- R6::R6Class("Counter",
  public = list(
    count = 0,
    increment = function(by = 1) {
      self$count <- self$count + by
      invisible(self)
    }
  )
)

counter <- Counter$new()
counter$increment(2)
