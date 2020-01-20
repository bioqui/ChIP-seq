## Welcome to this path line. You can use it to analyse your samples from a chIP-seq analysis.
## To run it you must fill the params.txt archive like we comment here: 
##
## FIRST OF ALL YOU MUST FILL THE PARAMS ARCHIVE CONSIDERING THAT IT HAS TO BE A GAP BETWEEN “:” AND THE INFORMATION BELONG. 
##	In first place, all the archive of this analysis must be saved in a folder. 
##	The variable SCRIPT should be filled with the directory`s folder, it will be
##	the folder where the programme is going to be executed. (./pipechip params.txt)
##	
##	The variable working_directory must be filled with the pathway of the directory where you want to save all the results.
##
##	“number_of_samples” is a parameter that indicates the total number of samples (num chip + num input)
## 
## There are two types of data analysis. To indicate your election you must choose and fill the parameter “test”. 
##	Test:yes
##
## You have all the archives to run the pathline, it means you have the organism genome (genoma.fa), annotation.gtf,
## and all the samples (chip/input.fa).
## In this case, you must fill all the parametes and variables with the pathway where they are: genome, annotation, samples.
## The parameter SAMPLES could be modified depending on your number of samples. It is important to have an order stablished
## in the pathway (firts all chips and then all input with the same order as chip).
##
##	Test: no
##
## You’ll get all the archives necessaries from data bases. In this case, you must copy the download link from the genome of the organism and the annotation. 
## The samples, will be filled by the number <SRRA…….> following the same order descripted before. 
##
## We recommend you to visit http://homer.ucsd.edu/homer/ for HOMER analyze. There you will find the information to fill the 
## variables size and org (it depends of the organism you want to analyze). 
##
## Results of this analyze will be saved in the HOMER folder (results folder). Interesting information is presented in the html archive. 
##
##
## RStudio analysis is only available if you have a narrowPeaks archive generated and if your organism is Arabidopsis thaliana.
## If you don’t have these requirements you must fill the param
##	 test2: no
## If you have the requierements:
##	 test2: yes
##
## BEFORE CONTINUING WITH THE ANALYZE WE RECOMMEND YOU TO OPEN RStudio.R ARCHIVE BECAUSE MAYBE YOU NEED TO INSTALL ALL THE PACKAGES NECESSARIES. 
## Obtaining results:
## GEO enrichment analyze results will appear in RSTUDIO folder where you could find all the plots generated:
## plot_ebp.jpeg (biologycal process), plot_e_mf.jpeg (molecular function) and plot_e_cc.jpeg (celular compartiment). The target_genes names are 
## saved in the archive.txt.
##
## KEGG enrichment results will appear in RSTUDIO folder where you could find images of the enrichment with all the names in there. 
## WITH THIS ANALYSIS, THE UNIVERSE IS ONLY VALID FOR THE CHROMOSOME 1, FOR OTHER TYPE OF SAMPLES YOU MUST MODIFY RScript.R

#### IF YOU HAVE ANY QUESTIONS PLEASE CONSULT THE SPANISH VERSION BELOW.
















## Bienvenidos este path line sirve para realizar anális de Chip-Seq. Para ponerlo en función deberá rellenar
## el archivo "params.txt" como aquí se indica.
##
## PARA RELLENAR EL FICHERO PARÁMETROS TENER EN CUENTA QUE DEBE HABER UN ESPACIO ENTRE LOS ":" Y LA INFORMACIÓN RELLENADA.
##
##	En primer lugar los scrips deberán ser guardados todos en una carpeta, el directorio de esa carpeta deberá 
##	rellenar la variable "script" y será desde esta carpeta desde donde se ejecute el programa.
## 
##	El parámetro "working_directory" se debe rellenar con la ruta de enlace al directorio donde se guardaran
##	todos los archivos del estudio
##
##	El parámetro "number_of_samples" se debe rellenar con el número total de muestras, es decir, nº chip + nº input
##
## Existen dos modalidades de análisis de datos, para diferenciar su elección debe rellenar el parámetro "test":
##
##	test: yes
##
##  - 1º: Dispone de los datos a análizar en su PC, es decir, del genoma del organismo a utilizar 
##	(genome.fa), fichero de anotación (annotation.gtf) y de los ficheros de las muestras (chip/input.fa)
##	
##	En ese caso deberá rellenar en el archivo parámetros las variables: genome, annotation y
##	samples, las cuales deberá modificar dependiendo de su número de muestras y además, siguiendo
##	un orden definido con las rutas de enlace de dónde se encuentren esos archivos.
##	
##	El orden a seguir para rellenar las variables samples es el siguiente: en primer lugar la 
##	ruta con los archivos chip. Tras haber rellenado con las rutas de los archivos chip comenzar
##	a rellenar con las rutas de los archivos input, estos input tienen que ordenarse con sus 
##	correspondientes chip.
##	
##	test: no	
##
##  - 2º: Obtendrá todos os archivos procedentes de datos de bases de internet, en ese caso deberá
##	copiar la ruta de enlace de la descarga tanto del genoma como del fichero de anotación en las 
##	variables genome and annotation.
##	
##	En cuanto a las samples deberá rellenar con los números <SRRA------->, siguiendo el mismo orden
##	descrito anteriormente.
##
## Análisis HOMER,se recomienda visitar http://homer.ucsd.edu/homer/ donde encontrará información sobre
## el análisis realizado. Para este análisis deberá rellenar los parámetros:
##
##	"size" con el tamaño que crea necesario
##	
##	"org" con la referencia del organismo que esté analizando 
##
##	Encontrará la información en la página de como rellenar ambos. Los resultados se presentarán en las carpetas HOMER_X
##	que se generan en la carpeta results. Los archivos dónde se visualizan los resultados vienen en formato html.
##
## Análisis de RSTUDIO, este análisis solamente está disponible para aquellos que solo tengan un archivo narrowpeaks, 
## y el organismo sea Arabidopsis Thaliana en caso de lo contrario rellenar el parámetro "test2":
##
##	test2: no
##
## Si se cumplen los requisitos:
##
##	test2: yes
##
## ANTES DE CONTINUAR CON EL ANÁLISIS SE RECOMIENDA QUE SE HABRÁ EL ARCHIVO RStudio.R Y SE INSTALEN LOS PAQUETES QUE SE EMPLEAN
##
## Atendiendo a los resultados:
##
##	Los resultados del enriquecimiento de GEO, apareceran en la carpeta RSTUDIO, donde podrá encontrar los plots: 
##	plot_e_bp.jpeg (Biologycal process),plot_e_mf.jpeg (molecular function) y plot_e_cc.jpeg (celular compartiment).
##	Además del nombre de los target genes en un archivo .txt
##
##	Los resultados del enriquecimiento KEGG, aparecen en la carpeta RSTUDIO, donde podrá encontrar las imágenes del
##	enriquecimiento con los nombres de los genes enriquecidos. 
##	DESTACAR QUE ESTE ANÁLISIS SOLO SALDRÁ PARA LA MUESTRA A COMPARA EN LA TAREA YA QUE EL UNIVERSO DEL ANÁLISIS ES 
##	EL CROMOSOMA 1, PARA OTRO TIPO DE MUESTRAS DEBERÁ MODIFICARSE RScript.R
