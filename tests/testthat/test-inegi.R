context("Test functions that use the INEGI API")

library(testthat)
library(mxmaps)

#test_package("mxmaps")

test_that("hexbin_inegi matches expectations",{
  data("df_mxstate")
  token <- Sys.getenv("INEGI_TOKEN")
  state_regions <- df_mxstate$region
  p <- hexbin_inegi(token, state_regions,
               indicator = "1002000026",
               legend = "número de nacimientos")
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
})

test_that("choropleth_inegi (municipios) matches expectations",{
  data("df_mxmunicipio")
  token <- Sys.getenv("INEGI_TOKEN")
  mxc_regions <- subset(df_mxmunicipio, metro_area == "Valle de México")$region
  p <- choropleth_inegi(token, mxc_regions,
                   indicator = "1002000026",
                   silent = FALSE,
                   legend = "nacimientos")
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(mxc_regions))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
  expect_true(grepl("Indicator.*", p$labels$title[1]))
})

test_that("choropleth_inegi (states) matches expectations",{
  data("df_mxstate")
  token <- Sys.getenv("INEGI_TOKEN")
  state_regions <- df_mxstate$region
  p <- choropleth_inegi(token, state_regions,
                   indicator = "1002000026",
                   legend = "número\nde\nmujeres",
                   title = "Test")
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
  expect_true(grepl("Test", p$labels$title[1]))
})
