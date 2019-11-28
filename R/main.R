#' 处理物料主表数据
#'
#' @param file 文件所在的路径
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mtrl_main()
mtrl_main <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg')){
  #读取元数据
  metaInfo <- mtrl_getMetaInfo(file);
  #读取用户输入数据
  inputData <- mtrl_getInputData(file);
  #获取双行表头
  h2 <- mtrl_getTplName(metaInfo);
  #读取金蝶固有字段
  dataKdc <- mtrl_genDataKdc(metaInfo,inputData);
  #读取物料输入表数据
  dataInput <-mtrl_genDataInput(metaInfo,inputData);
  #读取复制数据
  dataCopy <-mtrl_genDataCopy(metaInfo,inputData);
  #读取表间取数字段
  dataRef <-mtrl_genDataRef(metaInfo,inputData);
  #读取内码字段
  dataCalc <-mtrl_genDataCalc(metaInfo,inputData);
  #print(head(dataCalc))
  #合并上述数据集
  data1 <- cbind(dataKdc,dataInput,dataCopy,dataRef,dataCalc);
  #head(data1)
  #str(data1);
  data1 <-data1[ ,colnames(h2)];
  res <- rbind(h2,data1);
  res <-df_as_character(res);
  return(res);



}


#' 物料处理的主表
#'
#' @param file 输入的模板文件
#' @param keepInput 是否保留输入数据否认为否
#'
#' @return 返回list
#' @export
#'
#' @examples
#' mtrl();
mtrl <- function(file=system.file('extdata/tpl.xlsx',package = 'kdcmtrlpkg'),
                 keepInput =  FALSE){
  sheetNames <- mtrl_getSheetNames(file);
  sheetNames_upload <-sheetNames[1:3];
  sheetNames_input <-sheetNames[1:6];
  sheet1 <- mtrl_sheet1_readme(file);
  sheet2 <-mtrl_sheet2_mtrlgp(file);
  sheet3 <- mtrl_main(file);
  sheet4 <- mtrl_sheet4_ruleTable(file);
  sheet5 <- mtrl_sheet5_setHeader(file);
  sheet6 <- mtrl_sheet6_inputTable(file);
  if (keepInput ==FALSE){
    res <-list(sheet1,sheet2,sheet3);
    names(res) <- sheetNames_upload;
  }else{
    res <- list(sheet1,sheet2,sheet3,sheet4,sheet5,sheet6);
    names(res) <- sheetNames_input
  }
  return(res)

}
