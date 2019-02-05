program scrabble;

consts:
	
	NJugadores = 2;
	
	MaxJugadas = 50; /* Max numero de jugadas por jugador */
	
	MinColmn = 'A';
	
	MaxColmn = 'O';
	
	MinFila = 1;
	
	MaxFila = 15;
	
	LetraIMinus = 'a'; /*
						* Es la letra inicial del 
						* abecedario en minuscula
						*/

	LetraFMinus = 'z'; /*
						* Es la letra final del 
						* abecedario en minuscula
						*/

	MaxNLetras = 20; /* Max numero de letras por palabra */
	
	Blanco = ' ';
	
	Arroba = '@';
	
	Almohadilla = '#';
	
	LetraEMinus = 'e';

types:

	TipoOrient = (derecha, abajo);
	
	TipoCoords = record
	{
		c1: char;
		c2: int;
	};
	
	TipoCaracts = array[0..MaxNLetras] of char;
	
	TipoPalabra = record
	{
		caracts: TipoCaracts;
		long: int;
	};
	
	TipoJugada = record
	{
		palabra: TipoPalabra;
		coords: TipoCoords;
		orient: TipoOrient;
		ok: bool;
		punt: int;
	};
	
	TipoJugadas = array[0..MaxJugadas-1] of TipoJugada;
	
	TipoJugador = record
	{
		jugadas: TipoJugadas;
		njugadas: int;
		punt: int;
	};
	
	TipoJugadores = array[0..NJugadores-1] of TipoJugador;
	
	TipoSlot2 = (Doble, Triple, Vacio);
	
	TipoValor = TipoSlot2 Doble..Triple;
	
	TipoCasillaEsp = record
	{
		valor: TipoValor;
		coords: TipoCoords;
	};
	
	TipoCasilla = record
	{
		slot1: char;
		slot2: TipoSlot2;
	};
	
	TipoFila = array[MinColmn..MaxColmn] of TipoCasilla;
	
	TipoTablero = array[MinFila..MaxFila] of TipoFila;
	
	TipoJuego = record
	{
		tablero: TipoTablero;
		jugadores: TipoJugadores;
	};

function sumafilas(f1: int, f2: int): int
{
	return f1 + f2;
}

function diferenfilas(f1: int, f2: int): int
{
	return f2 - f1;
}

function sumacolmns(c1: char, c2: char): int
{
	return int(c1) + int(c2);
}

function diferencolmns(c1: char, c2: char): int
{
	return int(c2) - int(c1);
}

function mitadfilas(f1: int, f2: int): int
{
	return f1 + 
		   (((diferenfilas(f1, f2) + 1)/2)-1);
}

function mediafilas(f1: int, f2: int): int
{
	return sumafilas(f1, f2) / 2;
}

function mitadcolmns(c1: char, c2:char): char
{
	return char(int(c1) + 
			   ((diferencolmns(c1, c2)+1)/2)-1);
}

function mediacolmns(c1: char, c2: char): char
{
	return char(sumacolmns(c1, c2) / 2);
}

function filasimpares(f1: int, f2: int): bool
{
	return (diferenfilas(f1, f2) + 1)%2 != 0;
}

function colmnsimpares(c1: char, c2: char): bool
{
	return (diferencolmns(c1,c2) + 1)%2 != 0;
}

function filacentral(f1: int, f2: int): int
{
	if(filasimpares(f1, f2)){
		return mediafilas(f1, f2);
	}else{
		return mitadfilas(f1, f2);
	}
}

function colmncentral(c1: char, c2: char): char
{
	if(colmnsimpares(c1, c2)){
		return mediacolmns(c1, c2);
	}else{
		return mitadcolmns(c1, c2);
	}
}

procedure iniccoordscc(ref coords: TipoCoords)
	f1: int;
	f2: int;
	c1: char;
	c2: char;
{
	f1 = MinFila;
	f2 = MaxFila;
	c1 = MinColmn;
	c2 = MaxColmn;
	coords.c1 = colmncentral(c1, c2);
	coords.c2 = filacentral(f1, f2);
}

procedure iniclongpalabra(ref long: int)
{
	long = 0;
}

