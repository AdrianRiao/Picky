program numprimo;

procedure escribirnum(num: int)
{
	writeln(num);
}

function esdivisible(num1: int, num2: int): bool
/*¿Es divisible num1 entre num?*/
{
	return (num1 % num2 == 0);
}

function numantes(num: int): int
{
	return (num - 1);
}

function extienumdivisible(num: int): bool
	i: int;
	respuesta: bool;
{
	i = 2;
	respuesta = False; /*Asumimos que no tiene divisores*/
	do{
		if(i < num){
			respuesta = esdivisible(num, i);
		}
		i = i + 1;
	}while(respuesta == False and i < num);
	return respuesta;
}

function tienedivisores(num: int): bool
/*
 * si es divisible entre mas numeros
 * aparte de el uno y el mismo
 */
{
	if(extienumdivisible(num)){
		return True;
	}else{
		return False;
	}
}

function esprimo(num: int): bool
{
	if(tienedivisores(num)){
		return False;
	}else{
		return True;
	}
}

consts:

	Hasta = 100;

procedure main()
	i: int;
{
	for(i = 1, i <= Hasta){
		if(esprimo(i)){
			escribirnum(i);
		}
	}
}
