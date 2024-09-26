module sensor_finish (
    input wire mclk,
    input wire sensor_clk,
    output wire es_verde,
    output wire es_rojo,
    output wire es_otro,
    output wire [1:0] filtro_sel

);
 
	reg [31:0] periodo = 32'd0;
	reg [31:0] counter = 32'b00;//contador para el periodo de la frecuencia
	reg [31:0] counter_timer = 32'b00;//contador para que tome la medida cada x tiempo
	reg [2:0] color_detectado;

  //asignaciones cables de salida a sus valores

	assign filtro_sel = 2'b00;
	assign es_rojo = color_detectado[2];
	assign es_verde = color_detectado[1];
	assign es_otro = color_detectado[0];

	parameter max=25000000;//tiempo de espera para tomar la medida

 
	always @(posedge mclk) begin  // Contador del reloj principal para leer el periodo de la señal cuadrada
		if(sensor_clk) begin
			counter <= counter + 32'b1;
		end else begin
			if(counter != 32'b0) begin
				periodo <= counter;
			end 
			counter <= + 32'b0;
		end
	end


	always @(posedge mclk) begin//condicional cada x tiempo toma el valor de periodo y establece el color segun eso
		if(counter_timer >= max) begin
		counter_timer <= 32'b00;
			if ( periodo > 32'd18000 && periodo < 32'd23000) begin 
			color_detectado<=3'b100; 
			end
			
			else if( periodo > 32'd10400 && periodo < 32'd17900) begin 
			color_detectado<=3'b010; 
			end
			else begin 
			color_detectado<=3'b001; 
			end
		end
		else begin
		counter_timer <= counter_timer + 1;
		end
	end

endmodule
