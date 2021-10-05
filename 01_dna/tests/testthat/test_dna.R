PRG = "../../dna.R"

run_cmd <- function(cmd) {
  system(cmd, intern = TRUE, ignore.stderr = TRUE)
}

test_that("Program exists", {
  expect_true(file.exists(PRG))
})

test_that("Program is lint free", {
  expect_silent(lintr::lint(PRG))
})

test_that("Program prints usage", {
  for (flag in c("-h", "--help")) {
    expect_match(run_cmd(stringr::str_glue("Rscript {PRG} {flag}"))[1],
                 "usage")
  }
  
})