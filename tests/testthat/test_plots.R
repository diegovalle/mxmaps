test_that("state plot appearance vdiff", {
  skip_on_ci()
  df_mxstate_2025$value <- df_mxstate_2025$pop
  p <- mxstate_choropleth(df_mxstate_2025,
    title = "Title",
    scale_bar = TRUE
  )

  vdiffr::expect_doppelganger(
    "basic state plot",
    p
  )
})

test_that("municipio plot appearance vdiff", {
  skip_on_ci()
  df_mxmunicipio_2025$value <- df_mxmunicipio_2025$indigenous /
    df_mxmunicipio_2025$pop * 100
  p <- mxmunicipio_choropleth(df_mxmunicipio_2025,
    num_colors = 1,
    title = "title",
    legend = "indigenous",
    municipio_border_size = 0,
    municipio_border_color = "transparent",
    background_color = "lightblue",
    scale_bar = TRUE
  )

  vdiffr::expect_doppelganger(
    "basic municipio plot",
    p
  )
})

test_that("hexbin plot appearance vdiff", {
  skip_on_ci()
  df_mxstate_2025$value <- df_mxstate_2025$afromexican /
    df_mxstate_2025$pop * 100
  p <- mxhexbin_choropleth(df_mxstate_2025,
    num_colors = 1,
    title = "",
    legend = "",
    auto_contrast = TRUE
  )

  vdiffr::expect_doppelganger(
    "basic hexbin plot",
    p
  )
})
