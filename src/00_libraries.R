import_dependencies <- function() {
  
  is_installed <- function(pack) {
    
    test <- length(nzchar(find.package(package = pack, quiet = TRUE)))
    
    return(test == 1)
  }
  
  packages <- c("tidyr", "dplyr", "purrr")
  uninstalled <- packages[!c(sapply(packages, is_installed))]
  
  install.packages(uninstalled)
  invisible(lapply(packages, library, character.only = TRUE))
}