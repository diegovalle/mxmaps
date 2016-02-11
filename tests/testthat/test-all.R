library(testthat)
library(mxmaps)

#test_package("mxmaps")

test_that("state choropleth matches expectations",{
  data("df_mxstate")
  df_mxstate$value = df_mxstate$pop
  p <- mxstate_choropleth(df_mxstate, num_colors = 1)
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
})

test_that("municipio choropleth matches expectations",{
  data("df_mxmunicipio")
  df_mxmunicipio$value = df_mxmunicipio$pop
  p <- mxmunicipio_choropleth(df_mxmunicipio, num_colors = 1)
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(df_mxmunicipio$region))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
})

test_that("hexbin matches expectations",{
  data("df_mxstate")
  df_mxstate$value = df_mxstate$pop
  p <- mxhexbin_choropleth(df_mxstate)
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
  expect_identical(p$labels$y, "lat")
  expect_identical(p$labels$x, "long")
})


# test_that("INEGI choropleths match expectations",{
#   # Insert your INEGI token here:
#   token <- ""
#   data("df_mxmunicipio")
#   df_mxmunicipio$value = df_mxmunicipio$pop
#   mxc_regions <- subset(df_mxmunicipio, metro_area == "Valle de México")$region
#   p <- choropleth_inegi(token, mxc_regions, "1006000044", silent = TRUE)
#   expect_is(p$layers[[1]], "ggproto")
#   expect_identical(sort(unique(p$data$id)), sort(mxc_regions))
#   expect_identical(p$labels$y, "lat")
#   expect_identical(p$labels$x, "long")
#
#   data("df_mxstate")
#   state_regions <- df_mxstate$region
#   p <- choropleth_inegi(token, state_regions, "3101008001", silent = TRUE)
#   expect_is(p$layers[[1]], "ggproto")
#   expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
#   expect_identical(p$labels$y, "lat")
#   expect_identical(p$labels$x, "long")
#
#
#   p <- hexbin_inegi(token, state_regions, "3101008001")
#   expect_is(p$layers[[1]], "ggproto")
#   expect_identical(sort(unique(p$data$id)), sort(df_mxstate$region))
#   expect_identical(p$labels$y, "lat")
#   expect_identical(p$labels$x, "long")
#
# })
