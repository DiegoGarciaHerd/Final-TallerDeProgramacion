<h1 align="center">CONCURRENTE</h1>

R-Info
=== 

* Las avenidas son las verticales y las calles las horizontales
* Hay 100 avenidas y 100 calles

| Sintaxis | Definición |
| -------- | ---------- |
| (2,1) | (Av,Ca) | 
| Iniciar(robot,av,ca) | Inicio el robot en la esquina |
| Area(Av,Ca,Av,Ca) | Rectangulo que parte de una esquina |
| Pos(Av,Ca) | Posiciona el robot en la esquina |
| PosAv,PosCa | Devuelve el valor de la esquina/calle actual del robot |
| and | & |
| or | barra vertical | 
| not | ~ |
| Igualdad | = |
| Menor | < |
| Mayor | > |
| Menor igual | <= |
| Mayor igual | >= |
| Distinto | <> |
| Random(var,1,5) | el valor 'var' toma un valor random entre 1 y 5 |
| EnviarMensaje(valor,robot) | Envia un valor a un robot especifico |
| RecibirMensaje(valor,robot) | Recibe un valor de robot especifico |
| RecibirMensaje(valor,*)  | Recibe un valor del primer robot que identifique |

Pasaje de Mensajes 
=== 

<table>
<tr>
<td> robot </td> <td> jefe </td>
</tr>
<tr>
<td>

```Ruby 
  robot robot1
  variables
    id:numero
  comenzar
    RecibirMensaje(id,jefe)
    {Hace algo}
    EnviarMensaje(id,jefe)
    EnviarMensaje(valor,jefe)
  fin 
```
</td>
<td>

```Ruby
  robot jefe
  variables 
    id:numero
  comenzar
    {Primero asigna ids}
    {Supongo que son 3 robots del mismo tipo}
    EnviarMensaje(1,robot1)
    EnviarMensaje(2,robot2)
    EnviarMensaje(3,robot3)
    repetir 3
      RecibirMensaje(id,*)
      si id = 1
        RecibirMensaje(valor,r1)
      sino 
        si id = 2
          RecibirMensaje(valor,r2)
        sino 
          si id = 3
            RecibirMensaje(valor,r3)
    fin 
```
</td>

</tr>

</table>

Barrera
===
Examen
* Tres procesos tipoTrabajador(r1, r2, r3) deben recorrer 5 cuadras de su avenida juntando flores, y una vez que todos terminaron, deben recorrer otras 5 cuadras de su avenida juntando papeles. Para coordinarse seran asistidos por un proceso tipoCoordinador(rC). Dado que el siguiente codigo para los robots tipoTrabajador, indiquie si el fragmente de codigo del tipoCoordinador es correcto. Justifique.

Las variales y los modulos en el codigo ya estan declaradas

<table>
<tr>
<td> robot tipoTrabajador </td>
<td> proceso tipoCoordinador</td>
</tr>
<tr>
<td> 

```Ruby
robot tipoTrabajador
...
  recorreJuntandoFlores(5)
  EnviarMensaje(id,rC)
  RecibirMensaje(segui,rC)
  recorreJuntandoPapeles(5)
fin 
```

</td>
<td>

```Ruby
proceso tipoCoordinador
...
  repetir 3
    RecibirMensaje(id,*)
    si(id = 1)
      EnviarMensaje(1,r1)
    sino 
      si( id = 2)
        EnviarMensaje(1,r2)
      sino 
        EnviarMensaje(1,r3)
```

</td>
</tr>
</table>

* RTA: El codigo proporcionado es INCORRECTO , ya que en el inciso especifica que una vez que TODOS los robots terminaron el recorrido deben empezar a recorrer otras cinco cuadras y de la manera que esta escrito el proceso del robot coordinador le va a enviar el mensaje de aprobacion cuando recibe el id del primer robot que le mande, por lo que el robot comenzaria el recorrido antes que los demas. Este concepto es el de barrera y se refiere a como se puede sincronizar diferentes procesos para que actuen sincronicamente. El robot primera deberia recibir los ids de los 3 robots este caso y luego de recibir todos los ids , manda al mensaje de arranque al mismo tiempo.

