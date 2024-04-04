#Algoritmo de DA adaptado dos trabalhos de Lais Cardoso de Medeiros e do professor Andre Luiz C. Ottoni
#Este algoritmo gera novas imagens com o filtro de contraste.
remove(list=ls())

#Diretório da fotografia original
setwd("D:/UFBA/IC/data generator/DATGenerator/imagens")

#Importação da biblioteca EBImage
library(EBImage)

#Lista de fotografias originais 
#ATENÇÃO: A fotografia deve estar no formato indicado, nesse exemplo ".jpg"
photographs=list.files(path="D:/UFBA/IC/data generator/DATGenerator/imagens",
                       pattern = "\\.JPG$",
                       ignore.case = TRUE,
                       recursive = TRUE) #vetor com todos os arquivos .jpg

print(photographs)
#Aplica filtro de redimensionamento(resize) na lista de fotografias originais
#Objetivo -> diminuir o processamento do treinamento
for(i in 1:length(photographs)){
  originalImage=readImage(file.path("D:/UFBA/IC/data generator/DATGenerator/imagens",photographs[i]))
  resizeImage=resize(originalImage, 500) 
  plot(resizeImage)
  
  randomValue=runif(1, min=0, max=1000);
  
  filename = gsub("[[:space:]./\\\\]", "_", photographs[i])
  
  
  png(file.path("D:/UFBA/IC/data generator/DATGenerator/Transformacoes/Combinações/originais", 
                paste(randomValue, filename, ".png")))#cria um arquivo png
  
  
  plot(resizeImage)
  dev.off()
  
}

nImageContrast = 4

for(j in 1:nImageContrast){
  for(i in 1:length(photographs)){
    originalImage=readImage(photographs[i])
    resizeImage = resize(originalImage, 500)
    plot(resizeImage)
    
    #Transformacao contraste: 
    randomValueConstraste= runif(1, min=0.4, max=0.8);
    contrastImage= resizeImage
    contrastImage@.Data = resizeImage@.Data*randomValueConstraste
    
    randomValue= runif(1, min=0, max=1000);
    
    filename = gsub("[[:space:]./\\\\]", "_", photographs[i])
    
  
    png(file.path("D:/UFBA/IC/data generator/DATGenerator/Transformacoes/Contraste", 
                  paste(randomValue, filename,".png")))
    
    plot(contrastImage)
    dev.off()
    
  }
}
