{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, DNI del propietario 
y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program ej2;
const 
    DIMF=300;
type 
    oficina=record 
        codId:integer; 
        dniPropietario:integer;
        valorExpensa:integer;
    end;

    vector=array[1..DIMF]of oficina;

procedure leerOficina(var o:oficina);
begin 
    write('INGRESE CODIGO DE IDENTIFICACION: '); readln(o.codId);
    write('DNI DEL PROPIETARIO: '); readln(o.dniPropietario);
    write('VALOR DE LA EXPENSA: '); readln(o.valorExpensa);
    writeln('-------------------------');
end;

procedure cargarVector(var v:vector; var diml:integer);
var 
    o:oficina;
begin 
    leerOficina(o);
    diml:=0;
    while(o.codId<>-1)do begin 
        diml+=1;
        v[diml]:=o;
        leerOficina(o);
    end;
end;

procedure ordenarSeleccion(var v:vector; diml:integer);
var 
    p,i,j:integer; item:venta;
begin 
    for i:=1 to diml-1
        p:=i;
        for j:=i+1 to diml do begin 
            if(v[p].codId>v[j].codId)then 
                p:=j;
        end;

        item:=v[p];
        v[p]:=v[i];
        v[i]:=item;
    end;
end;

procedure ordenarInsercion(var v:vector; diml:integer);
var 
    i,j:integer; actual:venta; 
begin 
    for i:=2 to diml do 
        actual:=v[i];
        j:=i-1;
        while(j>0)and(v[j].codId>actual.codId)do begin 
            v[j+1]:=v[j]; 
            j:=j-1; 
        end;
        v[j+1]:=v[j];
    end;
end;
