{1.	Escribir un programa que:
a. Implemente un módulo que lea información de datos de un club y las almacene en un árbol binario de búsqueda. 
De cada dato se lee número de dato, nombre y edad. La lectura finaliza con el número de dato 0 y el árbol debe quedar 
ordenado por número de dato.
}

program ej1;
type 

    persona=record 
        nro:integer;
        nombre:string;
        edad:integer;
    end;

    arbol=^nodo;
    nodo=record 
        dato:dato;
        hi:arbol;
        hd:arbol;
    end;
procedure crearArbol(var a:arbol; dato:);
begin 
    if(a=nil)then begin 
        new(a);
        a^.dato:=dato;
        a^.hi:=nil;
        a^.hd:=nil;
    end
    else begin 
        if(a^.dato.nro>dato.nro)then 
            crearArbol(a^.hi,dato)
        else
            crearArbol(a^.hd,dato);
    end;
end;

procedure leerdato(var s:dato);
begin 
    write('INGRESA NRO DE dato: '); readln(s.nro);
    write('INGRESE NOMBRE DE dato: '); readln(s.nombre);
    write('INGRESE EDAD DEL dato: '); readln(s.edad);
end;

procedure cargarArbol(var a:arbol);
var 
    s:dato;
begin 
    leerdato(s);
    while(s.nro<>0)do begin 
        crearArbol(a,s);
        leerdato(s);
    end;
end;

{b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que : }
{i. Informe el número de dato más grande. Debe invocar a un módulo recursivo que retorne dicho valor.}

function Maximo (a:arbol):integer;
begin
    if(a^.hd<>nil)then 
        maximo:=a^.dato.nro
    else
        maximo:=maximo(a^.hd) 
end;

{ii. Informe los datos del dato con el número de dato más chico. Debe invocar a un módulo recursivo que retorne dicho dato.}

function minimo(a:arbol):integer;
begin  
    if(a^.hi<>nil)then 
        minimo:=a^.dato.nro
    else
        minimo:=minimo(a^.hi);

end;

{iii. Informe el número de dato con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.}
//PROCEDURE
procedure mayorEdad(a:arbol; var max:integer; var nroMax:integer);

begin 
    if(a<>nil)then begin
        if(a^.dato.edad>max)then begin 
            max:=a^.dato.edad;
            nroMax:=a^.dato.nro;
        
        end;
        mayorEdad(a^.hi,max,nroMax);
        mayorEdad(a^.hd,max,nroMax); 
    end;
end;

{iv. Aumente en 1 la edad de todos los datos.}

procedure incrementar(var a:arbol);
begin
    if(a<>nil)then begin 
        a^.dato.edad+=1;
        incrementar(a^.hi);
        incrementar(a^.hd);
    end;
end;

{v. Lea un valor entero e informe si existe o no existe un dato con ese valor. 
Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.}

function buscarNumero(a:arbol; valor:integer):boolean;
begin 
    if(a=nil)then 
        buscarNumero:=false
    else begin  
        if(a^.dato.nro=valor)then
            buscarNumero:=true
        else begin 
            if(a^.dato.nro>valor)then 
                buscarNumero:=buscarNumero(a^.hi,valor)
            else
                buscarNumero:=buscarNumero(a^.hd,valor);
        end;
    end;
end;

{vi. Lea un nombre e informe si existe o no existe un dato con ese nombre. 
Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.}

function existeNombre(nombre : string; a : arbol) : boolean;
begin
	if(a = nil) then
	begin
		existeNombre := false;
	end
	else
	begin
        writeln('1');
		existeNombre := existeNombre(nombre, a^.hi) or 
					(a^.dato.nombre = nombre) or
					existeNombre(nombre, a^.hd);
	end;
end;

{vii. Informe la cantnroad de datos. Debe invocar a un módulo recursivo que retorne dicha cantnroad.}

function informarCantnroad(a:arbol):integer;
var
    cant:integer;
begin 
    if(a=nil)then 
        cant:=0;
    else begin 
        cant:=1
        cant:=cant+informarCantnroad(a^.hi);
        cant:=cant + informarCantnroad(a^.hd);     
    end;
    informarCantnroad:=cant;
end;

{viii. Informe el promedio de edad de los datos. Debe invocar al módulo recursivo del inciso vii e invocar 
a un módulo recursivo que retorne la suma de las edades de los datos.}

function edadTotal(a:arbol):integer;
var 
    cant:integer;
begin 
    cant:=0;
    if(a<>nil)then begin 
        cant:=a^.dato.edad;
        cant:=cant + edadTotal(a^.hi);
        cant:=cant + edadTotal(a^.hd);
    end;
    edadTotal:=cant;
end;

{ix. Informe, a partir de dos valores que se leen, la cantnroad de datos en el árbol cuyo número de dato se encuentra 
entre los dos valores ingresados. Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantnroad.}

function dentroDeRango(inicio, fin : integer; a: arbol) : integer;
var
	cant : integer;
begin
	cant := 0;
	if(a <> nil) then
	begin
		if(a^.dato.nro < inicio) then
		begin
			cant := dentroDeRango(inicio, fin, a^.hd);
		end
		else if(a^.dato.nro > fin) then
		begin
			cant := dentroDeRango(inicio, fin, a^.hi);
		end
		else
		begin //  nro esta dentro del rango
			cant := 1;
			cant := cant + dentroDeRango(inicio, fin, a^.hi);
			cant := cant + dentroDeRango(inicio, fin, a^.hd);
		end;
	end;
	dentroDeRango := cant;
end;
//x. Informe los números de socio en orden creciente. 
procedure enOrden(a:arbol);
begin
    if(a<>nil)then begin 
        enOrden(a^.hi);
        write(a^.dato.nro);
        enOrden(a^.hd);
    end;
end;

//xi. Informe los números de socio pares en orden decreciente. 
procedure decreciente(a:arbol);
begin 
    if(a<>nil)then 
        decreciente(a^.hd);
        if(a^.dato.nro mod 2 = 0)then 
            write(a^.dato.nro);
        decreciente(a^.hi);
    end;
end;
var  
    a:arbol; 
begin 
    cargarArbol(a);
    existeNombre('Maria',a);
end.