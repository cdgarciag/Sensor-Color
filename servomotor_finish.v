module servomotor_finish(
    input wire clk,     // Reloj del sistema 
    input wire state,// Estado para controlar el ángulo del servo (0 o 90 grados)
    output reg pwm_out  // Señal PWM para controlar el servomotor
);

    reg [31:0] pwm_counter = 0;
    reg [31:0] wait_counter = 0;


    parameter CLK_FREQ = 25000000;   // Frecuencia del reloj (ajustar según tu FPGA)
    parameter PWM_PERIOD = 500000;  // Periodo PWM de 20 ms (50 Hz)
    parameter PULSE_90 = 50000;      // Pulso de 2 ms para 90 grados
    parameter PULSE_0 = 25000;       // Pulso de 1 ms para 0 grados
    parameter WAIT_TIME = 75000000;  // Tiempo de espera de 1 segundo (ajustable)

    // Bloque siempre activo para la generación de la señal PWM
    always @(posedge clk) begin
        // Contador del periodo PWM (resetea después de 20 ms)
        if (pwm_counter >= PWM_PERIOD) begin
            pwm_counter <= 0;
        end else begin
            pwm_counter <= pwm_counter + 1;
        end

        // Generar la señal PWM basada en el estado (0 grados o 90 grados)
        case (state)
            1'b0: begin
                if (pwm_counter <= PULSE_90) begin
                    pwm_out <= 1;
                end else begin
                    pwm_out <= 0;
                end
            end

            1'b1: begin
                if (pwm_counter <= PULSE_0) begin
                    pwm_out <= 1;
                end else begin
                    pwm_out <= 0;
                end
            end
        endcase
    end

endmodule
