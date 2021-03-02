library(targets)
library(tarchetypes)

tar_option_set(
  packages = c(
    "dplyr",
    "rpivotTable",
    "covidGrandeRegion",
    "lubridate",
    "plotly",
    "crosstalk",
    "DT",
    "flexdashboard"
  )
)

source("functions/functions.R")

list(
  tar_target(
    raw_weekly_data,
    #get_greater_region_data(daily = FALSE),
    read_covid_data(),
    format = "fst"
  ),

  tar_target(
    raw_weekly_long,
    make_raw_weekly_long(raw_weekly_data),
    format = "fst"
  ),

  tar_target(
    interactive_plot,
    draw_map(dataset = raw_weekly_data, daily = FALSE, normalize = FALSE),
    format = "qs"
  ),
  
  tar_render(
    dashboard,
    "dashboard.Rmd"
  )
)
