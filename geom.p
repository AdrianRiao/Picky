/* 
 *	Programa para calcular areas,
 *	perimetros y figuras
 */

program FigurasDelPlano;

consts:

/* 
 *	Constantes universales y
 *	Constantes de prueba
 */
 
	NladCuad= 4.0;
	
	NladRomb= 4.0;
	
	LadCuad= 13.5;
	
	BasRectan= 3.0;
	
	AltRectan= 5.0;
	
	BasParal= 17.0;
	
	LadParal= 6.0;

	AltParal= 4.0;
	
	LadRomb= 5.0;
	
	DiagonalMay= 8.0;
	
	DiagonalMen= 6.0;
	
	LadIzqTrapec= 7.0;
	
	TapaTrapec= 5.89;
	
	LadDerTrapec= 7.35;
	
	BasTrapec= 13.2;
	
	AltTrapec= 2.4;
	
	AristOcta= 13.8;
	
	AristDodeca= 4.0;
	
	AristIcosa= 6.7;
	
/*
 *	Expresiones y formulas
 */
	
	AreaCuad= LadCuad ** 2.0;
	
	PeriCuad= LadCuad * NladCuad;
	
	AreaRectan= BasRectan * AltRectan;
	
	PeriRectan= 2.0 * BasRectan + 2.0 * AltRectan;
	
	AreaParal= BasParal * AltParal;
	
	PeriParal= 2.0 * BasParal + 2.0 * LadParal;
	
	AreaRomb= (DiagonalMay * DiagonalMen) / 2.0;
	
	PeriRomb= NladRomb * LadRomb;
	
	AreaTrapec= ( (BasTrapec + TapaTrapec) / 2.0) * AltTrapec;
	
	PeriTrapec= LadIzqTrapec + TapaTrapec + LadDerTrapec + BasTrapec;
	
	AreaOcta= 2.0 * sqrt(3.0) * AristOcta ** 2.0;
	
	AreaCaraOcta= (sqrt(3.0) / 4.0) * AristOcta ** 2.0;
	
	VolOcta= (sqrt(2.0) / 3.0) * AristOcta ** 3.0;
	
	AreaDodeca= 3.0 * sqrt(25.0 + (10.0 * sqrt(5.0) ) ) * AristDodeca ** 2.0;
	
	AreaCaraDodeca= (sqrt(25.0 + (10.0 * sqrt(5.0) ) ) / 4.0) * AristDodeca ** 2.0;
	
	VolDodeca= ( (15.0 + 7.0 * sqrt(5.0) ) / 4.0 ) * AristDodeca ** 3.0;
	
	AreaIcosa= 5.0 * sqrt(3.0) * AristIcosa ** 2.0;
	
	AreaCaraIcosa= ( sqrt(3.0) / 4.0 ) * AristIcosa ** 2.0;
	
	VolIcosa= (5.0 / 12.0) * (3.0 + sqrt(5.0)) * AristIcosa ** 3.0;
	
/*
 *	Verificacion medidas rombo
 */
 
	EsRombo= NladRomb * LadRomb ** 2.0 == DiagonalMen ** 2.0 + DiagonalMay ** 2.0;

procedure main()
{
	write("Area Cuadrado= ");
	writeln(AreaCuad);
	write("Perimetro Cuadrado= ");
	writeln(PeriCuad);
	writeeol();
	
	write("Area Rectangulo= ");
	writeln(AreaRectan);
	write("Perimetro Rectangulo= ");
	writeln(PeriRectan);
	writeeol();
	
	write("Area Paralelogramo= ");
	writeln(AreaParal);
	write("Perimetro Paralelogramo= ");
	writeln(PeriParal);
	writeeol();
	
	write("Area Rombo= ");
	writeln(AreaRomb);
	write("Perimetro Rombo= ");
	writeln(PeriRomb);
	write("Comprobacion= ");
	writeln(EsRombo);
	writeeol();
	
	write("Area Trapecio= ");
	writeln(AreaTrapec);
	write("Perimetro Trapecio= ");
	writeln(PeriTrapec);
	writeeol();
	
	write("Area Octaedro= ");
	writeln(AreaOcta);
	write("Area Cara Octaedro= ");
	writeln(AreaCaraOcta);
	write("Volumen Octaedro= ");
	writeln(VolOcta);
	writeeol();
	
	write("Area Dodecaedro= ");
	writeln(AreaDodeca);
	write("Area Cara Dodecaedro= ");
	writeln(AreaCaraDodeca);
	write("Volumen Dodecaedro= ");
	writeln(VolDodeca);
	writeeol();
	
	write("Area Icosaedro= ");
	writeln(AreaIcosa);
	write("Area Cara Icosaedro= ");
	writeln(AreaCaraIcosa);
	write("Volumen Icosaedro= ");
	writeln(VolIcosa);
	writeeol();
}
