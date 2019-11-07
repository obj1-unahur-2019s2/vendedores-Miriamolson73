import centros.*
import provincias.*
import cuidades.*

class Vendedores {
/*	De cada vendedor, se tiene detalle de las *certificaciones* que posee.
Cada certificación otorga una cantidad de puntos. Algunas certificaciones son sobre productos, otras no. */
	var property dondeVive
	var property certificaciones=[]
	var property certificacionesProductos=[]
	method agregarCertificaciones(calificacion){
		certificaciones.add(calificacion)
	}
	
	method borrarCertificaciones(calificacion){
		certificaciones.remove(calificacion)
}

	method agregarCertificacionesProductos(calificacion){
		certificacionesProductos.add(calificacion)
	}
	method borrarCertificacion(calificacion){
		certificacionesProductos.remove(calificacion)
	}
	method vendedorInfluyente(){return false
		
	}
	method esFirme(){
		return self.cantidadDeCertificaciones() >= 30
	}
	//CERTIFICACIONES
    method cantidadDeCertificaciones(){return
    	self.cantidadCert()+ self.cantidadCertProducto()
    }
    method cantidadCert(){return self.certificaciones().size() }
    method cantidadCertProducto(){return self.cantidadCertProducto().size() }
    method esVendedorVersatil(){ return self.cantidadDeCertificaciones()>2 and self.cantidadCert()>1 and self.cantidadDeCertificaciones()!=self.cantidadCert()}
    method puedeTrabajarCiudad(ciudad){
    	return true
    }
    method tipoVendedor(){return "vendedor"}
    
}


class VendedorFijo inherits Vendedores{
 	override method tipoVendedor(){return "vendedorFijo"}	
	
  override  method puedeTrabajarCiudad(ciudad){
    	return self.dondeVive()==ciudad
    }
}  //fijo**: se sabe en qué ciudad vive.

class Viajante inherits Vendedores {
	var property provinciasHabilitadas=[]
	method agregarProvincia(provincia){
		provinciasHabilitadas.add(provincia)
	}
	method borrarProvincia(provincia){
		provinciasHabilitadas.remove(provincia)
		
	}
	override  method puedeTrabajarCiudad(ciudad){
    	return provinciasHabilitadas.any({prov=>prov==ciudad.provincia()    })
    }
    override method vendedorInfluyente(){return 
    	provinciasHabilitadas.sum({pro=>pro.poblacion()})>=10000000	}
	
	}
	
class ComercioCorresponsal inherits Vendedores {
	var property ubicacionSucursal=[]
	method agregarCiudad(sucursal){
		ubicacionSucursal.add(sucursal)
	}
	method borrarCiudad(sucursal){
		ubicacionSucursal.remove(sucursal)
		
	}
	override  method puedeTrabajarCiudad(ciudad){
    	return ubicacionSucursal.any({ciu=>ciu==ciudad})
    }
   override method vendedorInfluyente(){return self.influyenteCiudades() and self.influyenteProvincia()
		
	}
	method influyenteCiudades(){
		return ubicacionSucursal.size()>4
		
	}
	method influyenteProvincia(){return 
		ubicacionSucursal.map({ciu=>ciu.provincia()}).asSet().size()>3
	}
}
