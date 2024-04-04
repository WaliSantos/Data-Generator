#Algoritmo de DA adaptado dos trabalhos de Lais Cardoso de Medeiros e do professor Andre Luiz C. Ottoni
#Este algoritmo gera novas imagens com o filtro de brilho + contraste + correcao gamma
  
  remove(list=ls())
  
  #Diretório da fotografia original
  setwd("D:/UFBA/IC/data generator/DATGenerator/imagens")
  
  #Importação da biblioteca EBImage
  library(EBImage)
  
  #Lista de fotografias originais 
  #ATENÇÃO: A fotografia deve estar no formato indicado, nesse exemplo ".png"
  photographs=list.files(path="D:/UFBA/IC/data generator/DATGenerator/imagens",
                   pattern = "\\.JPG$",
                   ignore.case = TRUE,
                   recursive = TRUE) #vetor com todos os arquivos .jpg
  
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
  
  nImageBrightnessContrastGammaCorrection = 4
  
  #Aplica filtro de Correcao Gamma
  #Objetivo -> gerar novas imagens (imagens artificiais)
  for(j in 1:nImageBrightnessContrastGammaCorrection){
    for(i in 1:length(photographs)){
      originalImage=readImage(photographs[i])
      resizeImage = resize(originalImage, 500) #6 MB
      plot(resizeImage)
      
      #Brilho
      randomValueIfBrilho= runif(1, min=0, max=1000);
      
      if(randomValueIfBrilho > 500){
        #Transformacao brilho: aumenta o brilho
        randomValueBrilho= runif(1, min=0.1, max=0.2);
        brightnessImage=resizeImage
        brightnessImage@.Data = resizeImage@.Data+randomValueBrilho
        plot(brightnessImage)
        
      }else{
        #Transformacao brilho: diminui o brilho
        randomValueBrilho= runif(1, min=0.4, max=0.5);
        brightnessImage=resizeImage
        brightnessImage@.Data = resizeImage@.Data-randomValueBrilho
        plot(brightnessImage)
      }
      
      #Transformacao Contraste
      randomValueConstraste= runif(1, min=0.5, max=0.6);
      contrastImage=brightnessImage
      contrastImage@.Data = brightnessImage@.Data*randomValueConstraste
      
      randomValue= runif(1, min=0, max=1000);
      
      randomGammaValue = runif(1, min=0.4, max=0.6);
      
      #Transformacao: Correcao Gamma
      gammaCorrectionImage= contrastImage^randomGammaValue
      plot(gammaCorrectionImage)
      
      randomValue= runif(1, min=0, max=1000);
      
      filename = gsub("[[:space:]./\\\\]", "_", photographs[i])
      
      png(file.path("D:/UFBA/IC/data generator/DATGenerator/Transformacoes/BrilhoContrasteCGamma", 
                    paste(randomValue, filename,".png")))
      
      plot(gammaCorrectionImage)
      dev.off()
      
    }
  }
  