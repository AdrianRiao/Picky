program scrabble;

consts:

	Espacio = ' ';
	
	Tabulador = '	';
	
	Arroba = '@';
	
	MinColmn = 'A';
	
	MaxColmn = 'O';
	
	MinFila = 1;
	
	MaxFila = 15;
	
	MaxEntradas = 500;
	
	PalabraDoble = "Doble";
	
	PalabraTriple = "Triple";
	
types:

	TipoPtrColaChar = ^TipoNodoColaChar;
	
	TipoNodoColaChar = record
	{
		caract: char;
		siguiente: TipoPtrColaChar;
	};
	
	TipoEntrada = record
	{
		primero: TipoPtrColaChar;
		ultimo: TipoPtrColaChar;
	};
	
	TipoCoords = record
	{
		c1: char;
		c2: int;
	};
	
	TipoJugadores = char;
	
	TipoCasillaEsp = record
	{
		valor: TipoEntrada;
		coords: TipoCoords;
	};
	
	TipoCasilla = record
	{
		slot1: char;
		slot2: TipoEntrada;
	};
	
	TipoFila = array[MinColmn..MaxColmn] of TipoCasilla;
	
	TipoTablero = array[MinFila..MaxFila] of TipoFila;
	
	TipoJuego = record
	{
		jugadores: TipoJugadores;
		tablero: TipoTablero;
	};

function eseof(c: char): bool
{
	return c == Eof;
}

function eseol(c: char): bool
{
	return c == Eol;
}

function esarroba(c: char): bool
{
	return c == Arroba;
}

function esblanco(c: char): bool
{
	return (c == Espacio) or (c == Tabulador);
}

function escaract(c: char): bool
{
	return not esblanco(c) and not eseol(c) and not eseof(c);
}

function estriple(entrada: TipoEntrada): bool
	pnodo: TipoPtrColaChar;
	secumple: bool;
	i: int;
{
	secumple = True;
	i = 0;
	do{
		pnodo = entrada.primero;
		if(pnodo^.caract != PalabraTriple[i]){
			secumple = False;
		}
		i = i + 1;
	}while(pnodo != nil and i < len PalabraTriple);
	
	return secumple;
}

function esdoble(entrada: TipoEntrada): bool
	pnodo: TipoPtrColaChar;
	secumple: bool;
	i: int;
{
	secumple = True;
	i = 0;
	do{
		pnodo = entrada.primero;
		if(pnodo^.caract != PalabraDoble[i]){
			secumple = False;
		}
		i = i + 1;
	}while(pnodo != nil and i < len PalabraDoble);
	
	return secumple;
}

procedure saltarlinea()
{
	readeol();
}

procedure saltarblanco()
	c: char;
{
	read(c);
}

procedure saltarblancos()
	c: char;
{
	do{
		peek(c);
		if(esblanco(c)){
			saltarblanco();	
		}else if(eseol(c)){
			saltarlinea();
		}
	}while(esblanco(c) or eseol(c));
}

procedure inicslot2(ref slot2: TipoEntrada)
{
	slot2.primero = nil;
	slot2.ultimo = nil;
}

procedure iniccasilla(ref casilla: TipoCasilla)
{
	casilla.slot1 = Espacio;
	inicslot2(casilla.slot2);
}

procedure inicfila(ref fila: TipoFila)
	i: char;
{
	for(i = MinColmn, i <= MaxColmn){
		iniccasilla(fila[i]);
	}
}

procedure inictablero(ref tab: TipoTablero)
	i: int;
{
	for(i = MinFila, i <= MaxFila){
		inicfila(tab[i]);
	}
}

procedure liberarcola(ref entrada: TipoEntrada)
	pnodo: TipoPtrColaChar;
{
	do{
		pnodo = entrada.primero;
		if(pnodo != nil){
			entrada.primero = pnodo^.siguiente;
			dispose(pnodo);
		}
	}while(pnodo != nil);
	entrada.ultimo = entrada.primero;
			
}

procedure guardarnodo(ref puntero: TipoEntrada, pnodo: TipoPtrColaChar)
{
	if(puntero.primero == nil){
		puntero.primero = pnodo;
	}else{
		puntero.ultimo^.siguiente = pnodo;
	}
	puntero.ultimo = pnodo;
}

procedure copiarcolas(cola1: TipoEntrada,ref cola2: TipoEntrada)

/* Duplica la cola1 a la cola2 */

	pnodo1: TipoPtrColaChar;
	pnodo2: TipoPtrColaChar;
{
	pnodo1 = cola1.primero;
	while(pnodo1 != nil){
		new(pnodo2);
		pnodo2^.caract = pnodo1^.caract;
		pnodo2^.siguiente = nil;
		guardarnodo(cola2, pnodo2);
		pnodo1 = pnodo1^.siguiente;
	}
}

procedure guardarcolumn(entrada: TipoEntrada, ref coords: TipoCoords)
{
	;
}

procedure guardarvalor(entrada: TipoEntrada, ref valor: TipoEntrada)
{
	if(esdoble(entrada) or estriple(entrada)){
		copiarcolas(entrada, valor);
	}else{
		writeln("Entrada invalida.");
	}
}

procedure guardarchar(ref entrada: TipoEntrada, c: char)
	pnodo: TipoPtrColaChar;
{
	new(pnodo);
	pnodo^.caract = c;
	pnodo^.siguiente = nil;
	guardarnodo(entrada, pnodo);
}

procedure leerentrada(ref entrada: TipoEntrada)
	c: char;
	caract1: bool;
{
	caract1 = True;
	if(caract1){
		read(c);
		guardarchar(entrada, c);
		caract1 = False;
	}else{
		do{
			peek(c);
			if(escaract(c)){
			   read(c);		   
			   guardarchar(entrada, c);
			}
		}while(escaract(c));
	}
}

procedure leercasillaesp(ref casillaesp: TipoCasillaEsp)
	c: char;
	entrada: TipoEntrada;
	valorleido: bool;
	columnleida: bool;
	filaleida: bool;
{
	valorleido = False;
	columnleida = False;
	filaleida = False;
	do{
		saltarblancos();
		peek(c);
		
		if(escaract(c)){
			leerentrada(entrada);
			if(not valorleido){
				guardarvalor(entrada, casillaesp.valor);
				valorleido = True;
			}else if(not columnleida){
				guardarcolumn(entrada, casillaesp.coords);
				columnleida = True;
			}else if(not filaleida){
				guardarfila(entrada, casillaesp.coords);
				filaleida = True;
			}
			liberarcola(entrada);
		}
		
	}while(not filaleida);
}

procedure imprimresult(juego: TipoJuego)
{
	;
}

procedure jugar(ref juego: TipoJuego)
{
	;
}

procedure leertablero(ref tab: TipoTablero)
	c: char;
	i: int;
	casillaesp: TipoCasillaEsp;
{
	do{
		saltarblancos();
		peek(c);
		if(esarroba(c) or eseof(c)){
			writeln("No ha habido jugadas.");
		}else{
			leercasillaesp(casillaesp);
			if(casillaespok(casillaesp)){
				guardarcasillaesp(tab, casillaesp);
			}
		}
	}while(not esarroba(c) and not eseof(c));
}

procedure main()
	juego: TipoJuego;
{
	leertablero(juego.tablero);
	jugar(juego);
	imprimresult(juego);
}
