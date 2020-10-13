# Parcial 1 - Sistemas distribuidos 2020-2

## Integrantes

Juan David Paz Dorado - **A00328036**
German Andrés Carvajal - **A00134280**	

Este es el repositorio correspondiente al primer parcial de sistemas distribuidos. [https://github.com/JuanDoradoP/copiaparcial1](https://github.com/JuanDoradoP/copiaparcial1)
Incluye los archivos necesarios para poder realizar el aprovisionamiento de la plataforma requerida en el enunciado principal. La cual consta de un servidor web (Backend - Frontend), Que realiza peticiones a una base de datos. Ademas de un balanceador de carga para las peticiones. 


## Descripción general 

Para realizar exitosamente el parcial, se necesitó de cuatro maquinas que corresponden a: 
**1.** Maquina balanceador de carga.  **-->** 192.168.50.14

**2.** Maquina base de datos.      **-->**         192.168.50.13

**3.** Maquina servidor web 1 		 **-->**		192.168.50.11

**4.** Maquina servidor web 2. 	 **-->**		192.168.51.12

Para el despliegue automático de estas maquinas se utilizó la herramienta **Vagrant**. Para la gestión de la configuración se uso la herramienta **SaltStack**. 

El sistema operativo de las maquinas anteriormente mencionadas fue **Ubuntu 18.04**, Esto debido al exceso de tiempo que tomaba el despliegue de las maquinas con CentOS. Ahora, con ubuntu, el tiempo aproximado de despliegue es al rededor de 10 minutos.

**Uso de Vagrant**
Para hacer uso de esta herramienta se debe saber  compaginar con SaltStack. Pues en el archivo Vagrantfile se declara la creación de las 4 maquinas,  a partir de una maquina master. 

Ya con el archivo Vagrantfile creado, se procede a ejecutar el siguiente comando

    vagrant up 


**Uso de SaltStack**
Para hacer uso de esta herramienta se debe tener en cuenta los siguientes items:

**1. Forma de uso** : SaltStack permite trabajar de manera grupal con un master (Maestro - esclavo). El cual se encarga de gestionar el resto de minions. O de trabajar sin el master (Masterless), es decir, sin que se requiera una maquina específica para la gestión. En nuestro caso, debido a la búsqueda de información que realizamos previamente, decidimos usar el modelo maestro - esclavo, pues nos parecio mas intuitivo y con mas información detallada.

**2. Archivos de configuración** 

Es necesario conocer la manera en como se debe configurar en    SaltStack. Para ello, es necesario reconocer los archivos .sls pues    estos será los archivos de configuración que ejecutarán. Para este    parcial, se tiene en la carpeta *salt* el archivo top.sls el cual nos    esta definiendo otros cuatro archivos .sls que se ejecutaran de  acuerdo al tipo de maquina que se deseé configurar.

**3. Comandos principales de los archivos de configuración**

Es importante también conocer la manera en como podremos dar indicaciones en los archivos .sls. En este trabajo se hizo uso de los siguientes comandos:
 

       file.managed:
       
    - name: <ruta destino>
    - source: <ruta origen>

El cual nos permite transferir archivos desde nuestra maquina host hacia los minions requeridos.

    cmd.run:
    - name: <ruta del archivo>
  
  El cual nos permite ejecutar comandos/archivos, por ejemplo: de tipo .sh

    pkg.installed:
    - pkg: <nombre del paquete> 

El cual nos permite instalar paquetes en nuestros minions.


**4. Comandos para la gestión de la configuración**

Reconocimos los dos comandos principales requeridos para poder gestionar la configuración de manera adecuada. El primero de ellos nos indica que la comunicacion entre el master y los minions es exitosa. Y el segundo pone en funcionamiento las configuraciones designadas en nuestros archivos .sls

    sudo salt '*' test.ping
    
    sudo salt '*' apply.state 



## Balanceador de carga
La herramienta que se escogió  para el balanceador de carga fue haproxy.  es un proxy inverso que distribuye el tráfico de red o de una aplicación a varios servidores. Esta herramienta ya había sido trabajada en el workshop-2 de sistemas distribuidos. En el archivo de configuración del balanceador (balancer.sls) Se define lo siguiente:

**1.** Se instala el paquete haproxy por medio del pkg.installed.

**2.** Se añade al  archivo haproxy.cfg la configuración del balanceador de carga. Esto define el puerto por el cual recibirá peticiones el balanceador y las direcciones de los servidores donde deberá redireccionar las peticiones.

**3.**  reiniciar el servicio de haproxy para que se cargue la configuración.
