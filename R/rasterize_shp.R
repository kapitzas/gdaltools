#' Convert shapefile to raster
#'
#' @param input_file Shapefile file, including path, to convert to raster
#' @param output_file Raster file, including path, to save as
#' @param res Resolution value
#' @param ext Vector of four values: xmin, xmax, ymin, ymax
#' @param attribute by which to rasterize. Defaults to null
#' @param no_data no data value to be assigned (default is `no_data = 0`).
#' @return Saved output file
#' @export
#'
#' @examples
#' \dontrun{
#' rasterize_shp('my_path/lakes.shp', 'my_path/lakes.tif',
#'              res = 1000,
#'              ext = c(-58000, 764000, 5661000, 6224000),
#'              attribute = "size")
#' }
rasterize_shp <- function (input_file, output_file, res, ext, attribute = NULL, no_data = 0) {

  if (is.null(attribute)) {
    system(paste("gdal_rasterize -burn 1 -tr",
                 res, res, "-te",
                 ext[1], ext[3], ext[2], ext[4],
                 "-a_nodata", no_data,
                 paste0("'", input_file, "'"),
                 paste0("'", output_file, "'")
                 ))
  }

  if (!is.null(attribute)) {
    system(paste("gdal_rasterize -a",
                 attribute, "-tr",
                 res, res, "-te",
                 ext[1], ext[3], ext[2], ext[4],
                 "-a_nodata", no_data,
                 paste0("'", input_file, "'"),
                 paste0("'", output_file, "'")
                 ))
  }

}