Ejercicios de practica por tipo
=== 
- [Barrera](#sincronizacion-barrera)

Sincronizacion barrera
===
* Multiples procesos se ejecutan concurrentemente, hasta que llegan a un punto especial, llamado **barrera** . Los Procesos que llegan a la barrera deben detenerse y esperar que todos los procesos lleguen
* Cuando todos los procesos lleguen a la barrera pueden retomar su actividad , para esto los procesos deben avisar que llegaron

Ejercicio 3. **Sincronización barrera**:

Tres robots deben vaciar de papeles su avenida, comenzando por la calle 1 y terminando en
la calle 100. El trabajo lo deben realizar todos juntos y en etapas: los robots inician juntos y
cuando todos completan una etapa del trabajo pueden avanzar a la siguiente, lo que
significa que para poder pasar de etapa los robots deben esperar que todos hayan
completado la etapa en curso. Se proponen dos posibles soluciones a este problema:
etapas homogéneas o etapas heterogéneas:
a) Implemente el programa considerando que cada robot completa una etapa cada 5
esquinas
b) Implemente el programa considerando que cada robot completa una etapa luego de
juntar N papeles. El valor de N (entre 1 y 5) lo calcula cada robot antes de iniciar
cada etapa.

```Ruby

programa ejercicio3 
procesos 
  proceso avisarFin(E id:numero)
  comenzar 
    si id = 1
      EnviarMensaje(1,r2)
      EnviarMensaje(1,r3)
    sino 
      si id = 2
        EnviarMensaje(1,r1)
        EnviarMensaje(1,r3)
      sino
        EnviarMensaje(1,r2)
        EnviarMensaje(1,r1)
  fin 
   proceso etapa
  comenzar
    repetir 5
      mover
      juntarPapeles
  fin
areas 
  ciudad : AreaC(1, 1, 100, 100)
robots 
  robot robot1 
  variables
    id:numero
    tmp:numero
  comenzar
    RecibirMensaje(id,jefe)
    repetir 4
      mientras(HayPapelEnLaEsquina)
        tomarPapel
      mover 
    mientras(PosCa < 100)
      etapa
      avisarFin(id)
      repetir 2 
        RecibirMensaje(tmp,*)
  fin 

  robot coordinador
  comenzar 
    EnviarMensaje(1,r1)
    EnviarMensaje(2,r2)
    EnviarMensaje(3,r3)
  fin 

variables
  jefe : coordinador
  r1 : robot1
  r2 : robot1
  r3 : robot1
comenzar
  AsignarArea(jefe, ciudad)
  AsignarArea(r1, ciudad)
  AsignarArea(r2, ciudad)
  AsignarArea(r3, ciudad)
  Iniciar(jefe, 100, 100)
  Iniciar(r1, 1, 1)
  Iniciar(r2, 2, 1)
  Iniciar(r3, 3, 1)
fin
```

Servidor-Cliente
===

- Los procesos se agrupan en 2 categorias:
    - **Servidores** : permanecen inactivos hasta que un cliente les solicita algo. Cuando realizan su tarea , entregan el resultado y vuelven a 'dormir' hasta que otro cliente los despierte.
    - **Clientes** : realizan su trabajo de manera independiente , hasta que requieren algo de un servidor. Entonces realizan una solicitud a un proceso servidor, y esperan hasta que reciben respuesta. Cuando esto sucede el cliente continua su trabajo

Ejercicio 1- **Clientes y Servidores**:

Existe un robot que sirve de flores a tres robots clientes. Cada cliente solicita al servidor que
le deposite en su esquina siguiente una cantidad de flores aleatoria (entre 1 y 4). Por
ejemplo, si el cliente se encuentra en la esquina (2,1) le solicitará que coloque x cantidad de
flores en la esquina (2,2).
Cuando el robot servidor deposita las flores en la esquina solicitada, el cliente las junta y las
deposita una a una a lo largo de la avenida en la que se encuentra.
El programa finaliza cuando todos los robots clientes completan su avenida. Asuma que el
robot servidor tiene flores suficientes en su bolsa.
El robot servidor se inicia en la esquina (100,100)
Los robots clientes inician en las esquinas (1,1) , (2,1) y (3,1) respectivamente