procedure inicjugada(ref jugada: TipoJugada)
{
	jugada.ok = False;
	jugada.punt = 0;
}

procedure inicjugadas(ref jugadas: TipoJugadas)
	i: int;
{
	for(i = 0, i < MaxJugadas){
		inicjugada(jugadas[i]);
	}
}
procedure inicnjugador(ref jugador: TipoJugador)
{
	jugador.njugadas = 0;
	jugador.punt = 0;
	inicjugadas(jugador.jugadas);
}

procedure inicjugadores(ref jugadores: TipoJugadores)
	i: int;
{
	for(i = 0, i < NJugadores){
		inicnjugador(jugadores[i]);
	}
}

procedure iniccasilla(ref casilla: TipoCasilla)
{
	casilla.slot1 = Blanco;
	casilla.slot2 = Vacio;
}

procedure inicfila(ref fila: TipoFila)
	i: char;
{
	for(i = MinColmn, i <= MaxColmn){
		iniccasilla(fila[i]);
	}
}

procedure inictablero(ref tablero: TipoTablero)
	i: int;
{
	for(i = MinFila, i <= MaxFila){
		inicfila(tablero[i]);
	}
}

procedure triplicarpunt(ref puntos: int)
{
	puntos = puntos*3;
}

procedure doblarpunt(ref puntos: int)
{
	puntos = puntos*2;
}

function esarroba(c: char): bool
{
	return c == Arroba;
}

function esalmohadilla(c: char): bool
{
	return c == Almohadilla;
}

function escaracter(c: char): bool
{
	return c != Eol and c != Eof;
}

function c1(coords: TipoCoords): char
{
	return coords.c1;
}

function c2(coords: TipoCoords): int
{
	return coords.c2;
}

function njugadas(jugador: TipoJugador): int
{
	return jugador.njugadas;
}

function puntjugador(jugador: TipoJugador): int
{
	return jugador.punt;
}

function puntjugada(jugada: TipoJugada): int
{
	return jugada.punt;
}

function hayjugadas(jugadores: TipoJugadores): bool
{
	return njugadas(jugadores[0]) != 0;
}

function escasillatriple(tablero: TipoTablero,
						 c1: char,
						 c2: int): bool
	fila: TipoFila;
	casilla: TipoCasilla;
{
	fila = tablero[c2];
	casilla = fila[c1];
	return casilla.slot2 == Triple;
}

function escasilladoble(tablero: TipoTablero,
						c1: char,
						c2: int): bool
	fila: TipoFila;
	casilla: TipoCasilla;
{
	fila = tablero[c2];
	casilla = fila[c1];
	return casilla.slot2 == Doble;
}

function casillavacia(tablero: TipoTablero, 
					  c1: char, 
					  c2: int): bool
	fila: TipoFila;
	casilla: TipoCasilla;
{
	fila = tablero[c2];
	casilla = fila[c1];
	return casilla.slot1 == Blanco;
}

function slot2vacio(tablero: TipoTablero, 
					coords: TipoCoords): bool
	fila: TipoFila;
	casilla: TipoCasilla;
{
	fila = tablero[coords.c2];
	casilla = fila[coords.c1];
	return casilla.slot2 == Vacio;
}

function coincidenletras(tablero: TipoTablero,
						 c1: char,
						 c2: int,
						 palabra: TipoPalabra,
						 i: int): bool
	fila: TipoFila;
	casilla: TipoCasilla;
{
	fila = tablero[c2];
	casilla = fila[c1];
	return casilla.slot1 == palabra.caracts[i];
}

function casillasvacias(tablero: TipoTablero): bool
	secumple: bool;
	i: int;
	j: char;
{
	secumple = True;
	i = MinFila;
	j = MinColmn;
	do{
		do{
			if(not casillavacia(tablero, j, i)){
				secumple = False;
			}
			j = char(int(j) + 1);
		}while(secumple and j <= MaxColmn);
		j = MinColmn;
		i = i + 1;
	}while(secumple and i <= MaxFila);
	
	return secumple;
}

function tablerovacio(tablero: TipoTablero): bool
{
	return casillasvacias(tablero);
}

function esprimerapalabra(tablero: TipoTablero): bool
{
	return tablerovacio(tablero);
}

