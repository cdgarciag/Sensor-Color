# Sensor-Color
Librería Sensor color rojo-amarillo/verde con separación de servomotores por color
  Introducción:
En este proyecto, se diseña un sistema embebido utilizando una FPGA (Field-Programmable Gate Array) para controlar un sensor de colores y dos servomotores. El sensor de colores empleado es el TCS3200, un sensor capaz de detectar diferentes colores en base a la frecuencia de salida generada al iluminar una superficie con luz blanca. La frecuencia generada por el sensor varía en función del color detectado, lo que permite distinguir entre diferentes colores como rojo, verde y otros.

La FPGA actúa como el controlador principal del sistema, interpretando la señal del sensor para identificar el color de un objeto. Según el color detectado, se activan los servomotores, que ajustan su posición en consecuencia. Este proyecto es un ejemplo de cómo se puede utilizar hardware programable para diseñar sistemas interactivos y de respuesta rápida, combinando el procesamiento de señales digitales y el control de actuadores.

  Objetivos:
1.Diseñar y sintetizar un módulo en Verilog para procesar la señal del sensor de colores TCS3200 y determinar el color detectado en función de la frecuencia de salida.

2.Implementar control PWM para servomotores utilizando la FPGA. La posición de los servos dependerá del color detectado por el sensor, moviéndose a posiciones predefinidas para cada color (rojo, verde y otros).

3.Integrar el sensor de colores y los servomotores en un sistema funcional, donde el cambio en los colores de un objeto observado por el sensor desencadene movimientos en los servos.

4.Implementar la simulación y verificación del diseño RTL (Register Transfer Level) mediante el uso de herramientas como Icarus Verilog para la simulación y GTKWave para la visualización de las formas de onda.

5.Optimizar el uso de recursos de la FPGA y asegurar que el diseño pueda ser sintetizado y mapeado correctamente en una FPGA de la familia iCE40.

6.Cargar el diseño en una FPGA física y verificar su funcionamiento en tiempo real utilizando un entorno de hardware (conexiones de sensor, servomotores, etc.).

  Realizacion del proyecto
  
  Diagrama de flujo:
<img src="C:\Users\krist\OneDrive - Universidad Nacional de Colombia\Documentos\GitHub\Sensor-Color" alt="Descripción de la imagen" width="300px">