```Ruby

programa ejercicio1 
procesos 
  proceso depositarEsquina(E avenida:numero; E calle:numero; E N:numero)
  comenzar
    BloquearEsquina(calle,avenida)
        Pos(calle,avenida)
        repetir N 
          depositarFlor 
        Pos(100,100)
        LiberarEsquina(calle,avenida)
areas 
  areaServidor : AreaP(100, 100, 100, 100)
  area1 : AreaPC(1, 1, 1, 100)
  area2  : AreaPC(2, 1, 2, 100)
  area3 : AreaPC(3, 1, 3, 100)
robots 
  robot servidor 
  variables
    terminados : numero
    id : numero
    N : numero
    avenida: numero
    calle: numero
  comenzar 
    terminados:=0
    mientras(terminados < 3 )
      RecibirMensaje(id,*)
      si id = 1
        RecibirMensaje(N,cliente1)
        si N = 0
          terminados:=terminados + 1
        sino     
          RecibirMensaje(avenida,cliente1)
          RecibirMensaje(calle,cliente1)
          depositarEsquina(calle,avenida,N)
          EnviarMensaje(0,cliente1)
      sino 
        si id = 2 
          RecibirMensaje(N,cliente2)
          si N = 0
            terminados:=terminados + 1
          sino
            RecibirMensaje(avenida,cliente2)
            RecibirMensaje(calle,cliente2)
            depositarEsquina(calle,avenida,N)
            EnviarMensaje(0,cliente2)
        sino 
          si id = 3
            RecibirMensaje(N,cliente3)
            si N = 0
              terminados:=terminados + 1
            sino
              RecibirMensaje(avenida,cliente3)
              RecibirMensaje(calle,cliente3)
              depositarEsquina(calle,avenida,N)
              EnviarMensaje(0,cliente3)
  fin 

  robot cliente 
  variables
    id:numero flores:numero
    sigAv:numero sigCa:numero
    ACK:numero preCa:numero
    preAv:numero
  comenzar
    id:=PosAv
    mientras PosCa< 100
      EnviarMensaje(id,robotServidor)   
      Random(flores,1,4)
      EnviarMensaje(flores,robotServidor)
      sigAv:=PosAv
      sigCa:=PosCa + 1
      EnviarMensaje(sigAv,robotServidor)
      EnviarMensaje(sigCa,robotServidor)
      RecibirMensaje(ACK,robotServidor)
      Pos(sigAv, sigCa)
      preAv := PosAv
      preCa := PosCa
      mientras HayFlorEnLaEsquina
        tomarFlor
      Pos(preAv, preCa)
      mientras (HayFlorEnLaBolsa) & (PosCa < 100)
        si ~(HayFlorEnLaEsquina)
          depositarFlor
        mover
      si PosCa = 100
        EnviarMensaje(id, robotServidor)
        EnviarMensaje(0, robotServidor)
    fin
variables
  robotServidor : servidor
  cliente1 : cliente
  cliente2 : cliente
  cliente3 : cliente
comenzar
  AsignarArea(robotServidor, areaServidor)
  AsignarArea(robotServidor, area1)
  AsignarArea(robotServidor, area2)
  AsignarArea(robotServidor, area3)
  AsignarArea(cliente1, area1)
  AsignarArea(cliente2, area2)
  AsignarArea(cliente3, area3)
  Iniciar(robotServidor, 100, 100)
  Iniciar(cliente1, 1, 1)
  Iniciar(cliente2, 2, 1)
  Iniciar(cliente3, 3, 1)
fin
```

Productores y Consumidores
===

- Existen 2 tipos de procesos
    - Productores: trabajan para generar algún recurso y almacenarlo en un espacio compartido. 
    - Consumidores: Consumidores: utilizan los recursos generados por los productores para realizar su trabajo.
* Para esto los procesos deben coordinar donde almacenan los datos los productores, cuando saben los consumidores que hay datos.

