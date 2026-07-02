#' The base Choropleth2 object.
#' @importFrom R6 R6Class
#' @importFrom ggplot2 scale_color_continuous coord_quickmap coord_map scale_x_continuous scale_y_continuous geom_sf coord_sf annotate
#' @importFrom ggmap get_map ggmap
#' @importFrom RgoogleMaps MaxZoom
#' @importFrom stringr str_extract_all
#' @importFrom dplyr left_join
#' @keywords internal
#' @export
#'
# -------------------------------------------------------------------------
# Extensions for mxmaps
#
# Added support for:
#   - customizable polygon borders
#   - configurable backgrounds
#   - title styling
#   - scale bar rendering
#
# Added parameters:
#   border_color
#   border_size
#   background_color
#   title_color
#   title_align
#   title_position
#   scale_bar
#   scale_bar_position
#   scale_bar_length
#   scale_bar_segments
#   scale_bar_height
#   scale_bar_color
#   scale_bar_text_color
#
# -------------------------------------------------------------------------
Choropleth2 <- R6Class("Choropleth2",

  #' @field user.df input from user
  #' @field map.df geometry of the map
  #' @field choropleth.df result of binding user data with our map data
  #' @field title title for map
  #' @field legend title for legend
  #' @field warn warn user on clipped or missing values
  #' @field ggplot_scale override default scale.
  #' @field ggplot_polygon ggplot_polygon
  #' @field projection_sf projection_sf
  #' @field projection projection
  #' @field ggplot_sf ggplot_sf
  #'
  #'
  #' @field border_color Polygon border color.
  #' @field border_size Polygon border width.
  #' @field background_color Background color.
  #'
  #' @field title_color Title color.
  #' @field title_align Title horizontal alignment.
  #' @field title_position Title position.
  #'
  #' @field scale_bar Draw scale bar.
  #' @field scale_bar_position Scale bar position.
  #' @field scale_bar_length Scale bar length in km.
  #' @field scale_bar_segments Number of segments.
  #' @field scale_bar_height Scale bar height.
  #' @field scale_bar_color Scale bar color.
  #' @field scale_bar_text_color Scale bar text color.
  public = list(
    # the key objects for this class
    user.df = NULL, # input from user
    map.df = NULL, # geometry of the map
    choropleth.df = NULL, # result of binding user data with our map data

    title = "", # title for map
    legend = "", # title for legend
    warn = TRUE, # warn user on clipped or missing values
    ggplot_scale = NULL, # override default scale.
    # warning, you need to set "drop=FALSE" for insets to render correctly

    # as of ggplot v2.1.0, R6 class variables cannot be assigned to ggplot2 objects
    # in the class declaration. Doing so will break binary builds, so assign them
    # in the constructor instead
    projection = NULL,
    ggplot_polygon = NULL,

    # variables for working with simple features
    projection_sf = NULL,
    ggplot_sf = NULL,

    # mxmaps extensions
    border_color = "dark grey",
    border_size = 0.2,
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


    #' @description a choropleth map is defined by these two variables
    #' @param map.df a data.frame of a map
    #' @param user.df a data.frame that expresses values for regions of each map
    initialize = function(map.df, user.df) {
      stopifnot(is.data.frame(map.df))
      stopifnot("region" %in% colnames(map.df))
      self$map.df <- map.df

      # all input, regardless of map, is just a bunch of (region, value) pairs
      stopifnot(is.data.frame(user.df))
      stopifnot(c("region", "value") %in% colnames(user.df))
      self$user.df <- user.df
      self$user.df <- self$user.df[, c("region", "value")]

      stopifnot(anyDuplicated(self$user.df$region) == 0)

      # things like insets won't color properly if they are characters, and not factors
      if (is.character(self$user.df$value)) {
        self$user.df$value <- as.factor(self$user.df$value)
      }

      # initialize the map to the max zoom - i.e. all regions
      self$set_zoom(NULL)

      # if the user's data contains values which are not on the map,
      # then emit a warning if appropriate
      if (self$warn) {
        all_regions <- unique(self$map.df$region)
        user_regions <- unique(self$user.df$region)
        invalid_regions <- setdiff(user_regions, all_regions)
        if (length(invalid_regions) > 0) {
          invalid_regions <- paste(invalid_regions, collapse = ", ")
          warning(paste0("Your data.frame contains the following regions which are not mappable: ", invalid_regions))
        }
      }

      # as of ggplot v2.1.0, R6 class variables cannot be assigned to ggplot2 objects
      # in the class declaration. Doing so will break binary builds, so assign them
      # in the constructor instead
      self$projection <- coord_quickmap()
      self$ggplot_polygon <- geom_polygon(aes(fill = value), color = "dark grey", linewidth = 0.2)

      # experimental features for porting to simple features
      self$projection_sf <- coord_sf()
      self$ggplot_sf <- geom_sf(aes(fill = value), color = "dark grey", linewidth = 0.2)
    },
    #' @description render
    render = function() {
      self$prepare_map()

      if ("sf" %in% class(self$choropleth.df)) {
        gg <- ggplot(self$choropleth.df) +
          geom_sf(
            aes(fill = value),
            color = self$border_color,
            linewidth = self$border_size
          ) +
          self$get_scale() +
          self$theme_clean() +
          ggtitle(self$title) +
          self$projection_sf
      } else {
        gg <- ggplot(self$choropleth.df, aes(long, lat, group = group)) +
          geom_polygon(
            aes(fill = value),
            color = self$border_color,
            linewidth = self$border_size
          ) +
          self$get_scale() +
          self$theme_clean() +
          ggtitle(self$title) +
          self$projection
      }

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

      gg
    },

    # left
    #' @description left
    get_min_long = function() {
      min(self$choropleth.df$long)
    },

    # right
    #' @description right
    get_max_long = function() {
      max(self$choropleth.df$long)
    },

    # bottom
    #' @description bottom
    get_min_lat = function() {
      min(self$choropleth.df$lat)
    },

    # top
    #' @description top
    get_max_lat = function() {
      max(self$choropleth.df$lat)
    },
    #' @description get_bounding_box
    #' @param long_margin_percent null
    #' @param lat_margin_percent null
    get_bounding_box = function(long_margin_percent, lat_margin_percent) {
      c(
        self$get_min_long(), # left
        self$get_min_lat(), # bottom
        self$get_max_long(), # right
        self$get_max_lat()
      ) # top
    },
    #' @description get_x_scale
    get_x_scale = function() {
      scale_x_continuous(limits = c(self$get_min_long(), self$get_max_long()))
    },
    #' @description get_y_scale
    get_y_scale = function() {
      scale_y_continuous(limits = c(self$get_min_lat(), self$get_max_lat()))
    },
    #' @description get_reference_map
    get_reference_map = function() {
      # note: center is (long, lat) but MaxZoom is (lat, long)

      center <- c(
        mean(self$choropleth.df$long),
        mean(self$choropleth.df$lat)
      )

      max_zoom <- MaxZoom(
        range(self$choropleth.df$lat),
        range(self$choropleth.df$long)
      )

      get_map(
        location = center,
        zoom = max_zoom,
        color = "bw"
      )
    },
    #' @description get_choropleth_as_polygon
    #' @param alpha null
    get_choropleth_as_polygon = function(alpha) {
      # mxmaps extension: customizable polygon borders
      geom_polygon(
        data = self$choropleth.df,
        aes(x = long, y = lat, fill = value, group = group), alpha = alpha,
        color = self$border_color,
        linewidth = self$border_size
      )
    },
    #' @description render_with_reference_map
    #' @param alpha null
    render_with_reference_map = function(alpha = 0.5) {
      self$prepare_map()

      reference_map <- self$get_reference_map()

      ggmap(reference_map) +
        self$get_choropleth_as_polygon(alpha) +
        self$get_scale() +
        self$get_x_scale() +
        self$get_y_scale() +
        self$theme_clean() +
        ggtitle(self$title) +
        coord_map()
    },

    # support e.g. users just viewing states on the west coast
    #' @description support e.g. users just viewing states on the west coast
    clip = function() {
      stopifnot(!is.null(private$zoom))

      self$user.df <- self$user.df[self$user.df$region %in% private$zoom, ]
      self$map.df <- self$map.df[self$map.df$region %in% private$zoom, ]
    },

    # for us, discretizing values means
    # 1. assigning each value to one of num_colors colors
    # 2. formatting the intervals e.g. with commas
    #' @importFrom Hmisc cut2
    #' @description discretizing values means
    discretize = function() {
      if (is.numeric(self$user.df$value) && private$num_colors > 1) {
        # if cut2 uses scientific notation,  our attempt to put in commas will fail
        scipen_orig <- getOption("scipen")
        options(scipen = 999)
        self$user.df$value <- cut2(self$user.df$value, g = private$num_colors)
        options(scipen = scipen_orig)

        levels(self$user.df$value) <- sapply(levels(self$user.df$value), self$format_levels)
      }
    },
    #' @description bind
    bind = function() {
      self$choropleth.df <- left_join(self$map.df, self$user.df, by = "region")
      missing_regions <- unique(self$choropleth.df[is.na(self$choropleth.df$value), ]$region)
      if (self$warn && length(missing_regions) > 0) {
        missing_regions <- paste(missing_regions, collapse = ", ")
        warning_string <- paste("The following regions were missing and are being set to NA:", missing_regions)
        warning(warning_string)
      }

      # does this work?
      if ("SpatialPolygonsDataFrame" %in% class(self$choropleth.df)) {
        self$choropleth.df <- self$choropleth.df[order(self$choropleth.df$order), ]
      }
    },

    #' @description prepare_map
    prepare_map = function() {
      self$clip() # clip the input - e.g. remove value for Washington DC on a 50 state map
      self$discretize() # discretize the input. normally people don't want a continuous scale
      self$bind() # bind the input values to the map values
    },

    #' @importFrom ggplot2 scale_fill_gradient2
    #' @description  get_scale
    get_scale = function() {
      if (!is.null(self$ggplot_scale)) {
        self$ggplot_scale
      } else if (private$num_colors == 0) {
        min_value <- min(self$choropleth.df$value, na.rm = TRUE)
        max_value <- max(self$choropleth.df$value, na.rm = TRUE)
        stopifnot(!is.na(min_value) && !is.na(max_value))

        scale_fill_gradient2(self$legend, na.value = "black", limits = c(min_value, max_value))
      } else if (private$num_colors == 1) {
        min_value <- min(self$choropleth.df$value, na.rm = TRUE)
        max_value <- max(self$choropleth.df$value, na.rm = TRUE)
        stopifnot(!is.na(min_value) && !is.na(max_value))

        # by default, scale_fill_continuous uses a light value for high values and a dark value for low values
        # however, this is the opposite of how choropleths are normally colored (see wikipedia)
        # these low and high values are from the 7 color brewer blue scale (see colorbrewer.org)
        scale_fill_continuous(self$legend, low = "#eff3ff", high = "#084594", na.value = "black", limits = c(min_value, max_value))
      } else {
        scale_fill_brewer(self$legend, drop = FALSE, na.value = "black")
      }
    },

    # theme_clean and theme_inset are used to draw the map over a clean background.
    # The difference is that theme_inset also removes the legend of the map.
    # These functions used to be based on the code from section 13.19 of
    # "Making a Map with a Clean Background" of "R Graphics Cookbook" by Winston Chang.
    #
    # However, it appears that as of version 2.2.1.9000 of ggplot2 that code simply does not work
    # anymore. (In particular, calling ggplotGrob on maps created with those themes (which choroplethr
    # does for maps that appear as insets, such as Alaska) was causing a crash).
    # So these functions now use theme_void
    #' @importFrom ggplot2 theme_void
    #' @description theme_clean
    # mxmaps extension:
    # configurable background and title appearance
    theme_clean = function() {
      ggplot2::theme_void() +
        ggplot2::theme(
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
    },

    # This is a copy of the actual code in theme_void, but it also remove the legend
    #' @importFrom ggplot2 theme_void theme "%+replace%"
    #' @description theme_inset
    theme_inset = function() {
      ggplot2::theme_void() %+replace%
        ggplot2::theme(legend.position = "none")
    },

    # Make the output of cut2 a bit easier to read
    #
    # Adds commas to numbers, removes unnecessary whitespace and allows an arbitrary separator.
    #
    # @param x A factor with levels created via Hmisc::cut2.
    # @param nsep A separator which you wish to use.  Defaults to " to ".
    #
    # @export
    # @examples
    # data(df_pop_state)
    #
    # x = Hmisc::cut2(df_pop_state$value, g=3)
    # levels(x)
    # # [1] "[ 562803, 2851183)" "[2851183, 6353226)" "[6353226,37325068]"
    # levels(x) = sapply(levels(x), format_levels)
    # levels(x)
    # # [1] "[562,803 to 2,851,183)"    "[2,851,183 to 6,353,226)"  "[6,353,226 to 37,325,068]"
    #
    # @seealso \url{http://stackoverflow.com/questions/22416612/how-can-i-get-cut2-to-use-commas/}, which this implementation is based on.
    #' @description format_levels
    #' @param x null
    #' @param nsep null
    format_levels = function(x, nsep = " to ") {
      n <- str_extract_all(x, "[-+]?[0-9]*\\.?[0-9]+")[[1]] # extract numbers
      v <- format(as.numeric(n), big.mark = ",", trim = TRUE) # change format
      x <- as.character(x)

      # preserve starting [ or ( if appropriate
      prefix <- ""
      if (substring(x, 1, 1) %in% c("[", "(")) {
        prefix <- substring(x, 1, 1)
      }

      # preserve ending ] or ) if appropriate
      suffix <- ""
      if (substring(x, nchar(x), nchar(x)) %in% c("]", ")")) {
        suffix <- substring(x, nchar(x), nchar(x))
      }

      # recombine
      paste0(prefix, paste(v, collapse = nsep), suffix)
    },

    #' @description set_zoom
    #' @param zoom null
    set_zoom = function(zoom) {
      if (is.null(zoom)) {
        # initialize the map to the max zoom - i.e. all regions
        private$zoom <- unique(self$map.df$region)
      } else {
        stopifnot(all(zoom %in% unique(self$map.df$region)))
        private$zoom <- zoom
      }
    },

    #' @description get_zoom
    get_zoom = function() {
      private$zoom
    },

    #' @description set_num_colors
    #' @param num_colors null
    set_num_colors = function(num_colors) {
      # if R's ?is.integer actually tested if a value was an integer, we could replace the
      # first 2 tests with is.integer(num_colors)
      stopifnot(is.numeric(num_colors) &&
        num_colors %% 1 == 0 &&
        num_colors >= 0 &&
        num_colors < 10)

      private$num_colors <- num_colors
    }
  ),
  private = list(
    zoom = NULL, # a vector of regions to zoom in on. if NULL, show all
    num_colors = 7, # number of colors to use on the map. if 1 then use a continuous scale
    has_invalid_regions = FALSE
  )
)
# Original implementation based on:
# https://github.com/cran/choroplethr/blob/master/R/choropleth.R
#
# Extended for mxmaps with:
#   - customizable borders
#   - configurable themes
#   - scale bar support
