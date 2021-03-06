#' Catch All Function
#'
#' @description mutates the column selected to replace those below the cutoff as "catch-all" observations
#'
#' @param df the data frame you wish to perform the catch-all on, this will be returned
#' @param group the column (group) you wish to set a catch-all for, make sure this is in quotes "group"
#' @param wanted a level or vector of levels within the group that you would not like to be part of the catch-all no matter what
#' @param cutoff the cut off you would like your catch-all to stop at i.e. n <= cutoff
#'
#' @return returns the data frame or tibble with altered catch-all observations
#' @export
#'
#'
#' @importFrom dplyr "%>%" "group_by" "summarise" "filter" "n" "rename"
#' @importFrom tidyselect "all_of"
#'
#'
#' @examples
#' # 3 different groups of cylinder types
#' table(mtcars$cyl)
#'
#' # create catch-all for counts less than or equal to 20, not including 4 and 6 cylinder
#' new_df <- CatchAll(group = "cyl", wanted = c("4", "6"), cutoff = 20, df = mtcars)
#'
#' # previously this should be all three levels are catch-all,
#' # but we saved cylinder 4 and 6 from being part of it
#'
#' table(new_df$cyl)
#'
#' head(new_df, n = 20)
#'
#' #                     mpg       cyl  disp  hp drat    wt  qsec vs am gear carb
#' # Mazda RX4           21.0         6 160.0 110 3.90 2.620 16.46  0  1    4    4
#' # Mazda RX4 Wag       21.0         6 160.0 110 3.90 2.875 17.02  0  1    4    4
#' # Datsun 710          22.8         4 108.0  93 3.85 2.320 18.61  1  1    4    1
#' # Hornet 4 Drive      21.4         6 258.0 110 3.08 3.215 19.44  1  0    3    1
#' # Hornet Sportabout   18.7 catch-all 360.0 175 3.15 3.440 17.02  0  0    3    2
#' # Valiant             18.1         6 225.0 105 2.76 3.460 20.22  1  0    3    1
#' # Duster 360          14.3 catch-all 360.0 245 3.21 3.570 15.84  0  0    3    4
#' # Merc 240D           24.4         4 146.7  62 3.69 3.190 20.00  1  0    4    2
#' # Merc 230            22.8         4 140.8  95 3.92 3.150 22.90  1  0    4    2
#' # Merc 280            19.2         6 167.6 123 3.92 3.440 18.30  1  0    4    4
#' # Merc 280C           17.8         6 167.6 123 3.92 3.440 18.90  1  0    4    4
#' # Merc 450SE          16.4 catch-all 275.8 180 3.07 4.070 17.40  0  0    3    3
#' # Merc 450SL          17.3 catch-all 275.8 180 3.07 3.730 17.60  0  0    3    3
#' # Merc 450SLC         15.2 catch-all 275.8 180 3.07 3.780 18.00  0  0    3    3
#' # Cadillac Fleetwood  10.4 catch-all 472.0 205 2.93 5.250 17.98  0  0    3    4
#' # Lincoln Continental 10.4 catch-all 460.0 215 3.00 5.424 17.82  0  0    3    4
#' # Chrysler Imperial   14.7 catch-all 440.0 230 3.23 5.345 17.42  0  0    3    4
#' # Fiat 128            32.4         4  78.7  66 4.08 2.200 19.47  1  1    4    1
#' # Honda Civic         30.4         4  75.7  52 4.93 1.615 18.52  1  1    4    2
#' # Toyota Corolla      33.9         4  71.1  65 4.22 1.835 19.90  1  1    4    1


CatchAll <- function(df, group, wanted = NULL, cutoff) {

  count_group <- NULL

  temp <- df %>%
    rename(grouping = all_of(group)) %>%
    group_by(grouping) %>%
    summarise(count_group = n())

  temp %<>%
    filter(count_group <= cutoff, !(temp$grouping %in% wanted))

  df[[group]][df[[group]] %in% temp$grouping] <- "catch-all"

  return(df)

}
