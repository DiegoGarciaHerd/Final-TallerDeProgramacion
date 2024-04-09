{ 
2.	Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto,
 fecha y cantidad de unidades vendidas. La lectura finaliza con el código de producto 0. 
 Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. 
Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
}

program ej2;

type
    venta=record 
        cod:integer;
        fecha:string;
        cantUnidadesVendidas:integer;
    end;

    arbol=^nodo 
    nodo=record
        dato:venta;
        hi:arbol;
        hd:arbol;
    end;

    producto=record
        cod:integer;
        cantTotal:integer;
    end
    arbol_acu=^nodo_acu;
    nodo_acu=record
        dato:producto;
        hi:arbol_acu;
        hd:arbol_acu;
    end;


procedure leerVenta(var v:venta);
begin 
    write('INGRESE CODIGO DE PRODUCTO: '); readln(v.cod);
    write('INGRESE FECHA DE LA COMPRA: '); readln(v.compra);
    write('INGRESE CANTIDAD DE UNIDADES VENDIDAS: '); readln(v.cantUnidadesVendidas);
end;

procedure crearArbol(var a:arbol; v:venta);
begin 
    if(a=nil)then begin 
        new(a);
        a^.dato:=v;
        a^.hi:=nil;
        a^.hd:=nil;
    end
    else begin
        if(v.cod<a^.dato.cod)then 
            crearArbol(a^.hi,v)
        else
            crearArbol(a^.hd,v);
    end;
end;
procedure crearAcumulador(var a:arbol_acu; v:venta);
begin
    if(a=nil)then begin
        new(a);
        a^.dato.cod:=v.cod;
        a^.dato.cantTotal:=v.cantUnidadesVendidas;
        a^.hi:=nil;
        a^.hd:=nil;
    end
    else  begin
        if(a^.dato.cod > v.cod)then 
            crearAcumulador(a^.hi,v)
        else begin
            if(a^.dato.cod<v.cod)then 
                crearAcumulador(a^.hd,v)
            else
                a^.dato.cantTotal:=a^.dato.cantTotal+v.cantUnidadesVendidas;
        end;
    end;
end;
{i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.}
{ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. }
procedure cargarArbol(var a1:arbol; var a2:arbol_acu);
var 
    v:venta;
begin
    leerVenta(v);
    a1:=nil;
    a2:=nil;
    while(v.cod<>0)do begin
        crearArbol(a1,v);
        crearAcumulador(a2,v);
        leerVenta(v);
    end;
end;

{b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de 
unidades vendidas de ese producto.}

function retornarCantVendidasA(a:arbol; codigoProducto:integer):integer;
var 
    cant:integer;
begin
    cant:=0
    if(a<>nil)then begin 
        if(a^.dato.cod>codigoProducto)then 
            cant:=retornarCantVendidas(a^.hi,codigoProducto);
        else begin 
            if(a^.dato.cod<codigoProducto)then 
                cant:=retornarCantVendidas(a^.hd,codigoProducto);
            else begin
                cant:=a^.dato.cantUnidadesVendidas;
                cant:=cant + retornarCantVendidas(a^.hi,codigoProducto);
                cant:=cant + retornarCantVendidas(a^.hd,codigoProducto);
            end;
        end;
    end;
end;

{c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad 
total de unidades vendidas de ese producto.}

function retornarCantVendidasB(a:arbol_acu; codigoProducto:integer);
begin
    cant:=0
    if(a<>nil)then begin
       if(a^.dato.cod>codigoProducto)then 
           cant:=retornarCantVendidas(a^.hi,codigoProducto)
        else begin 
            if(a^.dato.cod<codigoProducto)then 
                cant:=retornarCantVendidasB(a^.hd,codigoProducto)
            else 
                cant:=a^.dato.cantTotal;
        end;
    end;
end;

