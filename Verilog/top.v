`include "./servomotor_finish.v"
`include "./sensor_finish.v"
`include "./stepper_motor_control.v"
module top (
   input wire mclk,        // Reloj principal desde el pin
   input wire sensor_clk,  // Salida de frecuencia del sensor desde el pin
   input wire detecto, //indica si detecto algo el infrarojo
   output wire [1:0] filtro_sel,  // Salida de selección del filtro(esta definida en sensor finish)
   output wire pwm_out1,    // Salida PWM para el primer servo
   output wire pwm_out2,    // Salida PWM para el segundo servo
   output wire motor1,       // Pin para IN1 del ULN2003
   output wire motor2,       // Pin para IN2 del ULN2003
   output wire motor3,       // Pin para IN3 del ULN2003
   output wire motor4,        // Pin para IN4 del ULN2003
   output wire motor5,       // Pin para IN1 del ULN2003
   output wire motor6,       // Pin para IN2 del ULN2003
   output wire motor7,       // Pin para IN3 del ULN2003
   output wire motor8,        // Pin para IN4 del ULN2003
);

   wire es_verde; 
   wire es_rojo;
   wire es_otro;
   reg [1:0] estado_servos = 2'b00;
   reg cont_iniciado =1'b0;
   reg [31:0] contador_main =32'd0;

   //parametro de tiempo de temporizador
   parameter max_contador = 32'd50000000;

   // Instancia del módulo tcs3200_fpga
   sensor_finish sensor (
      .mclk(mclk),
      .sensor_clk(sensor_clk),
      .es_verde(es_verde),
      .es_rojo(es_rojo),
      .es_otro(es_otro),
      .filtro_sel(filtro_sel)
   
   );

   // Instancias de los servomotores
   servomotor_finish servo1 (
      .clk(mclk),    
      .pwm_out(pwm_out1),
      .state(estado_servos[0]) // Conectar la salida PWM del primer servo
   );
   servomotor_finish servo2 (
      .clk(mclk),   
      .pwm_out(pwm_out2),
      .state(estado_servos[1]) // Conectar la salida PWM del segundo servo
   );

// Instancia del módulo de control del motor paso a paso
    stepper_motor_control motor_control (
        .clk(mclk),                        // Conectar el reloj principal de la FPGA
        .motor({motor4, motor3, motor2, motor1})  // Conectar las salidas del motor a los pines de salida
    );
    stepper_motor_control motor_control2 (
        .clk(mclk),                        // Conectar el reloj principal de la FPGA
        .motor({motor8, motor7, motor6, motor5})  // Conectar las salidas del motor a los pines de salida
    );

   always @(posedge mclk) begin
      if (!detecto && !cont_iniciado) begin
         // Detecta el flanco de subida del pulsador y comienza el conteo
            cont_iniciado <= 1'b1;
            if(es_verde) begin
            estado_servos <= 2'b10;
            end
            else if(es_rojo) begin
            estado_servos <= 2'b01; 
            end
            else begin 
            estado_servos <= 2'b00; 
            end
      end 
      else if (cont_iniciado && contador_main < max_contador) begin
         // Si el temporizador ha sido iniciado, incrementa el contador
         contador_main <= contador_main + 1;
      end 
      else if (cont_iniciado && contador_main >= max_contador) begin
         // Cuando el contador llega al valor máximo reinicia los servos y restablece los valores del temporizador
         estado_servos <= 2'b00;
         cont_iniciado <= 1'b0;      // El temporizador se desactiva después de contar una vez
         contador_main <= 32'd0;       // Reinicia el contador a 0 automáticamente
      end
   end

endmodule

