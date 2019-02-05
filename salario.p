program salario;

consts:

	PorcentRangBajo = 10.0;

function gratificacion(letra: char): float
{
	switch(letra){
	case 'A', 'B', 'C':
		return 5000.0;
	case 'E'..'K':
		return 2000.0;
	default:
		return 0.0;
	}
}

function aumentosueldo(sueldo: float): float
{
	return sueldo * (PorcentRangBajo / 100.0);
}

function subidasueldoparcial(nif: int, letra: char, sueldo: float): float
{
	if(sueldo < 50000.0){
		return aumentosueldo(sueldo) + gratificacion(letra);
	}else if(sueldo >= 50000.0 and sueldo < 100000.0){
		return gratificacion(letra);
	}else{
		return 0.0;
	}
}

function descuento(nif: int, letra: char, sueldo: float): float
{
	if(subidasueldoparcial(nif,letra,sueldo) >= 3000.0 and nif % 2 != 0){
		return 3000.0;
	}else{
		return 0.0;
	}
}

function subidasueldofinal(nif: int, letra: char, sueldo: float): float
{
	return subidasueldoparcial(nif,letra,sueldo) - descuento(nif, letra, sueldo);
}

consts:

/* La letra debe estar en mayuscula */

	NIF = 00400005;
	
	Letra = 'A';
	
	Sueldo = 100000.0;

procedure main()
{
	write("subida de sueldo = ");
	writeln(subidasueldofinal(NIF, Letra, Sueldo));
}
