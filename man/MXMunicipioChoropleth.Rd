% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/municipio.R
\name{MXMunicipioChoropleth}
\alias{MXMunicipioChoropleth}
\title{An R6 object for creating municipio-level choropleths.}
\description{
An R6 object for creating municipio-level choropleths.

An R6 object for creating municipio-level choropleths.
}
\examples{
library(viridis)
library(scales)

df_mxmunicipio_2020$value <-  df_mxmunicipio_2020$indigenous_language / df_mxmunicipio_2020$pop
gg = MXMunicipioChoropleth$new(df_mxmunicipio_2020)
gg$title <- "Percentage of the population that self-identifies as indigenous"
gg$set_num_colors(1)
gg$ggplot_scale <- scale_fill_viridis("percent", labels = percent)
gg$render()
}
\section{Super class}{
\code{\link[mxmaps:Choropleth]{mxmaps::Choropleth}} -> \code{MXMunicipioChoropleth}
}
\section{Public fields}{
\if{html}{\out{<div class="r6-fields">}}
\describe{
\item{\code{show_states}}{boolean, draw state borders}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-MXMunicipioChoropleth-render}{\code{MXMunicipioChoropleth$render()}}
\item \href{#method-MXMunicipioChoropleth-new}{\code{MXMunicipioChoropleth$new()}}
\item \href{#method-MXMunicipioChoropleth-clone}{\code{MXMunicipioChoropleth$clone()}}
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
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="render_with_reference_map"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-render_with_reference_map'><code>mxmaps::Choropleth$render_with_reference_map()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="set_num_colors"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-set_num_colors'><code>mxmaps::Choropleth$set_num_colors()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="set_zoom"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-set_zoom'><code>mxmaps::Choropleth$set_zoom()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="theme_clean"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-theme_clean'><code>mxmaps::Choropleth$theme_clean()</code></a></span></li>
<li><span class="pkg-link" data-pkg="mxmaps" data-topic="Choropleth" data-id="theme_inset"><a href='../../mxmaps/html/Choropleth.html#method-Choropleth-theme_inset'><code>mxmaps::Choropleth$theme_inset()</code></a></span></li>
</ul>
</details>
}}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-MXMunicipioChoropleth-render"></a>}}
\if{latex}{\out{\hypertarget{method-MXMunicipioChoropleth-render}{}}}
\subsection{Method \code{render()}}{
Render the map of Mexico
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{MXMunicipioChoropleth$render()}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{user.df}}{df}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A new ggplot2 object with a map of Mexico.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-MXMunicipioChoropleth-new"></a>}}
\if{latex}{\out{\hypertarget{method-MXMunicipioChoropleth-new}{}}}
\subsection{Method \code{new()}}{
Initialize the map of Mexico
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{MXMunicipioChoropleth$new(user.df)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{user.df}}{df}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
A new `MXMunicipioChoropleth` object.
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-MXMunicipioChoropleth-clone"></a>}}
\if{latex}{\out{\hypertarget{method-MXMunicipioChoropleth-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{MXMunicipioChoropleth$clone(deep = FALSE)}\if{html}{\out{</div>}}
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