function c1entablero(c1: char): bool
{
	return MinColmn <= c1 and c1 <= MaxColmn;
}

function c2entablero(c2: int): bool
{
	return MinFila <= c2 and c2 <= MaxFila;
}

function coordsentablero(coords: TipoCoords): bool
{
	return c2entablero(coords.c2) and
		   c1entablero(coords.c1);
}

function casillaespok(tablero: TipoTablero,
					  casillaesp: TipoCasillaEsp): bool
	secumple: bool;
{
	secumple = False;
	if(coordsentablero(casillaesp.coords) and
	   slot2vacio(tablero, casillaesp.coords)){
		secumple = True;
	}

	return secumple;
}

function longpalabra(palabra: TipoPalabra): int
{
	return palabra.long;
}

function esletraminus(c: char): bool
{
	return LetraIMinus <= c and c <= LetraFMinus;
}

function coincidencoords(c1: char, c2: int,
						 c3: char, c4: int): bool

/*
 * c1 y c2 pertenecen al mismo grupo de
 * coords, al igual que c3 y c4.
 */
 
{
	return c1 == c3 and c2 == c4;
}

function condicion5(tablero: TipoTablero, jugada: TipoJugada): bool

/*
 * ¿La palabra tiene al menos 
 * una letra concidente con una
 * ya puesta en el tablero?
 */

	secumple: bool;
	i: int;
{
	secumple = False;
	i = 0;
	do{
		if(jugada.orient == abajo){
			secumple = coincidenletras(tablero, 
									   c1(jugada.coords), 
									   c2(jugada.coords)+i, 
								       jugada.palabra,
								       i);
		}else{
			secumple = coincidenletras(tablero, 
									   char(int(c1(jugada.coords))+i), 
								       c2(jugada.coords), 
									   jugada.palabra,
								       i);
		}
		i = i + 1;
	}while(not secumple and i < longpalabra(jugada.palabra));
	
	return secumple;
}

function condicion4(jugada: TipoJugada): bool

/*
 * ¿Ocupa la casilla central
 * con cualquiera de sus letras?
 */

	secumple: bool;
	i: int;
	coordscc: TipoCoords; /* Coords casilla central */
{
	iniccoordscc(coordscc);
	secumple = False;
	i = 0;
	do{
		if(jugada.orient == abajo){
			secumple = coincidencoords(c1(coordscc),
									   c2(coordscc),
									   c1(jugada.coords),
									   c2(jugada.coords)+i);
		}else{
			secumple = coincidencoords(c1(coordscc),
									   c2(coordscc),
									   char(int(c1(jugada.coords))+i),
									   c2(jugada.coords));		
		}
		i = i + 1;
	}while(not secumple and i < longpalabra(jugada.palabra));
	
	return secumple;
}

function condicion3(tablero: TipoTablero, jugada: TipoJugada): bool

/*
 * ¿Al menos una letra de la palabra
 * cae en una casilla libre?
 */

	i: int;
	secumple: bool;
{
	i = 0;
	secumple = False;
	do{
		if(jugada.orient == abajo){
			secumple = casillavacia(tablero, 
									c1(jugada.coords), 
									c2(jugada.coords)+i);
		}else{
			secumple = casillavacia(tablero, 
									char(int(c1(jugada.coords))+i), 
									c2(jugada.coords));
		}
		i = i + 1;
	}while(not secumple and i < longpalabra(jugada.palabra));
	
	return secumple;
}

function condicion2(palabra: TipoPalabra): bool

/*
 * ¿Todas las letras de la palabra son
 * letras minúsculas del abecedario?
 */
 
	i: int;
	secumple: bool;
{
	i = 0;
	secumple = True;
	do{
		if(not esletraminus(palabra.caracts[i])){
			secumple = False;
		}
		i = i + 1;
	}while(secumple and i < longpalabra(palabra));
	
	return secumple;
}

function condicion1(tablero: TipoTablero, jugada: TipoJugada): bool

