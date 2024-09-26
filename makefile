#makefile
syn:
# 1. Sintesis
	yosys -p "synth_ice40 -top top -json top.json" top.v
# 2. Place and route
	nextpnr-ice40 --hx4k --package tq144 --json top.json --pcf top.pcf --asc top.asc
# 3. Empaquetar en un bitstream
	icepack top.asc top.bin
config:
	stty -F /dev/ttyACM0 raw
	cat top.bin > /dev/ttyACM0

# filename: Makefile
# Identificador v para representar los archivos verilog
v=./sensor_finish.v
# Identificador top para representar el top del RTL a visualizar
top=top
# Identificador tb para el archivo verilog que contiene el testbench
tb=./sensor_finish_tb.v
# El identificador "MACRO_SIM" permite ajustar los valores de las diferentes definiciones del diseño
MACRO_SIM=-DPOS=5

sim:
	# 1. Crear el archivo .vvp ejecutable desde iverilog
	iverilog $(MACRO_SIM) -o $(tb).vvp $(tb)
	# 2. Ejecuta el archivo .vvp para mostrar resultados
	vvp $(tb).vvp -dumpfile=$(top).vcd

wave:
	gtkwave $(top).vcd $(top).gtkw

rtl:
	# 1. Síntesis del diseño, si la sintaxis es correcta, se genera un archivo json que representa el diseño
	yosys $(MACRO_SIM) -p 'read_verilog $v; prep -top $(top); hierarchy -check; proc; write_json $(top).json'
	# 2. Comando para generación del RTL en formato SVG (vectorial)
	netlistsvg $(top).json -o $(top).svg
	# 3. Visualizar el RTL con el visor de imagenes eog
	eog $(top).svg

clean:
	rm -f ∗.vvp ∗.json ∗.vcd ∗.pnr ∗.bin *.asc
