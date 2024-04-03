{1.- Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades).  El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.
}

program tp1-ej1;
const 
    DIMF=5;
type 
    t_codProducto=1..15;
    t_unidades=1..99;
    venta=record
        cod:t_codProducto;
        cantVendida:t_unidades;
    end;

    vector=array[1..DIMF]of venta;

    lista=^nodo;
    nodo=record 
        dato:venta;
        sig:lista;
    end;

//a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer.
procedure cargarVector(var v:vector; var diml:integer);
var
    i:integer; ven:venta;
begin 
    Randomize;
    diml:=0;
    for i:=1 to DIMF do begin 

        ven.cod:=random(10000);
        writeln('---------------------------');
        writeln('CODIGO GENERADO: ',ven.cod);
        write('Ingrese cantidad vendida(1..99): '); readln(ven.cantVendida);
        diml+=1;
        v[i]:=ven;
    end;
end;

{b. Mostrar el contenido del vector resultante.}

procedure imprimirVector(var v:vector; diml:integer);
var 
    i:integer;
begin 
    for i:=1 to diml do begin
        writeln('-----------------------');
        writeln('CODIGO PRODUCTO: ',v[i].cod);
        writeln('CANTIDAD VENDIDA: ',v[i].cantVendida);
        writeln('-----------------------');
    end;
end;

//c. Ordenar el vector de ventas por código.
procedure ordenarSeleccion(var v:vector; diml:integer);
var 
    i,j,p:integer; item:venta;
begin 
    for i:=1 to diml-1 do begin 
        p:=i;
        for j:=i+1 to diml do 
            if(v[p].cod>v[j].cod)then 
                p:=j;
        item:=v[p];
        v[p]:=v[i];
        v[i]:=item;
    end;
end;


procedure ordenarInsercion(var v:vector; diml:integer);
var 
    i,j,p:integer; actual:venta;
begin  
    for i:=2 to diml-1
        actual:=v[i];
        p:=i-1;
        while(j>0)and(v[j].codId>actual.codId)do begin 
            v[j+1]:=v[j];
            j:=j-1;
        end;
        v[j+1]:=v[j];
    end;
end;
                     
//e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 

procedure eliminar(valor1,valor2:integer ; var v:vector; var diml:integer);
var 
    i:integer; j:integer;
begin 
    i:=1;
    while(i<=diml)and(v[i].cod<valor1)do begin 
        i+=1;
    end;
        while(i<=diml)and(v[i].cod>valor1)and(v[i].cod<valor2)do begin 
            for j:=i to diml-1 do begin 
                v[j]:=v[j+1];            
            end;
            diml:=diml - 1;
        end;
end;

{g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., 
sólo para los códigos pares.}

procedure insertarOrdenado(var l:lista; v:venta);
var 
    act,ant,aux:lista;
begin 
    new(aux); aux^.dato:=v; 
    act:=l;
    ant:=l;
    while(act<>nil)and(act^.dato.cod<v.cod)do begin
        ant:=act;
        act:=act^.sig;
    end; 
    if(act=ant)then 
        l:=aux
    else
        ant^.sig:=aux;
    aux^.sig:=act;
end;

procedure recorrerVector(var v:vector; var l:lista; diml:integer);
var 
    i:integer;
begin 
    for i:=1 to diml do begin 
        if(v[i].cod MOD 2 = 0)then 
            insertarOrdenado(l,v[i]);
    end;
end;

procedure imprimirLista(l:lista);
begin 
    while(l<>nil)do begin 
        writeln('LISTA GENRERADA: ');
        write('CODIGO: ',l^.dato.cod); write(' CANT PRODUCTOS:  ', l^.dato.cantVendida);
        l:=l^.sig;
    end;
end;

