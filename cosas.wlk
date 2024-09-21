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
	var bodega = #{}
	method descargo(cosas) {
		if(cosas.map{cosa => cosa.bulto()}.sum() <= self.lugaresLibres())
			bodega.addAll(cosas)
			camion.cosas().clear()
	}
/*	method lugaresLibres() {
		return if(hayLugar()) cosas.{cosa => cosa.bulto()}.sum() 
				else self.noPuedeTransportarse()
				
	} */
/*	method hayLugar() {*/
/*		return size(bodega) < 3*/
/*	}*/
/*		return (size(bodega) < 3)
	method hayLugar() {
	}*/
}

object ruta9 {
	const pesoSoportado = 2500
	method nivelDePeligrosidad(){return 11}  
}
object caminosVecinales {
	var property pesoSoportado = 2500

	method nivDePeligrosidad(){ return 0}
}