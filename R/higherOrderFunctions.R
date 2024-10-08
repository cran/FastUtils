#' Create a Mutator Function
#'
#' Creates a mutator function based on a specified binary operator.
#' The output mutator function updates a variable in the parent frame by
#' applying the binary operator with a given value. It's recommended to use
#' this function to easily construct special functions in the form of `%f%`
#' where `f` can be any symbol of choice. See examples.
#'
#' @param binaryOperator A binary operator function to apply for the mutation.
#'
#' @return A function that takes a variable and a value, applying the binary
#' operator to update the variable in the parent frame.
#' @export
#' @keywords higherOrderFunctions
#'
#' @examples
#' "%+=%" <- createMutator(add)
#' x <- 1
#' x %+=% 1
#' x # becomes 2
#'
createMutator <- function(binaryOperator) {

    assertthat::assert_that(
        is.function(binaryOperator) && length(formals(binaryOperator)) >= 2
    )

    function(var, val) {
        eval(
            call("<-", substitute(var), binaryOperator(var, val)),
            envir = parent.frame()
        )
    }
}
