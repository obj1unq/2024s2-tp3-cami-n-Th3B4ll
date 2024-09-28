import camion.*
object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bulto() { return 1 }
	method consecuencia() {}
}

object bumblebee {
	var property forma = auto
	method peso() { return 800 }
	method nivelPeligrosidad() { return forma.nivelPeligrosidad() }
	method bulto() { return 2 }
	method consecuencia() {self.forma(robot)}

}
object auto { method nivelPeligrosidad() = 15 }
object robot { method nivelPeligrosidad() = 30 }

object paqueteLadrillos {
	var property cantidad = 0
	method peso() { return 2 * self.cantidad() }
	method nivelPeligrosidad() { return 2 }
	method bulto() { return self.valorBulto(self.cantidad()) }
	method valorBulto(_cantidad) {
		return if(_cantidad <= 100) 1 else if(_cantidad < 300) 2 else 3 }
	method consecuencia() { cantidad += 12}
}


object arena {
	var property kilos = 0
	method peso() { return self.kilos() }
	method nivelPeligrosidad() { return 1 }
	method bulto() { return 1 }
	method consecuencia() { kilos += 20}
}

object bateriaAntiaerea {
	var property armamento = otraMunicion

	method peso() { 
		return armamento.peso() 
	}
	method nivelPeligrosidad() { 
		return armamento.peligrosidad() 
	}
	method bulto() { return armamento.valorBulto() }
	method consecuencia() { self.armamento(misiles)}
}
object misiles {
	method peso() { return 300 }
	method peligrosidad() { return 100 }
	method valorBulto() {return 2}
}

object otraMunicion {
	method peso() { return 200 }
	method peligrosidad() { return 0 }
	method valorBulto() {return 1}  
}

object contenedor {
	const property cosas = #{}

	method peso() { 
		return 100 + self.pesoDelContenido() 
	}
	method nivelPeligrosidad() { 
		return if(self.estaVacio()) 0 else self.elMasPeligroso()  
	}
	method elMasPeligroso() {
		return self.cosas().map{cosa => cosa}.max()
	}
	method pesoDelContenido() {
		return self.cosas(){cosa => cosa.peso()}.sum()
	}
	method estaVacio() {
		return cosas.isEmpty()
	}
	method bulto() { return 1 + self.cosas().size() }
	method consecuencia() { self.cosas(){cosa => cosa.consecuencia()} }
}

object residuosRadioactivos {
	var property peso = 0
	method nivelPeligrosidad() { return 200 }
	method bulto() { return 1 }
	method consecuencia(){ peso += peso 15}
}

class Embalaje {

}
object embalajeDeSeguridad {
	var cosa = residuosRadioactivos
	method cosaParaEmbalar(_cosa){
		cosa = _cosa
	}
	method peso() { return cosa.peso() }

	method nivelPeligrosidad() { return cosa.nivelPeligrosidad() / 2 }
	method bulto() { return 2 }
	method consecuencia(){}
}

object almacen {
	const capMax = 3
	const property stock = #{}

	method descargo(camion) {
			if(self.hayLugar(camion)) {
				camion.cosas().forEach({cosa => self.descargarCamion(cosa)})
				camion.cosas().clear()
			}
	}

	method descargarCamion(cosa) {
		self.stock().add(cosa) }

	method hayLugar(camion) {
		//return self.stock().map{cosa => cosa.bulto()}.sum() <= 
		return camion.cosas().map{cosa => cosa.bulto()}.sum() <= self.cantDisponibles() }

	method cantDisponibles() {
		return capMax - self.stock().size() }

}

object ruta9 {
	method pesoSoportado() { return self.pesoMaximo()}
	method nivelPeligrosidad(){return 11}  
	method pesoMaximo() { return 2500 }
}
object caminosVecinales {
	method pesoSoportado() { return self.pesoMaximo()}
	method nivelPeligrosidad(){ return 0}
	method pesoMaximo() { return 2500 }
}