import cosas.*

object camion {
	const property cosas = #{}
	var bultos = 0
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		bultos += unaCosa.bulto()
		unaCosa.consecuencia()	
	}
	method descargar(cosa) {
		cosas.remove(cosa)
		bultos -= 1 	
	}
	method todoPesoPar() {
		return self.cosas().all({ cosa => cosa.peso().even()})
	}
	method hayAlgunoQuePesa(peso) {
		return self.cosas().any({cosa => cosa.peso() == peso})
	}
	method elDeNivel(nivel) {
		return self.cosas().any({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	method pesoTotal() {
		var peso = 0
		const tara = 1000
		return tara + self.cosas().sum({cosa=> cosa.peso()})
	}
	method excedidoDePeso() {
		return self.pesoTotal() > 2500
	}
	method objetosQueSuperanPeligrosidad(nivel) {
		return self.cosas().filter({cosa=> cosa.nivelPeligrosidad() > nivel})
	}
	method objetosMasPeligrososQue(cosa) {
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
	}
	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not self.excedidoDePeso() && self.porDebajoDel(nivelMaximoPeligrosidad)		
	}
	method porDebajoDel(nivel) {
		return self.cosas().all{cosa => cosa.nivelPeligrosidad() <= nivel}
	}
	method tieneAlgoQuePesaEntre(min, max) {
		return self.losQuePesanMas(min) && self.losQuePesanMenos(max)   
	}
	method losQuePesanMenos(max) {
		return self.cosas().any({cosa=> cosa.peso() > max})
	}
	method losQuePesanMas(min) {
		return self.cosas().any({cosa=> cosa.peso() > min})
	}
	method cosaMasPesada() {
		return self.cosas().max{cosa => cosa.peso()}
	}
	method pesos(){
		return self.cosas().map{cosa => cosa.peso()}
	}
	method totalBultos(){
		return self.cosas(){cosa => cosa.bulto()}.sum()
	}

	method transportar() {
	  
	}
}
