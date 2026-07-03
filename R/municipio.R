#' An R6 object for creating municipio-level choropleths.
#'
#' @export
#' @importFrom R6 R6Class
#' @param show_states draw state borders
#' @return An R6 Class
#' @importFrom stringr str_sub
#' @importFrom ggplot2 ggplot aes geom_polygon scale_fill_brewer ggtitle theme
#' @importFrom ggplot2 theme_grey element_blank geom_text coord_map
#' @importFrom ggplot2 scale_fill_continuous scale_colour_brewer ggplotGrob
#' @importFrom ggplot2 annotation_custom
#'
#' @examples
#' library(viridis)
#' library(scales)
#'
#' df_mxmunicipio_2020$value <- df_mxmunicipio_2020$indigenous_language /
#'                              df_mxmunicipio_2020$pop
#' gg <- MXMunicipioChoropleth$new(df_mxmunicipio_2020)
#' gg$title <- "Percentage of the population that self-identifies as indigenous"
#' gg$set_num_colors(1)
#' gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
#' gg$render()
MXMunicipioChoropleth <- R6Class("MXMunicipioChoropleth", # nolint
  inherit = Choropleth2,
  public = list(
    #' @field show_states boolean, draw state borders
    show_states = TRUE,
    #' @description
    #' Render the map of Mexico
    #' @param user.df df
    #' @return A new ggplot2 object with a map of Mexico.
    render = function() {
      self$prepare_map()

      gg <- ggplot(self$choropleth.df, aes(long, lat, group = group)) +
        geom_polygon(aes(fill = value),
          color = self$municipio_border_color,
          linewidth = self$municipio_border_size
        ) +
        self$get_scale() +
        self$theme_clean() +
        ggtitle(self$title)
      state_zoom <- unique(str_sub(private$zoom, start = 1, end = 2))
      if (self$show_states) {
        data(mxstate.map, package = "mxmaps", envir = environment())
        gg <- gg + geom_polygon(
          data = subset(mxstate.map, region %in% state_zoom),
          fill = "transparent",
          color = self$state_border_color,
          linewidth = self$state_border_size
        )
      }
      xmin <- min(self$choropleth.df$long)
      xmax <- max(self$choropleth.df$long)
      ymin <- min(self$choropleth.df$lat)
      ymax <- max(self$choropleth.df$lat)
      xpad <- (xmax - xmin) * 0.05
      ypad <- (ymax - ymin) * 0.05

      # mxmaps extension: optional scale bar

      if (self$scale_bar) {
        xmin <- min(self$choropleth.df$long)
        xmax <- max(self$choropleth.df$long)

        ymin <- min(self$choropleth.df$lat)
        ymax <- max(self$choropleth.df$lat)


        km <- self$scale_bar_length

        mean_lat <- mean(self$choropleth.df$lat)

        km_per_degree <- 111 * cos(mean_lat * pi / 180)

        deg <- km / km_per_degree


        segment_deg <- deg / self$scale_bar_segments
        segment_km <- km / self$scale_bar_segments

        # determine scale bar position
        if (self$scale_bar_position == "bl") {
          x0 <- xmin + 0.05 * (xmax - xmin)
          y0 <- ymin + 0.05 * (ymax - ymin)
        }

        if (self$scale_bar_position == "br") {
          x0 <- xmax - 0.10 * (xmax - xmin) - deg
          y0 <- ymin + 0.05 * (ymax - ymin)
        }

        if (self$scale_bar_position == "tl") {
          x0 <- xmin + 0.05 * (xmax - xmin)
          y0 <- ymax - 0.05 * (ymax - ymin)
        }

        if (self$scale_bar_position == "tr") {
          x0 <- xmax - 0.10 * (xmax - xmin) - deg
          y0 <- ymax - 0.05 * (ymax - ymin)
        }


        # draw scale bar segments
        for (i in seq_len(self$scale_bar_segments)) {
          xleft <- x0 + (i - 1) * segment_deg
          xright <- x0 + i * segment_deg

          fillcol <- ifelse(
            i %% 2 == 0,
            "white",
            self$scale_bar_color
          )

          gg <- gg +
            annotate("rect",
              xmin = xleft, xmax = xright,
              ymin = y0, ymax = y0 + self$scale_bar_height,
              fill = fillcol,
              colour = self$scale_bar_color,
              linewidth = 0.3
            )
        }


        # draw distance labels
        for (i in 0:self$scale_bar_segments) {
          xlab <- x0 + i * segment_deg
          lab <- round(i * segment_km)

          gg <- gg +
            annotate(
              "text",
              x = xlab,
              y = y0 - self$scale_bar_height,
              label = lab,
              size = 3,
              colour = self$scale_bar_text_color
            )
        }

        gg <- gg +
          annotate("text",
            x = x0 + (self$scale_bar_segments + 0.5) * segment_deg,
            y = y0 + 0.5 * self$scale_bar_height,
            label = "km", hjust = 0,
            colour = self$scale_bar_text_color
          )
      }

      gg + theme(
        panel.background =
          ggplot2::element_rect(
            fill = self$background_color,
            colour = self$background_color
          ),
        plot.background =
          ggplot2::element_rect(
            fill = self$background_color,
            colour = self$background_color
          ),
        legend.background =
          ggplot2::element_rect(
            fill = self$background_color,
            colour = self$background_color
          ),
        legend.key =
          ggplot2::element_rect(
            fill = self$background_color,
            colour = self$background_color
          ),
        plot.title =
          ggplot2::element_text(
            colour = self$title_color,
            hjust = self$title_align
          ),
        plot.title.position =
          self$title_position
      )

      return(gg + coord_map(
        xlim = c(
          xmin - xpad,
          xmax + xpad
        ),
        ylim = c(
          ymin - ypad,
          ymax + ypad
        )
      ))
    },

    #' @description
    #' Initialize the map of Mexico
    #' @param user.df df
    #' @return A new `MXMunicipioChoropleth` object.
    initialize = function(user.df) {
      # if (!requireNamespace("mxmapsData", quietly = TRUE)) {
      #  stop("Package mxmapsData is needed for this function to work. Please install it.", call. = FALSE)
      # }

      data(mxmunicipio.map, package = "mxmaps", envir = environment())
      super$initialize(mxmunicipio.map, user.df)

      if (private$has_invalid_regions) {
        warning("Please see df_mxmunicipio for a list of mappable regions")
      }
    }
  )
)

