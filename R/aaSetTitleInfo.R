
#' 读取物料导入模板各个业签的名称
#'
#' @param file 物料模板所在的文件路径
#'
#' @return 返回页答的list
#' @import readxl
#' @import tsdo
#' @import tsda
#' @export
#'
#' @examples
#' mtrl_getSheetNames();
mtrl_getSheetNames <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')) {
  sheetSetting <- read_excel(file,
                             sheet = "配置表头")
  sheetSetting <- sheetSetting[-c(1:2),]
  names(sheetSetting) <-c('FIndex','FName','FNote')
  #ncount <- nrow(sheetSetting);
  res <-sheetSetting$FName;
  names(res) <- sheetSetting$FIndex;

  return(res)
  }



#' 获取物料模板的组织信息
#'
#' @param file 物料模板所有的路径
#'
#' @return 返回包含组织信息的list
#' @import readxl
#' @import tsdo
#' @import tsda
#' @export
#'
#' @examples
#' mtrl_getOrgInfo()
mtrl_getOrgInfo <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')) {
  orgInfo <- read_excel(file,
                        sheet = "配置表头")
  orgInfo <- orgInfo[1:2,]
  names(orgInfo) <-c('FIndex','FName','FNote')
  orgInfo <-vect_as_list(orgInfo$FName)
  names(orgInfo) <- c('FOrgCode','FOrgName')
  return(orgInfo)
}




