program ecuacion;

function discriminante(a: float, b: float, c: float): float
{
	return (b ** 2.0) - (4.0 * a * c);
}

function parteimagi(a: float, b: float, c: float): float
{
	return sqrt(-(discriminante(a, b, c))) / (2.0 * a);
}

function solucdos(a: float, b: float, c: float): float
{
	return ((-b) - sqrt(discriminante(a, b, c))) / (2.0 * a);
}

function solucuno(a: float, b: float, c: float): float
{
	return ((-b) + sqrt(discriminante(a, b, c))) / (2.0 * a);
}

function solucunica(a: float, b: float): float
{
	return (-b) / (2.0 * a);
}

function esecsegundogrado(a: float): bool
{
	return a != 0.0;
}

consts:
	
	A = 3.0;
	
	B = 2.0;
	
	C = -5.0;

procedure main()
{
	if(not esecsegundogrado(A)){
		writeln("no es una ecuacion de segundo grado");
	}else if(discriminante(A, B, C) == 0.0){
		write("x = ");
		writeln(solucunica(A, B));
	}else if(discriminante(A, B, C) > 0.0){
		write("x1 = ");
		writeln(solucuno(A, B, C));
		write("x2= ");
		writeln(solucdos(A, B, C));
	}else{
		write("x1 = ");
		write(solucunica(A, B));
		write(" + ");
		write(parteimagi(A, B, C));
		writeln("i");
		write("x2 = ");
		write(solucunica(A, B));
		write(" - ");
		write(parteimagi(A, B, C));
		writeln("i");
	}
}
