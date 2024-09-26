# Sensor-Color
Librería Sensor color rojo-amarillo/verde con separación de servomotores por color.
 # Introducción.
En este proyecto, se diseña un sistema embebido utilizando una FPGA (Field-Programmable Gate Array) para controlar un sensor de colores y dos servomotores. El sensor de colores empleado es el TCS3200, un sensor capaz de detectar diferentes colores en base a la frecuencia de salida generada al iluminar una superficie con luz blanca. La frecuencia generada por el sensor varía en función del color detectado, lo que permite distinguir entre diferentes colores como rojo, verde y otros. 

La FPGA actúa como el controlador principal del sistema, interpretando la señal del sensor para identificar el color de un objeto. Según el color detectado, se activan los servomotores, que ajustan su posición en consecuencia. Este proyecto es un ejemplo de cómo se puede utilizar hardware programable para diseñar sistemas interactivos y de respuesta rápida, combinando el procesamiento de señales digitales y el control de actuadores.

 # Objetivos.
 Falta objetivo generAL
1.Diseñar y sintetizar un módulo en Verilog para procesar la señal del sensor de colores TCS3200 y determinar el color detectado en función del periodode la señal de salida.

2.Implementar control PWM para servomotores utilizando la FPGA. La posición de los servos dependerá del color detectado por el sensor, moviéndose a posiciones predefinidas para cada color (rojo, verde y otros).

3.Integrar el sensor de colores y los servomotores en un sistema funcional, donde el cambio en los colores de un objeto observado por el sensor desencadene movimientos en los servos.

4.Implementar la simulación y verificación del diseño RTL (Register Transfer Level) mediante el uso de herramientas como Icarus Verilog para la simulación y GTKWave para la visualización de las formas de onda.

5.Optimizar el uso de recursos de la FPGA y asegurar que el diseño pueda ser sintetizado y mapeado correctamente en una FPGA de la familia iCE40.

6.Cargar el diseño en una FPGA física y verificar su funcionamiento en tiempo real utilizando un entorno de hardware (conexiones de sensor, servomotores, etc.).

 # Realizacion del proyecto
  
   ## Diagrama de flujo
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/Imagen%20de%20WhatsApp%202024-09-23%20a%20las%2011.38.44_0bca3c8c.jpg" alt="Diagrama de flujo" width="300px">

  ## Primer paso:
1- Motor paso a paso
Una vez concluido con el diagrama y las funciones de nuestro proyecto empezamos a trabajar en el motor paso a paso para nuestra banda, la cual se encargará de transportar el objetivo a identificar, utilizamos el motor 28BYJ48 [IR A DATASHEET MOTOR](https://www.alldatasheet.com/html-pdf/1245086/ETC1/28BYJ48/111/1/28BYJ48.html); como resultado tenemos el siguiente codigo [codigo motor paso a paso](https://github.com/cdgarciag/Sensor-Color/blob/main/stepper_motor_control.v)

2-Detector de color
Identificamos un sensor de color el tcs3200 para tener una señal digital a la fpga [Sensor TCS3200](https://github.com/cdgarciag/Sensor-Color/blob/main/tcs3200-e11.pdf); luego caracterizamos las señales de cada filtro del sensor <img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/IMG-20240926-WA0062.jpg" alt="Caracterizacion colores con cada filtro" width="300px">.


Se realizo la deteccion de colores con el sensor TCS3200 con el filtro rojo; una vez obtenido la caracterización, se procede a trabajar en código por medio de salidas a leds, dónde al identificar rojo y/o sus escalas prendía el led rojo; al detectar amarillo y/o verde encendía un LED amarillo y por último si estaba fuera de esos colores encendía led azul, es importante tener un ambiente controlado y una fina caracterización de las frecuencias en los colores, de lo contrario podría encender el led equivocado o no hacer nada (se pone código o imagen de este??? Opcional??)
 "https://youtube.com/shorts/jnEY-yCBN_E?feature=share"


