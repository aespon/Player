extends ProgressBar

var maxEnergy = 200
var currentEnergy = maxEnergy

func _ready():
	max_value = maxEnergy
	value = maxEnergy

func decreaseEnergy(amount):
	currentEnergy -= amount
	currentEnergy = max(0, currentEnergy)
	value = currentEnergy

# Función para restablecer la energía
func resetEnergy():
	currentEnergy = maxEnergy
	value = maxEnergy

