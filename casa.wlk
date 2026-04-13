object casa {
    var montoTotalGastado = 0
    var cuenta = cuentaCorriente

    method montoTotalGastado() = montoTotalGastado

    method cambioMes() {
      montoTotalGastado = 0
    }

    method cuenta(_cuenta) {
      cuenta = _cuenta
    }

    method gastar(monto) {
        cuenta.extraer(monto)
        montoTotalGastado = montoTotalGastado + monto
    }
}

object cuentaCorriente {
    var saldo = 300

    method saldo() = saldo

    method saldo(_saldo) {
        saldo = _saldo
    } 

    method depositar(monto) {
      saldo = saldo + monto
    }

    method extraer(monto) { //polimorfismo
      saldo = saldo - monto
    }
}

object cuentaConGastos {
    var saldo = 0
    var costoPorOperacion = 20

    method costoPorOperacion(_costoPorOperacion) {
      costoPorOperacion = _costoPorOperacion
    }

    method saldo() = saldo

    method saldo(_saldo) {
        saldo = _saldo
    } 

    method depositar(monto) {
        saldo = saldo + monto - costoPorOperacion 
    }

    method extraer(monto) { //polimorfismo
        self.validarFondo(monto)
        saldo = saldo - monto
    }

    method validarFondo(monto) {
      if (not self.puedeExtraer(monto)) {
        self.error("fondos insuficientes para extraer de cuenta con gastos")
      }
    }

    method puedeExtraer(monto) {
        return saldo >= costoPorOperacion
    }
}

object cuentaCombinada {
    var cuentaPrimaria = cuentaCorriente
    var cuentaSecundaria = cuentaConGastos
    //var saldoCombinado = self.combinarSaldo()

    method sonSaldosPositivos() { //solo sumo saldos positivos
       return 0.max(cuentaPrimaria.saldo()) + 0.max(cuentaSecundaria.saldo()) == 0
    }

    method cuentaPrimaria(_cuentaPrimaria) {
        cuentaPrimaria = _cuentaPrimaria
    }

    method cuentaSecundaria(_cuentaSecundaria) {
        cuentaSecundaria = _cuentaSecundaria
    }

    method depositar(monto) {
        cuentaPrimaria.depositar(monto)
    }

    method extraer(monto) {
        //validarFondos()
        if (monto < saldoCombinado) {
            const montoMenosPrimario = monto - cuentaPrimaria.saldo()
            cuentaPrimaria.extraer(cuentaPrimaria.saldo())
            cuentaSecundaria.extraer(montoMenosPrimario)
        } else {

            
        }
    }

}