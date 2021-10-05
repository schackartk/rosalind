PRG <- "../../dna.R"
TEST1 <- c("../inputs/input1.txt", "1 2 3 4")
TEST2 <- c("../inputs/input2.txt", "20 12 17 21")
TEST3 <- c("../inputs/input3.txt", "196 231 237 246")

run_cmd <- function(cmd) {
  system(cmd, intern = TRUE, ignore.stderr = TRUE)
}

# ---------------------------------------------------------------------------
test_that("Program exists", {
  expect_true(file.exists(PRG))
})

# ---------------------------------------------------------------------------
test_that("Program is lint free", {
  expect_silent(lintr::lint(PRG))
})

# ---------------------------------------------------------------------------
test_that("Program prints usage", {
  for (flag in c("-h", "--help")) {
    expect_match(run_cmd(stringr::str_glue("Rscript {PRG} {flag}"))[1],
                 "usage")
  }
  
})

# ---------------------------------------------------------------------------
test_that("Runs with arg", {
  for (test_set in list(TEST1, TEST2, TEST3)) {
    dna <- readr::read_file(test_set[1])
    expect_equal(run_cmd(stringr::str_glue("Rscript {PRG} {dna}")),
                 test_set[2])
  }
})

# ---------------------------------------------------------------------------
test_that("Runs with file", {
  for (test_set in list(TEST1, TEST2, TEST3)) {
    in_file <- test_set[1]
    expect_equal(run_cmd(stringr::str_glue("Rscript {PRG} {in_file}")),
                 test_set[2])
  }
})
