program solitario;

consts:

	PosicionBasta = 5;
	
types:

	TipoLinea1 = (Oros, Bastos, Copas, Espadas, Basta);
	TipoPalo = TipoLinea1 Oros..Espadas;
	TipoNumero = int 1..9;
	TipoColor = (Roja, Verde);
	TipoCarta = record
	{
		palo: TipoPalo;
		num: TipoNumero;
		colour: TipoColor;
	};

function espar(n: int): bool
{
	return n % 2 == 0;
}

procedure sumarnumimpar(c: TipoCarta, ref valorcarta: int)
	i: int;
	suma: int;
{
	suma = 0;
	for(i = 1, i <= c.num){
		if(not espar(i)){
			suma = suma + i;
		}
	}
	valorcarta = suma;
}

procedure sumarnumpar(c: TipoCarta, ref valorcarta: int)
	i: int;
	suma: int;
{
	suma = 0;
	for(i = 1, i <= c.num){
		if(espar(i)){
			suma = suma + i;
		}
	}
	valorcarta = suma;
}

procedure calcularvalor(c: TipoCarta, ref valorcarta: int)
{
	if(c.palo == Oros or c.palo == Copas){
		sumarnumpar(c, valorcarta);
	}else{
		sumarnumimpar(c, valorcarta);
	}
}

procedure asignarcolor1(ref i: bool, colour: TipoColor, ref color1: TipoColor)
{
	if(i){
		color1 = colour;
		i = False;
	}
}

function nuevacarta(palo: TipoPalo, num: TipoNumero, colour: TipoColor): TipoCarta
	c: TipoCarta;
{
	c.palo = palo;
	c.num = num;
	c.colour = colour;
	return c;
}

procedure leercarta(linea1: TipoLinea1, ref palo: TipoPalo, ref num: TipoNumero,
					ref colour: TipoColor)
{
	palo = linea1;
	readln(num);
	readln(colour);
}

function esbasta(palabra: TipoLinea1): bool
{
	return palabra == Basta;
}

procedure main()
	linea1: TipoLinea1;
	palo: TipoPalo;
	num: TipoNumero;
	colour: TipoColor;
	carta: TipoCarta;
	color1: TipoColor; /* Es el color de la primera carta*/
	valorcarta: int;
	total: int;
	i: bool;
{
	total = 0;
	i = True;
	do{
		readln(linea1);
		if(not esbasta(linea1)){
			leercarta(linea1, palo, num, colour);
			carta = nuevacarta(palo, num, colour);
			asignarcolor1(i, colour, color1);
			if(color1 == colour){
				calcularvalor(carta, valorcarta);
				total = total + valorcarta;
			}
		}
	}while(not esbasta(linea1));
	writeln(total);
}
