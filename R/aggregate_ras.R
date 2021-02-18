#' Reproject raster file
#'
#' @param input_file Raster file, including path, to reproject
#' @param output_file Raster file, including path, to save as
#' @param crs Target reprojection
#' @param res Resolution value
#' @param ext Vector of four values: xmin, xmax, ymin, ymax
#' @param method Resampling method. "near" for categorical data, "bilinear" for continuous data. Other methods are possible, see \url{https://www.gdal.org/gdalwarp.html}
#'
#' @return Saved output file
#' @export
#'
#' @examples
#' \dontrun{
#' aggregate_ras('my_path/temp.tif', 'my_path/reproj_temp.tif',
#'           crs = '+proj=utm +zone=55 +south +ellps=GRS80 +units=m +no_defs',
#'           res = 1000,
#'           method = "average",
#'           ext = c(-58000, 764000, 5661000, 6224000))
#' }
aggregate_ras <- function (input_file, output_file, crs, res, ext, method) {

  system(paste("gdalwarp -overwrite -tr",
               res, res, "-r",
               method ,"-t_srs",
               paste0("'", crs, "'"),
               "-te", ext[1], ext[3], ext[2], ext[4],
               paste0("'", input_file, "'"),
               paste0("'", output_file, "'")
  ))
}
