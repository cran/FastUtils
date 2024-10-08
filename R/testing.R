#' Initialize Testthat Files
#'
#' This function scans all files in the specified R directory based on its name,
#' excluding some based on the patterns provided in the `ignore` argument,
#' and creates `testthat` files if they are missing. Useful for when many source
#' code files were created from rapid development and unit testing has yet to be
#' setup.
#'
#' @param rDir The directory containing R source files. Default is "R".
#' @param testDir The directory where `testthat` files should be created.
#' Default is "tests/testthat".
#' @param .ignore A character vector specifying regex patterns of files to
#' ignore. Defaults
#' to common patterns `c("-package.R$", "-class.R$", "^data.R$", "^zzz.R$",
#' "^RcppExports.R$")`
#' @param ignore A character vector of extra regex patterns of R files to ignore
#'
#' @return No return value, called for side effects.
#' @export
#' @keywords testing
#'
#' @examples
#' \donttest{
#' try({
#'
#' initTestthat()
#' initTestthat(rDir = "src", testDir = "tests")
#' initTestthat(ignore = c("^foo", "-bar.R$"))
#'
#' }, silent = TRUE)
#' }
#'
initTestthat <- function(
    rDir = "R",
    testDir = file.path("tests", "testthat"),
    .ignore = c(
        "-package.R$", "-class.R$", "^data.R$", "^zzz.R$", "^RcppExports.R$"
    ),
    ignore = NULL
) {

    assertthat::assert_that(is.character(rDir) && is.character(testDir))
    assertthat::assert_that(is.null(ignore) || is.character(ignore))

    if (!dir.exists(testDir)) usethis::use_testthat()
    ignoreRegex <- encloseBr(paste(append(.ignore, ignore), collapse = ")|("))

    for (sourceFile in list.files(rDir)) {

        if (grepl(ignoreRegex, sourceFile)) next
        fileTitle <- substrEnd(basename(sourceFile), 1, 2)
        testFilePath <- file.path(testDir, paste0("test-", fileTitle, ".R"))
        if (!file.exists(testFilePath)) {
            usethis::use_test(fileTitle, open = FALSE)
        }

    }
}

#' Run a Testthat test Quietly
#'
#' This function runs a `test_that` block quietly, suppressing messages and
#' output from any verbose functions.
#'
#' @param desc A description of the test.
#' @param code The code to be tested.
#'
#' @return No return value, called for side effects.
#' @export
#' @keywords testing
#' @examples
#' # Run a test quietly
#' test_quietly_that("quiet test example", {
#'     testthat::expect_equal(1 + 1, 2)
#' })
test_quietly_that <- function(desc, code) { # nolint: object_name_linter.
    testthat::test_that(desc, quietly(code))
}