/*
 * ¿Cada letra de la palabra coincide 
 * con una letra ya puesta en el 
 * tablero o con una casilla libre?
 */
 
	secumple: bool;
	i: int;
{
	secumple = True;
	for(i = 0, i < longpalabra(jugada.palabra)){
		if(jugada.orient == abajo){
			if(not coincidenletras(tablero, 
								   c1(jugada.coords), 
								   c2(jugada.coords)+i, 
								   jugada.palabra,
								   i) and

			   not casillavacia(tablero, 
								c1(jugada.coords), 
								c2(jugada.coords)+i)){

				secumple = False;
			}
		}else{
			if(not coincidenletras(tablero, 
								   char(int(c1(jugada.coords))+i), 
								   c2(jugada.coords), 
								   jugada.palabra,
								   i) and

			   not casillavacia(tablero, 
								char(int(c1(jugada.coords))+i), 
								c2(jugada.coords))){

				secumple = False;
			}
		}
	}
	
	return secumple;
}

function ultimacoords(palabra: TipoPalabra, 
					  coords: TipoCoords, 
				      orient: TipoOrient): TipoCoords
				  
	ultcoords: TipoCoords;
{
	if(orient == abajo){
		ultcoords.c1 = coords.c1;
		ultcoords.c2 = coords.c2 + (palabra.long-1);
	}else{
		ultcoords.c1 = char(int(coords.c1) + (palabra.long-1));
		ultcoords.c2 = coords.c2;
	}
	
	return ultcoords;
}

function cabeentablero(jugada: TipoJugada): bool
{
	return coordsentablero(ultimacoords(jugada.palabra, 
										jugada.coords, 
										jugada.orient));
}

function jugadaok(tablero: TipoTablero, jugada: TipoJugada): bool
{
	if(cabeentablero(jugada)){
		if(esprimerapalabra(tablero)){
			return condicion1(tablero, jugada) and
				   condicion2(jugada.palabra) and
				   condicion3(tablero, jugada) and
				   condicion4(jugada);
		}else{
			return condicion1(tablero, jugada) and
				   condicion2(jugada.palabra) and
				   condicion3(tablero, jugada) and
				   condicion5(tablero, jugada);
		}
	}else{
		return False;
	}
}

function puntletra(palabra: TipoPalabra, i: int): int
	c: char;
{
	c = palabra.caracts[i];
	return int(c) - int(LetraIMinus) + 1;
}

function empiezapore(palabra: TipoPalabra): bool
{
	return palabra.caracts[0] == LetraEMinus;
}

function jugadaesbuena(jugada: TipoJugada): bool
{
	return (jugada.ok == True) and not empiezapore(jugada.palabra);
}

function caeentriple(tablero: TipoTablero, 
					jugada: TipoJugada,
					i: int): bool
{
	if(jugada.orient == abajo){
		return escasillatriple(tablero,
							   c1(jugada.coords), 
							   c2(jugada.coords)+i);
	}else{
		return escasillatriple(tablero, 
							   char(int(c1(jugada.coords))+i), 
							   c2(jugada.coords));
	}
}

function caeendoble(tablero: TipoTablero, 
					jugada: TipoJugada,
					i: int): bool
{
	if(jugada.orient == abajo){
		return escasilladoble(tablero,
							  c1(jugada.coords), 
							  c2(jugada.coords)+i);
	}else{
		return escasilladoble(tablero, 
							  char(int(c1(jugada.coords))+i), 
							  c2(jugada.coords));
	}
}
				
function puntletras(tablero: TipoTablero,
					jugada: TipoJugada): int
	total: int;
	puntosletra: int;
	i: int;
{
	total = 0;
	puntosletra = 0;
	
	for(i = 0, i < longpalabra(jugada.palabra)){
	puntosletra = puntletra(jugada.palabra, i);
	
	if(caeendoble(tablero, jugada, i)){
		doblarpunt(puntosletra);
	}else if(caeentriple(tablero, jugada, i)){
		triplicarpunt(puntosletra);
	}
	
	total = total + puntosletra;
	}
	
	return total;
}

function esempate(jugadores: TipoJugadores, 
				  puntmayor: int): bool
	i: int;
	j: int;
{
	j = 0;
	for(i = 0, i < NJugadores){
		if(puntjugador(jugadores[i]) == puntmayor){
			j = j + 1;
		}
	}
	
	return j >= 2;
		
}

procedure guardarvalidjugada(ref jugada: TipoJugada)
{
	jugada.ok = True;
}

