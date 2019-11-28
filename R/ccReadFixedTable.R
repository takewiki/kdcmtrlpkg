

#' 读取物料单页签的导入说明
#'
#' @param file 文件所有的路径
#'
#' @return 返回值
#' @import readxl
#' @export
#'
#' @examples
#' mtrl_sheet1_readme()
mtrl_sheet1_readme <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  #library(readxl)
  tpl <- read_excel(file,
                    sheet = "引入模板说明")
  res <- tbl_as_df(tpl)
  return(res)

}

#' 读取物料分组数据
#'
#' @param file 物料导入模板所有路径
#'
#' @return 返回值
#' @import readxl
#' @export
#'
#' @examples
#' mtrl_sheet2_mtrlgp()
mtrl_sheet2_mtrlgp  <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  #library(readxl)
  tpl <- read_excel(file,
                    sheet = "数据分组#单据头(FBillHead)Group")
  res <- tbl_as_df(tpl)
  return(res)

}

#' 读取规则表
#'
#' @param file 物料导入模板所有路径
#'
#' @return 返回值
#' @import readxl
#' @export
#'
#' @examples
#' mtrl_sheet4_ruleTable()
mtrl_sheet4_ruleTable <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  tpl <- read_excel(file,
                    sheet = "规则对应表")
  res <- tbl_as_df(tpl)
  return(res)

}

#' 读取设置表头
#'
#' @param file 物料导入模板所有路径
#'
#' @return 返回值
#' @import readxl
#' @export
#'
#' @examples
#' mtrl_sheet5_setHeader()
mtrl_sheet5_setHeader <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  tpl <- read_excel(file,
                    sheet = "配置表头")
  res <- tbl_as_df(tpl)
  return(res)

}

#' 读取物料填写数据
#'
#' @param file 物料导入模板所有路径
#'
#' @return 返回值
#' @import readxl
#' @export
#'
#' @examples
#' mtrl_sheet6_inputTable()
mtrl_sheet6_inputTable <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  tpl <- read_excel(file,
                    sheet = "物料填写表")
  res <- tbl_as_df(tpl)
  return(res)

}

