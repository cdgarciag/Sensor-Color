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
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/Imagen%20de%20WhatsApp%202024-09-23%20a%20las%2011.38.44_0bca3c8c.jpg" alt="Diagrama de flujo" width="750px">

  ## Primer paso:
1- *Motor paso a paso*

Una vez concluido con el diagrama y las funciones de nuestro proyecto empezamos a trabajar en el motor paso a paso para nuestra banda, la cual se encargará de transportar el objetivo a identificar, utilizamos el motor 28BYJ48 [IR A DATASHEET MOTOR](https://www.alldatasheet.com/html-pdf/1245086/ETC1/28BYJ48/111/1/28BYJ48.html); como resultado tenemos el siguiente codigo [codigo motor paso a paso](https://github.com/cdgarciag/Sensor-Color/blob/main/Verilog/stepper_motor_control.v)

2- *Detector de color*
Identificamos un sensor de color el tcs3200 para tener una señal digital a la fpga [Sensor TCS3200](https://github.com/cdgarciag/Sensor-Color/blob/main/tcs3200-e11.pdf); luego caracterizamos las señales de cada filtro del sensor.

<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/IMG-20240926-WA0062.jpg" alt="Caracterizacion colores con cada filtro" width="1200px">.


Se realizo la caracterización de colores con el sensor TCS3200 con el filtro rojo; una vez obtenido la caracterización, se procede a trabajar en código por medio de salidas a leds, dónde al identificar rojo y/o sus escalas prendía el led rojo; al detectar amarillo y/o verde encendía un LED amarillo y por último si estaba fuera de esos colores encendía led azul, es importante tener un ambiente controlado y una fina caracterización de las frecuencias en los colores, de lo contrario podría encender el led equivocado o no hacer nada, a continuacion ya se encuentra el codigo terminado con las salidas a los servos [Codigo sensor color](https://github.com/cdgarciag/Sensor-Color/blob/main/Verilog/sensor_finish.v); ademas aqui un [video mostrando nuestro sensor de colores con las salidas de los LEDS](https://youtube.com/shorts/jnEY-yCBN_E?feature=share)

3- *servomotores*

Tomamos los servomotores  [SG90](https://www.alldatasheet.es/html-pdf/1572383/ETC/SG90/59/1/SG90.html) los cuales podrían servir con la función de seleccionar o separar el objetivo según el color programado<br>
Una vez obtenido el [código Verilog de los servos](https://github.com/cdgarciag/Sensor-Color/blob/main/Verilog/servomotor_finish.v), empezamos a integrar los códigos de cada "módulo" hecho, intentamos de dos formas una la cual implementa todo en un solo verilog, y la otra dónde en verilog separados solo llamábamos al módulo que se necesita para su funcionamiento,  por ende optamos por la segunda opción, la cual nos fue más viable y menos errores al ejecutar, así que solo tuvimos pequeñas modificaciones como que las salidas del sensor tcs3200 ya no son led_rojo, led_amarillo, ni led_azul, ahora iban a ser entradas para los servomotores; servo1 para los colores rojo, servo2 para colores amarillos/ verdes y de resto ignorar, dejando así que sigan por la banda para otra posible selección de otro tipo mas detallada (según especificaciones del cliente final)

4-*Sensor de posicion*
Para evitar que los servos actuaran debido a ruido u alguna señal de color que no sea deseada pusimos un [sensor de obstaculos infrarrojo](https://www.murkyrobot.com/guias/sensores/detector-obstaculos-infrarrojo) donde manda una señal al inicio de los servos y estos inicien al detectar un obstaculo.
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/CLON-MH-SENSOR_800x800.jpeg" alt="sensor de posicion" width="750px">.

5-*Armado de la banda transportadora y sus partes*

Materiales:

-dos pliegos de carton paja<br>
-lamina de acrilico<br>
-silicona<br>
-caucho neumatico de bicicleta<br>
-tubo pvc<br>
*se hacen los rodillos con el tubo pvc y se pegan a los servomotores, se hacen soportes para darle altura y estabilidad<br>
*luego se hace una base firme, con acrilico y carton paja<br>
*luego se hace un pequeño cuarto con acrilico para poner el sensor TCS3200 y el sensor de posicion, asi tener un ambiente mas controlado de la luz externa<br>
*se hace una base a los servomotores y se pegan en linea para que queden cerca a la banda<br>
*ya con esto se hacen conexiones a la fpga y fuente de alimentacion<br>
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/IMG-20240927-WA0011.jpg" alt="Caracterizacion colores con cada filtro" width="750px">.
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/IMG-20240927-WA0015.jpg" alt="Caracterizacion colores con cada filtro" width="750px">.
<img src="https://raw.githubusercontent.com/cdgarciag/Sensor-Color/refs/heads/main/IMG-20240927-WA0013.jpg" alt="Caracterizacion colores con cada filtro" width="750px">.

#CONCLUSIONES

*Lo mas notorio en nuestro proyecto es que el sensor TCS3200 es muy sensible ante los cambios de luz, lo cual podria cambiar mucho las frecuencias, quisimos hacer un ambiente controlado para el sensor, el cual nos funciono para las pruebas con los leds, pero a la hora de montar con la banda trasnportadora variaba mucho ya que tocaba dejar entrada y salida, por ende entraba luz y ruido del medio ambiente
*Nos preguntabamos ¿que pasa si el objeto a sensar se encuentra pegado con otro?,los servomotores se activan al tiempo y podrian enviar un color por una banda incorrecta, entonces concluimos que se  podrian tener mas sensores de posicion para cada servomotor, donde donde llego el objeto y activo el servo o tambien poner en la banda transportadora una separacion como cajas, canales, para que tengan un espacio entre objetos y asi solo sea tener un tiempo(intervalo) entre la deteccion de color y el servo correspondiente
*se podria mejorar la estructura con mejores y mas materiales