procedure guardarenslot2(ref casilla: TipoCasilla,
						 casillaesp: TipoCasillaEsp)
{
	casilla.slot2 = casillaesp.valor;
}

procedure guardarenfila(ref fila: TipoFila, 
						casillaesp: TipoCasillaEsp)
{
	guardarenslot2(fila[c1(casillaesp.coords)], casillaesp);
}

procedure guardarcasillaesp(ref tablero: TipoTablero, 
							casillaesp: TipoCasillaEsp)
{
	guardarenfila(tablero[c2(casillaesp.coords)], casillaesp);
}

procedure leercoords(ref coords: TipoCoords)
{
	readln(coords.c1);
	readln(coords.c2);
}

procedure leercasillaesp(ref casillaesp: TipoCasillaEsp)
{
	readln(casillaesp.valor);
	leercoords(casillaesp.coords);
}

procedure guardarcaracter(ref hueco: char, c: char)
{
	hueco = c;
}

procedure ubicarcasilla(ref casilla: TipoCasilla)
{
	casilla.slot2 = Vacio;
}

procedure ubicarfila(ref fila: TipoFila, c1: char)
{
	ubicarcasilla(fila[c1]);
}

procedure eliminarslot2(ref tablero: TipoTablero,
						c1: char,
						c2: int)
{
	ubicarfila(tablero[c2], c1);
}

procedure copiarletraencasilla(ref casilla: TipoCasilla,
							  letra: char)
{
	casilla.slot1 = letra;
}

procedure copiarletraenfila(ref fila: TipoFila, 
						   c1: char, 
						   letra: char)
{
	copiarletraencasilla(fila[c1], letra);
}

procedure copiarletra(ref tablero: TipoTablero, 
					  c1: char, 
					  c2: int, 
					  palabra: TipoPalabra,
					  i: int)
{
	copiarletraenfila(tablero[c2], c1, palabra.caracts[i]);
}

procedure copiarjugada(ref tablero: TipoTablero, jugada: TipoJugada)
	i: int;
{
	for(i = 0, i < longpalabra(jugada.palabra)){
		if(jugada.orient == abajo){
			copiarletra(tablero, 
						c1(jugada.coords), 
						c2(jugada.coords)+i, 
						jugada.palabra,
						i);
		}else{
			copiarletra(tablero, 
						char(int(c1(jugada.coords))+i), 
						c2(jugada.coords), 
						jugada.palabra,
						i);
		}
	}
}

procedure leerpalabra(ref palabra: TipoPalabra)
	c: char;
{
	iniclongpalabra(palabra.long);
	do{
		peek(c);
		if(escaracter(c)){
			read(c);
			guardarcaracter(palabra.caracts[palabra.long], c);
			palabra.long = palabra.long + 1;
		}
	}while(escaracter(c));
	
	readeol();	
}

procedure leerjugada(ref jugada: TipoJugada)
{
	leerpalabra(jugada.palabra);
	leercoords(jugada.coords);
	readln(jugada.orient);
}

procedure leerjugador(ref tablero: TipoTablero, 
					  ref jugador: TipoJugador)
{
	leerjugada(jugador.jugadas[njugadas(jugador)]);
	
	if(jugadaok(tablero, jugador.jugadas[njugadas(jugador)])){
	
		copiarjugada(tablero, jugador.jugadas[njugadas(jugador)]);
		
		guardarvalidjugada(jugador.jugadas[njugadas(jugador)]);
	}
	jugador.njugadas = njugadas(jugador) + 1;
}

procedure leerjugadores(ref tablero: TipoTablero, 
						ref jugadores: TipoJugadores,
						ref c: char)
	i: int;
{
	i = 0;
	do{
		peek(c);
		if(not esalmohadilla(c) and not eof() and i < NJugadores){
			leerjugador(tablero, jugadores[i]);
			i = i + 1;
		}
	}while(not esalmohadilla(c) and not eof() and i < NJugadores);
}