Ejercicio 2. **Productores y consumidores:** 

Existen dos robots productores que recorren las avenidas 5 y 10 respectivamente, juntando
todos los papeles de su avenida. A lo largo del recorrido, cada vez que juntan 5 papeles, los
depositan en la esquina (50,50).
Además existen dos robots consumidores que intentan tomar una cantidad aleatoria de
papeles (entre 2 y 5) de la esquina (50,50) para depositarla en su esquina de origen. Si la
esquina (50,50) no posee la cantidad de papeles requerida, vuelven a su esquina de origen
sin tomar ningún papel. Si luego de 8 intentos seguidos detectan que la esquina (50,50) no
tiene papeles suficientes para juntar, entonces asumirán que los productores ya han
completado su trabajo y por lo tanto terminarán su tarea también.
Los consumidores inician en las esquinas (11,1) y (12,1) respectivamente.

```Ruby

programa ej2
procesos
  proceso dejarPapelesProductor
  variables
    preAv:numero preCa:numero
  comenzar
    preCa:=PosCa
    preAv:=PosAv
    BloquearEsquina(50,50)
    Pos(50,50)
    mientras(HayPapelEnLaBolsa)
      depositarPapel
    Pos(preCa,posCa)
    LiberarEsquina(50,50)
  fin
  proceso juntarPapeles
  variables
    papeles:numero preCa:numero preAv:numero
  comenzar
    papeles:=0
    repetir 99
      mientras HayPapelEnLaEsquina
        tomarPapel
        papeles := papeles + 1
        si papeles = 5
          dejarPapelesProductor
          papeles := 0
      mover
    mientras HayPapelEnLaEsquina
      tomarPapel
      papeles:= papeles + 1
      si papeles = 5
        dejarPapelesProductor
        papeles:=0
  fin
  proceso intentarConsumir(ES intento:boolean)
  variables 
    cant:numero
  comenzar
    Random(cant,2,5)
    BloquearEsquina(50,50)
    mientras(HayPapelEnLaEsquina)&(papeles<cant)
      tomarPapel
      papeles:=papeles+1
    si(papeles = cant)
      intento:=V;
    sino
      intento:=F;
      mientras(HayPapelEnLaBolsa)
        depositarPapel
  fin 


areas 
  areaProductor1: AreaP(5,1,5,100)
  areaProductor2: AreaP(10,1,10,100)

  areaConsumidor1: AreaP(11,1,11,1)
  areaConsumidor2: AreaP(12,1,12,1)

  areaDeposito: AreaC(50,50,50,50)
robots  
  robot productor 
  comenzar
    juntarPapeles
  fin 

  robot consumidor 
  variables
    exito:boolean intentosFallidos:numero caInicio:numero avInicio:numero
  comenzar
    caInicio:=PosCa
    avInicio:=PosAv
    intentosFallidos:=0;
    mientras(intentosFallidos<8)
      intentarConsumir(exito)
      Pos(caInicio,avInicio)
      LiberarEsquina(50,50)
      si exito 
        mientras(HayPapelEnLaBolsa)
          depositarPapel
      sino 
        intentosFallidos:=intentosFallidos + 1
  fin 
variables 
  robotConsumidor1:consumidor;
  robotConsumidor2:consumidor;
  robotProductor1:productor;
  robotProductor2:productor;
comenzar
  AsignarArea(robotProductor1,areaProductor1)
  AsignarArea(robotProductor1,areaDeposito)

  AsignarArea(robotProductor2,areaProductor2)
  AsignarArea(robotProductor2,areaDeposito)
  
  AsignarArea(robotConsumidor1,areaConsumidor1)
  AsignarArea(robotConsumidor1,areaDeposito)

  AsignarArea(robotConsumidor2,areaConsumidor2)
  AsignarArea(robotConsumidor2,areaDeposito)
  
  Iniciar(robotProductor1,5,1)
  Iniciar(robotProductor2,10,1)

  Iniciar(robotConsumidor1,11,1)
  Iniciar(robotConsumidor2,12,1)
fin 
```

