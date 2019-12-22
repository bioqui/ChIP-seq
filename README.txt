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
##	samples, las cual deberá modificar dependiendo de su número de muestras y además, siguiendo
##	un orden definido con las rutas de enlace de dónde se encuentren esos archivos.
##	
##	El orden a seguir para rellenar las variabales samples es el siguiente: en primer lugar la 
##	ruta con los archivos chip, tras haber rellenado con las rutas de los archivos chip comenzar
##	a rellenar con las rutas de los archivos input, estos input tienen que ordenarse con sus 
##	correspondientes chip.
##	
##	test: no	
##
##  - 2º: Obtendrá todos os archivos procedentes de datos de las bases de internet, en ese caso deberá
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
##	EL CROMOSOMA 1, PATA OTRO TIPO DE MUESTRAS DEBERÁ MODIFICARSE RScript.R
