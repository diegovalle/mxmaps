context("Metro Areas")


# Source: Zonas metropolitanas por tamano poblacional
# http://www.conapo.gob.mx/en/CONAPO/Zonas_metropolitanas_2010
test_that("The number of metro areas is correct", {
  expect_equal(length(na.omit(unique(df_mxmunicipio$metro_area))), 59)
})

# No NAs in lat and long
test_that("No NA values in latitude and longitude columns", {
  expect_true(all(!is.na(df_mxmunicipio_2020$lat)))
  expect_true(all(!is.na(df_mxmunicipio_2020$long)))
})

context("Test that metro area codes were transcribed correctly")

# Source: Clasificación y número de municipios de las zonas metropolitanas, 2010
# http://www.conapo.gob.mx/en/CONAPO/Zonas_metropolitanas_2010
test_that("The number of municipios in metro areas is correct", {
  # Total municipios in all metro areas
  expect_equal(length(unique(df_mxmunicipio_2020$region[!is.na(df_mxmunicipio_2020$metro_area)])), 367)
  # Total municipios by metro area
  df <- aggregate(df_mxmunicipio_2020, by=list(metro = df_mxmunicipio_2020$metro_area), function(x) length(x))
  expect_equal(df[df$metro == "Monterrey",]$metro_area,
               13)
  expect_equal(df[df$metro == "Puerto Vallarta",]$metro_area,
               2)
  expect_equal(df[df$metro == "Cuernavaca",]$metro_area,
               8)
  expect_equal(df[df$metro == "Villahermosa",]$metro_area,
               2)
  expect_equal(df[df$metro == "Orizaba",]$metro_area,
               12)
  expect_equal(df[df$metro == "Tianguistenco",]$metro_area,
               6)
  expect_equal(df[df$metro == "Tula",]$metro_area,
               5)
})
