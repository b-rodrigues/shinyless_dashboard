read_covid_data <- function(){
  data.table::fread("covid_data.csv") %>%
  mutate(year = year(week)) %>%
    mutate(month = month(week)) %>%
    mutate(month = ifelse(nchar(month) == 1, paste0(0, month), month)) %>%  
    mutate(year_month = paste0(year, "-", month)) %>%
    select(week, year_month, everything()) %>%  
    select(-year, -month)

 
}

get_population <- function(){
  covidGrandeRegion::population
}

plot_epi_curve <- function(raw_weekly_long){

  raw_weekly_long %>%
    plot_ly(x = ~week, y = ~value, mode = "lines", split = ~country)
}

make_raw_weekly_long <- function(raw_weekly_data){

  raw_weekly_data %>%  
    mutate(week = ymd(week)) %>%  
    tidyr::pivot_longer(c(cases, deaths), names_to = "type", values_to = "value")

}