#' Create a municipio-level choropleth
#'
#' The map used is mxmunicipio.map. See ?mxmunicipio.map for
#' more information.
#'
#' @param df A data.frame with a column named "region" and a column named "value".
#' Elements in
#' the "region" column must match the numeric codes in the "region" column of ?df_mxmunicipio
#' either with a leading zero or without one (e.g. 01001 or 1001 are both fine)
#' @param title An optional title for the map.
#' @param legend An optional name for the legend.
#' @param num_colors The number of colors to use on the map.  A value of 1
#' will use a continuous scale, and a value in [2, 9] will use that many colors.
#' @param zoom An optional vector of countries to zoom in on. Elements of this
#' vector must exactly
#' match the names of countries as they appear in the "region" column
#' of ?country.regions
#' @param show_states Wether to draw state borders.
#' @param background_color Background color of the map and legend.
#' @param title_color Title text color.
#' @param title_align Horizontal justification of title.
#' @param title_position Either "plot" or "panel".
#' @param scale_bar Logical; draw a scale bar.
#' @param scale_bar_position Position of scale bar:
#'   "bl", "br", "tl", or "tr".
#' @param scale_bar_length Scale bar length in kilometers.
#' @param scale_bar_segments Number of scale bar segments.
#' @param scale_bar_height Height of scale bar.
#' @param scale_bar_color Scale bar outline and fill color.
#' @param scale_bar_text_color Scale bar text color.
#' @param state_border_color State border color of polygons.
#' @param state_border_size State border line width.
#' @param municipio_border_color Municipio border color of polygons.
#' @param municipio_border_size Municipio border line width.
#' @return A ggplot object representing a municipio map of Mexico
#' @examples
#' df <- df_mxmunicipio_2020
#' df$value <- df$indigenous_language
#' mxmunicipio_choropleth(df)

#' @export
mxmunicipio_choropleth <- function(
  df,
  title = "",
  legend = "",
  num_colors = 7,
  zoom = NULL,
  show_states = TRUE,
  # mxmaps extensions
  background_color = "white",
  title_color = "black",
  title_align = 0.5,
  title_position = "plot",
  scale_bar = FALSE,
  scale_bar_position = "bl",
  scale_bar_length = 500,
  scale_bar_segments = 5,
  scale_bar_height = 0.5,
  scale_bar_color = "black",
  scale_bar_text_color = "black",
  state_border_color = "#333333",
  state_border_size = 0.15,
  municipio_border_color = "dark gray",
  municipio_border_size = 0.08
) {
  if ("region" %in% colnames(df)) {
    df$region <- str_mxmunicipio(df$region)
  }
  if (!is.null(zoom)) {
    zoom <- str_mxmunicipio(zoom)
  }
  c <- MXMunicipioChoropleth$new(df)
  c$title <- title
  c$legend <- legend
  c$state_border_color <- state_border_color
  c$state_border_size <- state_border_size
  c$municipio_border_color <- municipio_border_color
  c$municipio_border_size <- municipio_border_size
  c$background_color <- background_color
  c$title_color <- title_color
  c$title_align <- title_align
  c$title_position <- title_position
  c$scale_bar <- scale_bar
  c$scale_bar_position <- scale_bar_position
  c$scale_bar_length <- scale_bar_length
  c$scale_bar_segments <- scale_bar_segments
  c$scale_bar_height <- scale_bar_height
  c$scale_bar_color <- scale_bar_color
  c$scale_bar_text_color <- scale_bar_text_color
  c$set_num_colors(num_colors)
  c$set_zoom(zoom)
  c$show_states <- show_states
  c$render()
}