procedure eliminarcasillaesp(ref tablero: TipoTablero,
							 jugada: TipoJugada)
	i: int;
{
	for(i = 0, i < longpalabra(jugada.palabra)){

		if(jugada.orient == abajo){
			eliminarslot2(tablero,
						  c1(jugada.coords), 
						  c2(jugada.coords)+i);
		}else{
			eliminarslot2(tablero, 
						  char(int(c1(jugada.coords))+i), 
						  c2(jugada.coords));
		}
	}
}

procedure calcularpuntjugada(ref tablero: TipoTablero, 
							 ref jugada: TipoJugada)
{
	if(jugadaesbuena(jugada)){
		jugada.punt = puntletras(tablero, jugada);
		eliminarcasillaesp(tablero, jugada);
	}else{
		jugada.punt = 0;
	}
}

procedure calcularpuntjugador(ref tablero: TipoTablero, 
							  ref jugador: TipoJugador)
	i: int;
{
	for(i = 0, i < njugadas(jugador)){
		calcularpuntjugada(tablero, jugador.jugadas[i]);
		jugador.punt = jugador.punt + puntjugada(jugador.jugadas[i]);
	}
}

procedure imprimtotal(jugador: TipoJugador)
{
	write("total: ");
	writeln(jugador.punt);
}

procedure impripalabra(palabra: TipoPalabra)
	i: int;
{
	for(i = 0, i < longpalabra(palabra)){
		write(palabra.caracts[i]);
	}
}

procedure imprimjugada(jugada: TipoJugada)
{
	impripalabra(jugada.palabra);
	write(" ");
	writeln(jugada.punt);
}

procedure imprimjugadas(jugador: TipoJugador)
	i: int;
{
	for(i = 0, i < njugadas(jugador)){
		imprimjugada(jugador.jugadas[i]);
	}
}

procedure llamarjugador(i: int)
{
	write("Jugador ");
	write(i+1);
	writeln(":");
}

procedure imprimjugadores(jugadores: TipoJugadores)
	i: int;
{
	for(i = 0, i < NJugadores){
		llamarjugador(i);
		if(njugadas(jugadores[i]) != 0){
			imprimjugadas(jugadores[i]);
		}
		imprimtotal(jugadores[i]);
		writeeol();
	}
}

procedure imprimganador(jugadores: TipoJugadores)
	i: int;
	puntmayor: int;
	ganador: int;
{
	ganador = 0;
	puntmayor = 0;
	for(i = 0, i < NJugadores){
		if(puntjugador(jugadores[i]) > puntmayor){
			puntmayor = puntjugador(jugadores[i]);
			ganador = i+1;
		}
	}

	if(esempate(jugadores, puntmayor)){
		writeln("Empate");
	}else{
		write("Gana el Jugador ");
		write(ganador);
		writeln(".");
	}
}

procedure calcularpunt(ref tablero: TipoTablero, 
					   ref jugadores: TipoJugadores)
	i: int;
{
	for(i = 0, i < NJugadores){
		calcularpuntjugador(tablero, jugadores[i]);
	}
}

procedure imprimresult(juego: TipoJuego)
{
	if(hayjugadas(juego.jugadores)){
		calcularpunt(juego.tablero, juego.jugadores);
		imprimjugadores(juego.jugadores);
		imprimganador(juego.jugadores);
	}else{
		writeln("No ha habido jugadas.");
	};
}

procedure jugar(ref juego: TipoJuego)
	c: char;
{
	inicjugadores(juego.jugadores);
	if(not eof()){
		do{
			peek(c);
			if(not esalmohadilla(c) and not eof()){
				leerjugadores(juego.tablero, juego.jugadores, c);
			}else if(esalmohadilla(c)){
				readln(c);
			}
		}while(not esalmohadilla(c) and not eof());
	}
}

procedure leertablero(ref tablero: TipoTablero)
	casillaesp: TipoCasillaEsp;
	c: char;
{
	inictablero(tablero);
	do{
		peek(c);
		if(not esarroba(c) and not eof()){
			leercasillaesp(casillaesp);
			if(casillaespok(tablero, casillaesp)){
				guardarcasillaesp(tablero, casillaesp);
			}
		}else if(esarroba(c)){
			readln(c);
		}
	}while(not esarroba(c) and not eof());
}

procedure main()
	juego: TipoJuego;
{
	leertablero(juego.tablero);
	jugar(juego);
	imprimresult(juego);
}
