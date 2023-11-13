import_dependencies <- function() {
  
  is_installed <- function(pack) {
    
    test <- length(nzchar(find.package(package = pack, quiet = TRUE)))
    
    return(test == 1)
  }
  
  packages <- c("ISLR2", "tidyr", "dplyr", "purrr", "ggplot2")
  uninstalled <- packages[!c(sapply(packages, is_installed)) & packages != "ISLR2"]
  
  install.packages(uninstalled)
  invisible(lapply(packages, library, character.only = TRUE))
}