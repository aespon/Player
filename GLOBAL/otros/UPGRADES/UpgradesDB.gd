extends Node

const  ICON_PATH = "res://GLOBAL/otros/UPGRADES/UPGRADES_ICONS/"
const UPGRADE_DB = {
	"revivir" : {
		"icon" : ICON_PATH + "revivir.png",
		"displayname" : "CRYSTAL REBIRTH",
		"details" : "Al cargar con este item al sufrir daño mortal revives con una fracción de tu vida en el lugar de muerte, tras su uso el ítem se pierde",
		"level" : "",
		"prerequisite": [],
		"type" : "efecto"
		},
	"speedboost" : {
		"icon" : ICON_PATH + "speedboost.png",
		"displayname" : "CRYSTAL SPEED",
		"details" : "Al cargar con este item al entrar a una habitación tienes una probabilidad del 50 % de ir un 25 % más rápido",
		"level" : "",
		"prerequisite": [],
		"type" : "efecto"
		},
	"vampirismo" : {
		"icon" : ICON_PATH + "vampirismo.png",
		"displayname" : "CRIMSOM CRYSTAL",
		"details" : "Al cargar con este item al matar enemigos tienes un 20% de posibilidad de obtener un item de curación",
		"level" : "",
		"prerequisite": [],
		"type" : "efecto"
		},
	"armadura" : {
		"icon" : ICON_PATH + "armadura.png",
		"displayname" : "LIFEHOOD CRYSTAL",
		"details" : "Al cargar con este item al comenzar la partida obtienes resistencia",
		"level" : "",
		"prerequisite": [],
		"type" : "efecto"
		},
	"aumento de vida 1" : {
		"icon" : ICON_PATH + "aumentovida.png",
		"displayname" : "LIFE CRYSTAL",
		"details" : "Al cargar con este item obtienes 10% más de vida máxima",
		"level" : "LEVEL : 1",
		"prerequisite": [],
		"type" : "estadistica"
	},
	"aumento de vida 2" : {
		"icon" : ICON_PATH + "aumentovida.png",
		"displayname" : "LIFE CRYSTAL",
		"details" : "Al cargar con este item obtienes 10% más de vida máxima",
		"level" : "LEVEL : 2",
		"prerequisite": ["aumento de vida 1"],
		"type" : "estadistica"
	},
	"aumento de vida 3" : {
		"icon" : ICON_PATH + "aumentovida.png",
		"displayname" : "LIFE CRYSTAL",
		"details" : "Al cargar con este item obtienes 10% más de vida máxima",
		"level" : "LEVEL : 3",
		"prerequisite": ["aumento de vida 2"],
		"type" : "estadistica"
	},
	"aumento de daño mele 1" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTALIZED PUNCH",
		"details" : "Al cargar con este item obtienes 10% más de ataque mele",
		"level" : "LEVEL : 1",
		"prerequisite": [],
		"type" : "estadistica"
	},
	"aumento de daño mele 2" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTALIZED PUNCH",
		"details" : "Al cargar con este item obtienes 10% más de ataque mele",
		"level" : "LEVEL : 2",
		"prerequisite": ["aumento de daño mele 1"],
		"type" : "estadistica"
	},
	"aumento de daño mele 3" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTALIZED PUNCH",
		"details" : "Al cargar con este item obtienes 10% más de ataque mele",
		"level" : "LEVEL : 3",
		"prerequisite": ["aumento de daño mele 2"],
		"type" : "estadistica"
	},
	"aumento de daño shoot 1" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTALIZED MISSILE",
		"details" : "Al cargar con este item obtienes 10% más de ataque a distancia",
		"level" : "LEVEL : 1",
		"prerequisite": [],
		"type" : "estadistica"
	},
	"aumento de daño shoot 2" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTALIZED MISSILE",
		"details" : "Al cargar con este item obtienes 10% más de ataque a distancia",
		"level" : "LEVEL : 1",
		"prerequisite": ["aumento de daño shoot 1"],
		"type" : "estadistica"
	},
	"moreexp" : {
		"icon" : ICON_PATH + "aumentomele.png",
		"displayname" : "CRYSTAL EXPERIENCE",
		"details" : "Al entrar a una habitacion tienes un 20% de posibilidad ganar 100 puntos de experiencia",
		"level" : "",
		"prerequisite": [],
		"type" : "other"
	}
}

var player_upgrades = []

