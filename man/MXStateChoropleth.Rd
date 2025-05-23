% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/state.R
\name{MXStateChoropleth}
\alias{MXStateChoropleth}
\title{An R6 object for creating state-level choropleths.}
\description{
An R6 object for creating state-level choropleths.

An R6 object for creating state-level choropleths.
}
\examples{
library(viridis)
library(scales)

df_mxstate$value <-  df_mxstate$indigenous / df_mxstate$pop
gg = MXStateChoropleth$new(df_mxstate)
gg$title <- "Percentage of the population that self-identifies as indigenous"
gg$set_num_colors(1)
gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
gg$render()
}
\section{Super class}{
\code{\link[mxmaps:Choropleth]{mxmaps::Choropleth}} -> \code{MXStateChoropleth}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-MXStateChoropleth-new}{\code{MXStateChoropleth$new()}}
\item \href{#method-MXStateChoropleth-clone}{\code{MXStateChoropleth$clone()}}
}
}
\if{html}{\out{
<details><summary>Inherited methods</summary>
<ul>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="bind"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-bind'><code>mxmaps::Choropleth$bind()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="clip"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-clip'><code>mxmaps::Choropleth$clip()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="discretize"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-discretize'><code>mxmaps::Choropleth$discretize()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="format_levels"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-format_levels'><code>mxmaps::Choropleth$format_levels()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_bounding_box"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_bounding_box'><code>mxmaps::Choropleth$get_bounding_box()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_choropleth_as_polygon"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_choropleth_as_polygon'><code>mxmaps::Choropleth$get_choropleth_as_polygon()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_max_lat"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_max_lat'><code>mxmaps::Choropleth$get_max_lat()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_max_long"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_max_long'><code>mxmaps::Choropleth$get_max_long()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_min_lat"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_min_lat'><code>mxmaps::Choropleth$get_min_lat()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_min_long"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_min_long'><code>mxmaps::Choropleth$get_min_long()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_reference_map"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_reference_map'><code>mxmaps::Choropleth$get_reference_map()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_scale"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_scale'><code>mxmaps::Choropleth$get_scale()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_x_scale"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_x_scale'><code>mxmaps::Choropleth$get_x_scale()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_y_scale"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_y_scale'><code>mxmaps::Choropleth$get_y_scale()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="get_zoom"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-get_zoom'><code>mxmaps::Choropleth$get_zoom()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="prepare_map"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-prepare_map'><code>mxmaps::Choropleth$prepare_map()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="render"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-render'><code>mxmaps::Choropleth$render()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="render_with_reference_map"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-render_with_reference_map'><code>mxmaps::Choropleth$render_with_reference_map()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="set_num_colors"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-set_num_colors'><code>mxmaps::Choropleth$set_num_colors()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="set_zoom"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-set_zoom'><code>mxmaps::Choropleth$set_zoom()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="theme_clean"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-theme_clean'><code>mxmaps::Choropleth$theme_clean()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="theme_inset"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-theme_inset'><code>mxmaps::Choropleth$theme_inset()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-MXStateChoropleth-new"></a>}}
\if{latex}{\out{\hypertarget{method-MXStateChoropleth-new}{}}}
\subsection{Method \code{new()}}{
Initialize the map of Mexico
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{MXStateChoropleth$new(user.df)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{user.df}}{df}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A new `MXStateChoropleth` object.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-MXStateChoropleth-clone"></a>}}
\if{latex}{\out{\hypertarget{method-MXStateChoropleth-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{MXStateChoropleth$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
