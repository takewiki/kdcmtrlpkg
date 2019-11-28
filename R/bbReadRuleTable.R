#' 获取规则表信息
#'
#' @param file 物料模板所在的目前
#'
#' @return 返回列表
#' @import readxl
#' @import tsdo
#' @import tsda
#' @export
#'
#' @examples
#' mtrl_getMetaInfo();
#' system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg');
mtrl_getMetaInfo <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  mtrl_ruleTable <- read_excel(file,
                               sheet = "规则对应表")
  names(mtrl_ruleTable) <-c('FIndex','FDBName','FKDCName','FInputName','FCalcType','FSrcSheet','FFormula','FDefaultValue')
  res  <- split(mtrl_ruleTable,mtrl_ruleTable$FCalcType)
  res$all <-mtrl_ruleTable
  names(res) <-c('aKdc','bInput','cCopy','dRef','eCalc','all');
  return(res)

}

#library(readxl)
#' 获取数据填写数据表实际数据
#'
#' @param file 数据填写表
#'
#' @return 返回值
#' @import readxl
#' @import tsdo
#' @import tsda
#' @export
#'
#' @examples
#' mtrl_getInputData();
mtrl_getInputData <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){

   tpl <- read_excel(file,sheet = "物料填写表")
   res <- tbl_as_df(tpl);
   return(res)


}

#' 获取数据的输出模板字段
#'
#' @param metaInfo 元数据
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_getTplName();
mtrl_getTplName <- function(metaInfo){
   allMetaInfo <- metaInfo$all;
   data <-allMetaInfo[,c('FDBName','FKDCName')];
   res <- df_row2Col(data)
   return(res)

}


#' 根据配置表产生金蝶云固有字段并按行复制
#'
#' @param inputData 输入数据
#' @param metaInfo 全部元数据表
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_genDataKdc();
mtrl_genDataKdc <-function(metaInfo,inputData){
   count <- nrow(inputData);
   kdcMetaInfo <- metaInfo$aKdc;
   data <- kdcMetaInfo[,c('FDBName','FDefaultValue')];
   #将行的元数据转化为列数据
   data2 <- tsdo::df_row2Col(data);
   #按行对数据进行复制
   data2 <-df_rowRepMulti(data2,count)
   return(data2);
}

#' 针对数据进行命名处理
#'
#' @param metaInfo 元数据
#' @param inputData 输入数据
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_genDataInput();
mtrl_genDataInput <-function(metaInfo,inputData){

   col_names <- metaInfo$bInput$FDBName;
   colnames(inputData) <- col_names
   return(inputData);


}


#' 获取组织的复制信息
#'
#' @param inputData 物料填写表
#' @param metaInfo 模板元数据
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_genDataCopy();
mtrl_genDataCopy <-function(metaInfo,inputData){
   count <- nrow(inputData);
   copyMetaInfo <- metaInfo$cCopy;
   data <- copyMetaInfo[,c('FDBName','FDefaultValue')];
   #将行的元数据转化为列数据
   data2 <- tsdo::df_row2Col(data);
   #按行对数据进行复制
   data2 <-df_rowRepMulti(data2,count)
   return(data2);

}


#' 获取物料中的复制数据
#'
#' @param metaInfo  元数据
#' @param inputData  输入数据
#'
#' @return 返回参数数据的DF
#' @export
#'
#' @examples
#' mtrl_genDataRef();
mtrl_genDataRef <- function(metaInfo,inputData){

   col_selected <-  metaInfo$dRef$FFormula;
   data <- inputData[,col_selected];
   col_names <-metaInfo$dRef$FDBName;
   colnames(data) <- col_names;
   return(data)

}

#' 用于处理内部字段
#'
#' @param metaInfo 元数据
#' @param inputData 输入数据
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_genDataCalc();
mtrl_genDataCalc <- function(metaInfo,inputData){
   count <- nrow(inputData);
   calcMetaInfo <- metaInfo$eCalc;
   data <- calcMetaInfo[,c('FDBName','FDefaultValue')];
   #修改数据类型为整数型
   data$FDefaultValue <- as.integer(data$FDefaultValue)
   data <- as.data.frame(data);
   data2 <- df_rowColEx(data);
   data2 <- data2[,-1];
   data2 <- df_rowRepMulti(data2,count);
   res <-lapply(data2, function(x){
      as.integer(x)+1:count
   })
   res <- as.data.frame(res);
   #将所有的数据进行数据化处理
   res <- df_as_character(res);
   colnames(res) <- names(data2)
   return(res)


}
