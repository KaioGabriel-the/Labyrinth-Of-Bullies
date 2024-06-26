extends Node

const SERCOMM = preload("res://addons/GDSerCommDock/bin/GDSerComm.gdns")
onready var PORT = SERCOMM.new()

onready var com = $Com

var port = ""
var baudRate = 9600
var message_to_receive = "";
var message_to_send
var axisXControl: float = 0.0;
var axisYControl: float = 0.0;
var buttonDown: int = 1;
var buttonLeft : int = 1;
var joystickButton : int = 1;

## Variável que comporta a mensagem acumulada proveniente do Esplora.
var msg = "";

func _ready():
	## Identifica sempre a ultima porta, entre as entradas
	port = PORT.list_ports()[-1]
	set_physics_process(false)
	PORT.close()
	if port!=null and baudRate!=0:
		PORT.open(port,baudRate,1000,com.bytesz.SER_BYTESZ_8, com.parity.SER_PAR_NONE, com.stopbyte.SER_STOPB_ONE)
		PORT.flush()
	else:
		print("Não foi possível estabelecer uma comunicação com a porta desejada. Cheque se a porta desejada foi selecionada corretamente.")
	set_physics_process(true)

func _physics_process(delta):
	if PORT != null && PORT.get_available()>0:
		## Se existir uma porta, identifica que o Esplora esta sendo usado
		Global.usingEsplora = true
		for i in range(PORT.get_available()): ## Analisa cada mensagem enviada pelo Esplora, caractere por caractere
			var _currentChar = str(PORT.read()); ## Ler a mensagem em forma de string
			if len(_currentChar) > 1:
				# Esperávamos chegar um caractere, mas chegou um código ascii.
				_currentChar = char(int(_currentChar)); # Convertamo-os portanto para CHAR.
			if _currentChar == "]": ## Quando a mensagem recebida for "]" a mensagem é encerrada e é enviada para a função
				resolveMessage(msg);
				msg = "";	# Mensagem volta a ficar vazia. Está pronta pra próxima.
			else:
				# Alimentar mensagem
				msg += _currentChar;
	else:
		## Se a porta for nula, identifica que o Esplora não esta sendo usado
		Global.usingEsplora = false;
		
			
func send_text():
	var text=message_to_send.text.replace("\n",com.endline)
	PORT.write(text) #write function, please use only ascii

func resolveMessage(msg):
	var breakMessage : Array = msg.split("#") ## A mensagem é quebrada no momento que tiver "#" no codigo, gerando uma nova string
	for message in breakMessage:
		var separateMessage  : Array = message.split(":")  ## A mensagem é quebrada no momento que tiver ":" no codigo, gerando uma nova string
		## Exemplo na ultima linha do código
		match separateMessage[0]:
			"sv":
				var _receivedValue = float(separateMessage[1]);
				if _receivedValue == clamp(_receivedValue, 0.0, 100.0):
					var _newSliderValue = _receivedValue;
					Global.sliderValueTo = _newSliderValue;
			"ax":
				axisXControl = float(separateMessage[1])
				axisXControl = clamp(axisXControl, -1.0, 1.0);
			"ay":
				axisYControl = float(separateMessage[1])
				axisYControl = clamp(axisYControl, -1.0, 1.0);
			"bd":
				buttonDown = int(separateMessage[1])
			"bl":
				buttonLeft = int(separateMessage[1])
			"jb":
				joystickButton = int(separateMessage[1])
			_:
				pass
				
			
#	# Fim da linha. Tratar mensagem.

## Exemplo: 
## [sv:30#bd:40]
## [sv:30, bd:40]
## [sv,30], [bd, 40]
## Dessa maneira pega o array 1, que sempre será o valor
