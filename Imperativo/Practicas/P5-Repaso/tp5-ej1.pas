{1.- El administrador de un edificio de oficinas, cuenta en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa que:
a)	Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa código 
de identificación, DNI del propietario y valor de la expensa. La lectura finaliza cuando llega el código de identificación -1.
b)	Ordene el vector, aplicando uno de los métodos vistos en la cursada, para obtener el vector ordenado por código de 
identificación de la oficina.
c)	Realice una búsqueda dicotómica que recibe el vector generado en b) y un código de identificación de oficina y retorne 
si dicho código está en el vector. En el caso de encontrarlo, se debe informar el DNI del propietario y en caso contrario 
informar que el código buscado no existe.
d)	Tenga un módulo recursivo que retorne el monto total de las expensas.
}

program ej1;
const 
    DIMF=300;
type 
    oficina=record 
        id:integer;
        dniPropieario:integer;
        valorExpensa:real;
    end;

    vector=array[1..DIMF]of oficina;

procedure leerOficina(var o:oficina);
begin 
    write('ID: '); readln(o.id);
    write('DNI PROPIETARIO: '); readln(o.dniPropieario);
    write('VALO EXPENSA: '); readln(o.valorExpensa);
end;

procedure cargarVector(var v:vector; var diml:integer);
var 
    o:oficina;
begin
    leerOficina(o);
    diml:=0;
    while(o.id<>-1)do begin
        diml:=diml+1;
        v[diml]:=o;
        leerOficina(o);
    end;
end;

procedure ordenarSeleccion(var v:vector; diml:integer);
var 
    i,j,p:integer; item:oficina;
begin 
    for i:=1 to diml-1 do begin
        p:=i;
        for j:=i+1 to diml do begin
            if(v[p]>v[v[j]])then 
                p:=j;
        end;
        item:=v[p];
        v[p]:=v[i];
        v[i]:=item;
    end;
end;

{c)	Realice una búsqueda dicotómica que recibe el vector generado en b) y un código de identificación de oficina y retorne 
si dicho código está en el vector. En el caso de encontrarlo, se debe informar el DNI del propietario y en caso contrario 
informar que el código buscado no existe.}

procedure busquedaDicotomica(v:vector; diml:integer; codId:integer);
var 
    medio,pri,ult:integer;
begin 
    pri:=1; ult:=diml+1; medio:=(ult+pri)div 2;
    while(pri<=ult)and(v[medio].id<>codId)do begin 
        if(v[medio].id<codId)then 
            ult:=medio - 1;
        else 
            pri:=medio + 1;
        medio:=(ult+pri)div 2;
    end;

    if(pri<=ult)and(v[medio].id=codId)then begin 
        writeln('DNI DEL PROPIETARIO ENCONTRADO: ', v[medio].dni)
    else
        writeln('EL CODIGO BUSCADO NO EXISTE');
end;

{d)	Tenga un módulo recursivo que retorne el monto total de las expensas.}

function montoTotal(v:vector; inicio:integer; fin:integer);
begin 
    if(inicio<=fin)then 
        montoTotal:= v[inicio].valorExpensa + monto(v,inicio+1,fin);
    else 
        montoTotal:=0;
end;

