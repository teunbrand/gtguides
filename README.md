
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gtguides

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/gtguides)](https://CRAN.R-project.org/package=gtguides)
<!-- badges: end -->

The goal of gtguides is to provide additional guides for the ‘ggplot2’
package representing tables constructed with the ‘gt’ package.

## Installation

> [!WARNING]
> You'd need the development version of {gt} for this to work. You can install that by using `devtools::install_github("rstudio/gt")`.

You can install the development version of gtguides from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("teunbrand/gtguides")
```

## Example

The main idea is that we can format a nice table using the {gt} package:

``` r
library(gtguides)
#> Loading required package: ggplot2
library(gt)

# Selected observations from the msleep data
df <- msleep[c(9, 28, 11, 5, 34, 54, 53), ]

# Format a nice table of animal data
animals <- df |>
  subset(select = c(name, order, awake, bodywt, brainwt)) |>
  gt(groupname_col = "order") |>
  fmt_number(c(awake, bodywt, brainwt)) |>
  tab_spanner("weight", c(bodywt, brainwt)) |>
  cols_label(bodywt = "body", brainwt = "brain") |>
  tab_style(cell_text("red"), cells_body(brainwt, 7)) |>
  tab_header("Animals")

# Show table
as_raw_html(animals, FALSE)
```

<div id="gypimvrigm" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
  <style>#gypimvrigm table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
&#10;#gypimvrigm thead, #gypimvrigm tbody, #gypimvrigm tfoot, #gypimvrigm tr, #gypimvrigm td, #gypimvrigm th {
  border-style: none;
}
&#10;#gypimvrigm p {
  margin: 0;
  padding: 0;
}
&#10;#gypimvrigm .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}
&#10;#gypimvrigm .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}
&#10;#gypimvrigm .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}
&#10;#gypimvrigm .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}
&#10;#gypimvrigm .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}
&#10;#gypimvrigm .gt_column_spanner_outer:first-child {
  padding-left: 0;
}
&#10;#gypimvrigm .gt_column_spanner_outer:last-child {
  padding-right: 0;
}
&#10;#gypimvrigm .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}
&#10;#gypimvrigm .gt_spanner_row {
  border-bottom-style: hidden;
}
&#10;#gypimvrigm .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}
&#10;#gypimvrigm .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}
&#10;#gypimvrigm .gt_from_md > :first-child {
  margin-top: 0;
}
&#10;#gypimvrigm .gt_from_md > :last-child {
  margin-bottom: 0;
}
&#10;#gypimvrigm .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}
&#10;#gypimvrigm .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gypimvrigm .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}
&#10;#gypimvrigm .gt_row_group_first td {
  border-top-width: 2px;
}
&#10;#gypimvrigm .gt_row_group_first th {
  border-top-width: 2px;
}
&#10;#gypimvrigm .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gypimvrigm .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_first_summary_row.thick {
  border-top-width: 2px;
}
&#10;#gypimvrigm .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gypimvrigm .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}
&#10;#gypimvrigm .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gypimvrigm .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}
&#10;#gypimvrigm .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}
&#10;#gypimvrigm .gt_left {
  text-align: left;
}
&#10;#gypimvrigm .gt_center {
  text-align: center;
}
&#10;#gypimvrigm .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}
&#10;#gypimvrigm .gt_font_normal {
  font-weight: normal;
}
&#10;#gypimvrigm .gt_font_bold {
  font-weight: bold;
}
&#10;#gypimvrigm .gt_font_italic {
  font-style: italic;
}
&#10;#gypimvrigm .gt_super {
  font-size: 65%;
}
&#10;#gypimvrigm .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}
&#10;#gypimvrigm .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}
&#10;#gypimvrigm .gt_indent_1 {
  text-indent: 5px;
}
&#10;#gypimvrigm .gt_indent_2 {
  text-indent: 10px;
}
&#10;#gypimvrigm .gt_indent_3 {
  text-indent: 15px;
}
&#10;#gypimvrigm .gt_indent_4 {
  text-indent: 20px;
}
&#10;#gypimvrigm .gt_indent_5 {
  text-indent: 25px;
}
&#10;#gypimvrigm .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}
&#10;#gypimvrigm div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
  <table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="4" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Animals</td>
    </tr>
    &#10;    <tr class="gt_col_headings gt_spanner_row">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1" scope="col" id="name">name</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="2" colspan="1" scope="col" id="awake">awake</th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="2" scope="colgroup" id="weight">
        <span class="gt_column_spanner">weight</span>
      </th>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="body">body</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="brain">brain</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <th colspan="4" class="gt_group_heading" scope="colgroup" id="Carnivora">Carnivora</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Carnivora  name" class="gt_row gt_left">Dog</td>
<td headers="Carnivora  awake" class="gt_row gt_right">13.90</td>
<td headers="Carnivora  bodywt" class="gt_row gt_right">14.00</td>
<td headers="Carnivora  brainwt" class="gt_row gt_right">0.07</td></tr>
    <tr><td headers="Carnivora  name" class="gt_row gt_left">Domestic cat</td>
<td headers="Carnivora  awake" class="gt_row gt_right">11.50</td>
<td headers="Carnivora  bodywt" class="gt_row gt_right">3.30</td>
<td headers="Carnivora  brainwt" class="gt_row gt_right">0.03</td></tr>
    <tr><td headers="Carnivora  name" class="gt_row gt_left">Lion</td>
<td headers="Carnivora  awake" class="gt_row gt_right">10.50</td>
<td headers="Carnivora  bodywt" class="gt_row gt_right">161.50</td>
<td headers="Carnivora  brainwt" class="gt_row gt_right" style="color: #FF0000;">NA</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="4" class="gt_group_heading" scope="colgroup" id="Artiodactyla">Artiodactyla</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Artiodactyla  name" class="gt_row gt_left">Goat</td>
<td headers="Artiodactyla  awake" class="gt_row gt_right">18.70</td>
<td headers="Artiodactyla  bodywt" class="gt_row gt_right">33.50</td>
<td headers="Artiodactyla  brainwt" class="gt_row gt_right">0.12</td></tr>
    <tr><td headers="Artiodactyla  name" class="gt_row gt_left">Cow</td>
<td headers="Artiodactyla  awake" class="gt_row gt_right">20.00</td>
<td headers="Artiodactyla  bodywt" class="gt_row gt_right">600.00</td>
<td headers="Artiodactyla  brainwt" class="gt_row gt_right">0.42</td></tr>
    <tr class="gt_group_heading_row">
      <th colspan="4" class="gt_group_heading" scope="colgroup" id="Primates">Primates</th>
    </tr>
    <tr class="gt_row_group_first"><td headers="Primates  name" class="gt_row gt_left">Human</td>
<td headers="Primates  awake" class="gt_row gt_right">16.00</td>
<td headers="Primates  bodywt" class="gt_row gt_right">62.00</td>
<td headers="Primates  brainwt" class="gt_row gt_right">1.32</td></tr>
    <tr><td headers="Primates  name" class="gt_row gt_left">Baboon</td>
<td headers="Primates  awake" class="gt_row gt_right">14.60</td>
<td headers="Primates  bodywt" class="gt_row gt_right">25.23</td>
<td headers="Primates  brainwt" class="gt_row gt_right">0.18</td></tr>
  </tbody>
  &#10;  
</table>
</div>

And then use such a table to display a legend:

``` r
ggplot(df, aes(sleep_total, sleep_rem, colour = name)) +
  geom_point(na.rm = TRUE) +
  guides(colour = guide_gtlegend(animals))
```

<img src="man/figures/README-ggplot_example-1.svg" width="80%" style="display: block; margin: auto;" />
