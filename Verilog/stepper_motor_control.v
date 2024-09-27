module stepper_motor_control (
    input wire clk,          // Reloj de la FPGA
    output reg [3:0] motor   // Pines de salida para controlar IN1-IN4 del ULN2003
);

    reg [31:0] counter;      // Contador para controlar la velocidad
    reg [2:0] step_index;    // Índice de paso del motor

    // Secuencia de control de pasos definida con registros
    reg [3:0] step_sequence [0:7];

    // Velocidad de paso (ajustable)
    parameter STEP_DELAY = 22000;  // Ajusta este valor para cambiar la velocidad, valor minimo 22000

    initial begin
        // Inicialización de la secuencia de pasos
        step_sequence[0] = 4'b1000;
        step_sequence[1] = 4'b1100;
        step_sequence[2] = 4'b0100;
        step_sequence[3] = 4'b0110;
        step_sequence[4] = 4'b0010;
        step_sequence[5] = 4'b0011;
        step_sequence[6] = 4'b0001;
        step_sequence[7] = 4'b1001;
    end

    always @(posedge clk) begin
        if (counter >= STEP_DELAY) begin
            counter <= 0;
            step_index <= step_index + 1;
            motor <= step_sequence[step_index];
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
