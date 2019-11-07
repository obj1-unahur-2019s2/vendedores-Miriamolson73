
class CentroDeDistribucion {
	var property vendedores=[]
	var property ciudad
	
	method agregarVendedores(vendedor){
		if (not self.sePuedeAgregar(vendedor))
			vendedores.add(vendedor)
		else self.error("ya se encuentra registrado")	
	}
	method borrarVendedores(vendedor){
		vendedores.remove(vendedor)
	}
	
	method sePuedeAgregar(vendedor){return
		vendedores.contains(vendedor)
	}
    method vendedorEstrella(){ return 
    	vendedores.max({cer=>cer.cantidadDeCertificaciones()})
    }
    method sePuedeCubrir(){return 
    	vendedores.any({vende=>vende.puedeTrabajarCiudad(ciudad)})
    }
    method vendedoresGenericos(){return 
    	vendedores.filter({vende=>vende.cantidadcCert()>0})
    }
    method esRobusto(){return 
    	vendedores.count({vende=>vende.esFirme()})>2
    }
    method agregarCertificaciones(cantidad,tipo){
    	if (tipo=="producto"){
    		vendedores.forEach({vende=>vende.agregarCertificacionesProductos(cantidad)})
    	    		}
    	else {vendedores.forEach({vende=>vende.agregarCertificacion(cantidad)})}
    	
    }
    method tieneAfinidad(){
    	vendedores.filter({vende=>vende.puedeTrabajar(self.ciudad())})
    }
}
