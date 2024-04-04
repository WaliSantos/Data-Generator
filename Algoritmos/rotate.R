#Algoritmo de DA adaptado dos trabalhos de Lais Cardoso de Medeiros e do professor Andre Luiz C. Ottoni
#Este algoritmo gera novas imagens com a trasformação de rotação

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

nImageRotate = 4

for(j in 1:nImageRotate){
  for(i in 1:length(photographs)){
    originalImage=readImage(photographs[i])
    resizeImage = resize(originalImage, 500)
    plot(resizeImage)
    
    randomValueRotate= runif(1, min=0, max=360);
    
    #Transformacao rotate: rotacao da imagem
      rotateImage = rotate(resizeImage,randomValueRotate);
      
      randomValue= runif(1, min=0, max=1000);
      
      filename = gsub("[[:space:]./\\\\]", "_", photographs[i])
      
      png(file.path("D:/UFBA/IC/data generator/DATGenerator/Transformacoes/Rotate", 
                    paste(randomValue, filename,".png")))
      
      plot(rotateImage)
      dev.off()
      
    }
  }
 