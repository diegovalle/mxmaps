% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/choropleth.R
\name{Choropleth}
\alias{Choropleth}
\title{The base Choropleth object.}
\description{
The base Choropleth object.

The base Choropleth object.
}
\keyword{internal}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-Choropleth-new}{\code{Choropleth$new()}}
\item \href{#method-Choropleth-render}{\code{Choropleth$render()}}
\item \href{#method-Choropleth-get_min_long}{\code{Choropleth$get_min_long()}}
\item \href{#method-Choropleth-get_max_long}{\code{Choropleth$get_max_long()}}
\item \href{#method-Choropleth-get_min_lat}{\code{Choropleth$get_min_lat()}}
\item \href{#method-Choropleth-get_max_lat}{\code{Choropleth$get_max_lat()}}
\item \href{#method-Choropleth-get_bounding_box}{\code{Choropleth$get_bounding_box()}}
\item \href{#method-Choropleth-get_x_scale}{\code{Choropleth$get_x_scale()}}
\item \href{#method-Choropleth-get_y_scale}{\code{Choropleth$get_y_scale()}}
\item \href{#method-Choropleth-get_reference_map}{\code{Choropleth$get_reference_map()}}
\item \href{#method-Choropleth-get_choropleth_as_polygon}{\code{Choropleth$get_choropleth_as_polygon()}}
\item \href{#method-Choropleth-render_with_reference_map}{\code{Choropleth$render_with_reference_map()}}
\item \href{#method-Choropleth-clip}{\code{Choropleth$clip()}}
\item \href{#method-Choropleth-discretize}{\code{Choropleth$discretize()}}
\item \href{#method-Choropleth-bind}{\code{Choropleth$bind()}}
\item \href{#method-Choropleth-prepare_map}{\code{Choropleth$prepare_map()}}
\item \href{#method-Choropleth-get_scale}{\code{Choropleth$get_scale()}}
\item \href{#method-Choropleth-theme_clean}{\code{Choropleth$theme_clean()}}
\item \href{#method-Choropleth-theme_inset}{\code{Choropleth$theme_inset()}}
\item \href{#method-Choropleth-format_levels}{\code{Choropleth$format_levels()}}
\item \href{#method-Choropleth-set_zoom}{\code{Choropleth$set_zoom()}}
\item \href{#method-Choropleth-get_zoom}{\code{Choropleth$get_zoom()}}
\item \href{#method-Choropleth-set_num_colors}{\code{Choropleth$set_num_colors()}}
\item \href{#method-Choropleth-clone}{\code{Choropleth$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-new"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$new(map.df, user.df)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-render"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-render}{}}}
\subsection{Method \code{render()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$render()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_min_long"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_min_long}{}}}
\subsection{Method \code{get_min_long()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_min_long()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_max_long"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_max_long}{}}}
\subsection{Method \code{get_max_long()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_max_long()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_min_lat"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_min_lat}{}}}
\subsection{Method \code{get_min_lat()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_min_lat()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_max_lat"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_max_lat}{}}}
\subsection{Method \code{get_max_lat()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_max_lat()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_bounding_box"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_bounding_box}{}}}
\subsection{Method \code{get_bounding_box()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_bounding_box(long_margin_percent, lat_margin_percent)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_x_scale"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_x_scale}{}}}
\subsection{Method \code{get_x_scale()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_x_scale()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_y_scale"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_y_scale}{}}}
\subsection{Method \code{get_y_scale()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_y_scale()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_reference_map"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_reference_map}{}}}
\subsection{Method \code{get_reference_map()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_reference_map()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_choropleth_as_polygon"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_choropleth_as_polygon}{}}}
\subsection{Method \code{get_choropleth_as_polygon()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_choropleth_as_polygon(alpha)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-render_with_reference_map"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-render_with_reference_map}{}}}
\subsection{Method \code{render_with_reference_map()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$render_with_reference_map(alpha = 0.5)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-clip"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-clip}{}}}
\subsection{Method \code{clip()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$clip()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-discretize"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-discretize}{}}}
\subsection{Method \code{discretize()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$discretize()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-bind"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-bind}{}}}
\subsection{Method \code{bind()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$bind()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-prepare_map"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-prepare_map}{}}}
\subsection{Method \code{prepare_map()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$prepare_map()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_scale"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_scale}{}}}
\subsection{Method \code{get_scale()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_scale()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-theme_clean"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-theme_clean}{}}}
\subsection{Method \code{theme_clean()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$theme_clean()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-theme_inset"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-theme_inset}{}}}
\subsection{Method \code{theme_inset()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$theme_inset()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-format_levels"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-format_levels}{}}}
\subsection{Method \code{format_levels()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$format_levels(x, nsep = " to ")}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-set_zoom"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-set_zoom}{}}}
\subsection{Method \code{set_zoom()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$set_zoom(zoom)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-get_zoom"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-get_zoom}{}}}
\subsection{Method \code{get_zoom()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$get_zoom()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-set_num_colors"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-set_num_colors}{}}}
\subsection{Method \code{set_num_colors()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$set_num_colors(num_colors)}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-Choropleth-clone"></a>}}
\if{latex}{\out{\hypertarget{method-Choropleth-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{Choropleth$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
