import cosas.*

object camion {
	const property cosas = #{}
			
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.consecuencia()	
	}
	method descargar(cosa) {
		cosas.remove(cosa) }
	method cantDeBultos() {
		return self.cosas().sum({cosa => cosa.bulto()})
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
		return self.tara() + self.pesoDeLasCosas()
	}
	method tara() { return 1000 }
	
	method pesoDeLasCosas() {
		return self.cosas().sum({cosa=> cosa.peso()}) }

	method excedidoDePeso() {
		return self.pesoTotal() > self.pesoMaximo() }

	method pesoMaximo() { return 2500 }

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
		return self.cosas().any({cosa => cosa.peso().between(min, max)})
	}

	method cosaMasPesada() {
		return self.cosas().max{cosa => cosa.peso()}
	}
	method pesos(){
		return self.cosas().map{cosa => cosa.peso()}
	}
	method totalBultos(){
		return self.cosas().map{cosa => cosa.bulto()}.sum()
	}
 	method transportar(destino, camino) {
		
		if( self.puedoTransportar(destino, camino)) {

		} else {

		}

 	}
	
	method puedoTransportar(destino, camino) {
		return if(self.excedidoDePeso()) {
 					self.noPuedeTransportarse() 
 				} else if(destino.hayLugar() >= self.totalBultos()) {
 					destino.descargo(self) 
 				}

	}


 	method noPuedeTransportarse() {
 		return	"El transporte no es posible realizar lo"
 	} 
}