program volumen;

consts:
	
	Pi = 3.1415926;

function apotema(longlad: float, nlad: int): float
{
	return (longlad / 2.0) * tan( (Pi * (float(nlad) - 2.0)) / (2.0 * float(nlad)) );
}

function areatriang(longlad: float, nlad: int): float
{
	return (longlad * apotema(longlad, nlad)) / 2.0;
}

function areabase(longlad: float, nlad: int): float
{
	/* 
	* areatriang es el area de los triangulos
	* inscritos en el poligono regular
	*/

	return areatriang(longlad, nlad) * float(nlad);
}

function volpiram(longlad: float, nlad: int, hpiram: float): float
{
	return (areabase(longlad, nlad) * hpiram) / 3.0;
}

function volprism(longlad: float, nlad: int, hprism: float): float
{
	return areabase(longlad, nlad) * hprism;
}

function volfigura(longlad: float, nlad: int, hprism: float, hpiram: float): float
{
	return volprism(longlad, nlad, hprism) + 2.0 * volpiram(longlad, nlad, hpiram);
}

consts:

	/*
	 * NladPolig debe ser un numero
	 * entero, es decir, un int.
	 */

	LongLadPolig = 5.0;
	
	NladPolig = 4;
	
	AltPrism = 8.0;
	
	AltPiram = 4.0;

procedure main()
{
	writeln(volfigura(LongLadPolig, NladPolig, AltPrism, AltPiram));
}
