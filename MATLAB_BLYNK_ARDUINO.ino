#define BLYNK_TEMPLATE_ID "TMPLlJQbctQ8"
#define BLYNK_DEVICE_NAME "CONTROL ROBOT"
#define BLYNK_AUTH_TOKEN "kzgkmobBvsh8AZdHg5j7StmFpuNJLz6m"

// Comment this out to disable prints and save space
#define BLYNK_PRINT Serial
//Variables de concexion con Matlab
#include <ESP8266WiFi.h>
#define SERVER_PORT 80

//---------PARA BLYNK-----------------------------
#include <BlynkSimpleEsp8266.h>
char auth[] = BLYNK_AUTH_TOKEN;

int depth =20;
BlynkTimer timer;
//----------CONECTAR WIFI--------------------------
const char* ssid = "FamiliaVera";      // SSID
const char* password = "B4ct3r10l0g142020"; //Password
//const char* ssid = "Rolando";      // SSID
//const char* password = "rolandoup"; //Password
WiFiServer server(SERVER_PORT); //object server port


IPAddress ip(192,168,1,10);      //ip asignada por el router
IPAddress gateway(192,168,1,1);   
IPAddress subnet(255,255,255,0);
//----------------------------------------------------------------------------------------------------------------
//Varaibles globales
float q[6];//Almacena los valores articulares de la cinematica inversa q[6]={1,pi,pi,pi,pi,pi}
float qt[100];//almacena los valores articulares interpolados
float qt1[100];//almacena los valores articulares q1
float qt2[100];//almacena los valores articulares q2
float qt3[100];//almacena los valores articulares q3
float qt4[100];//almacena los valores articulares q4
float qt5[100];//almacena los valores articulares q5
float Bpinza[10];//Almacena el valor de la pinza enviado desde Blynk
int posPinza[10];//Almacena el indice donde en el que se da el punto durante la trayectoria
byte Bpos=0;//recorre los vectores Bq1,......Bpinza
int pos=0;

//Variables globales para BLYNK (Enseñanza de puntos)
byte modo=0;//modo de mover o enseñar
byte gpos=0;//para controlar cuando se guardan las posiciones
byte EjeMov=0;//Ejecutar movimiento
byte demo=0;//0 stop   1 se mueve el robot articulacion por articulacion
float Bq1[10];//Almacena el valor de q1 enviado desde Blynk
float Bq2[10];
float Bq3[10];
float Bq4[10];
float Bq5[10];
//cuando se esta enseñando y se calibra las posisiones articulares y no se calibra una posicion
byte pres1=0;// 0---> cuando no se ha presionado durante Bpos     1---->cuando ya presiono la articulacion
byte pres2=0;
byte pres3=0;
byte pres4=0;
byte pres5=0;
byte pres6=0;


//PARA LOS SERVOS
#include <Adafruit_PWMServoDriver.h>
Adafruit_PWMServoDriver servos = Adafruit_PWMServoDriver(0x40);//codigo de la PCA por defecto
//se definen los pines de la PCA a los que estan conectados los servos
int servo1 = 0;  // 1er grado libertad
int servo2 = 2; // 2do grado libertad
int servo3 = 4;  // 3er grado libertad
int servo4 = 6;  // 4to grado libertad
int servo5 = 8;  // 5to grado libertad
int servo6 = 10;  // pinza


// Se declara variables de cotrol para trabajar los servomotores con angulos y no con señal pwm
//para el cero y el 180 de los servos 149 A 590 
//servo1
int posA1 = 90;           
int posB1 = 570;    
//servo2
int posA2[2] ={143,145};//posA2[0] para 0° 90°  ######   posA2[1] para 90° 180°         
int posB2[2] ={583,583};//posB2[0] para 0° 90°  ######   posB2[1] para 90° 180°
//servo3
int posA3 = 145;           
int posB3 = 595;
//servo4
int posA4 = 135;           
int posB4 = 615;        
//servo5
int posA5 = 125;           
int posB5 = 600;
//servo6
int posA6 = 125;           
int posB6 = 605; 

int pinvalue[504];//vector que recibe los angulos
#define R 12
#define G 14
#define B 13


Adafruit_PWMServoDriver pwm = Adafruit_PWMServoDriver();

//===============================INTERRUPCIONES DE BLYNK WRITE===============================================
BLYNK_WRITE(V0)//servo1
{
  pres1=1;//indica que se presiono el pin virtual V0
  int pinValue0 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  { 
      int duty=map(pinValue0,0,180,posA1,posB1);
      pwm.setPWM(servo1, 0, duty);
  }
  
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo1
  {
    Bq1[Bpos]=pinValue0;

  }
  
  

}
BLYNK_WRITE(V1)//servo 2
{
  pres2=1;//indica que se presiono el pin virtual V1
  int pinValue1 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  {
     if(pinValue1<=135)
     {
      int duty=map(pinValue1,0,270,posA2[0],posB2[0]);
      pwm.setPWM(servo2, 0, duty);      
     }
     if(pinValue1>135)
     {
      int duty=map(pinValue1,0,270,posA2[1],posB2[1]);
      pwm.setPWM(servo2, 0, duty);      
     }     
      
          
  }
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo2
  {
    Bq2[Bpos]=pinValue1;
  }  

}
BLYNK_WRITE(V2)//servo 3
{
  pres3=1;//indica que se presiono el pin virtual V2
  int pinValue2 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  { 
      int duty=map(pinValue2,0,270,posA3,posB3);
      pwm.setPWM(servo3, 0, duty);    
  }
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo3
  {
    Bq3[Bpos]=pinValue2;
  }   

}
BLYNK_WRITE(V3)//servo 4
{
  pres4=1;//indica que se presiono el pin virtual V3
  int pinValue3 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  {  
      int duty=map(pinValue3,0,180,posA4,posB4);
      pwm.setPWM(servo4, 0, duty);    
  }
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo4
  {
    Bq4[Bpos]=pinValue3;
  }  

}


BLYNK_WRITE(V4)//servo 5
{
  pres5=1;//indica que se presiono el pin virtual V4
  int pinValue4 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  {  
      int duty=map(pinValue4,0,180,posA5,posB5);
      pwm.setPWM(servo5, 0, duty);    
  }
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo5
  {
    Bq5[Bpos]=pinValue4;
  }  

}

BLYNK_WRITE(V5)//servo 6
{
   pres6=1;//indica que se presiono el pin virtual V5
  int pinValue5 = param.asInt();
  if(gpos==0 && EjeMov==0 && demo==0)//mover
  {  
      int duty=map(pinValue5,0,180,posA6,posB6);
      pwm.setPWM(servo6, 0, duty);    
  }
  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//guardar posicion transitoria del servo6
  {
    Bpinza[Bpos]=pinValue5;
  }  

}

BLYNK_WRITE(V6)//MODO(0 mover   1 enseñar)
{
  modo=param.asInt();
  if(modo==0)
  {
    Bpos=0;
  }
  
}

BLYNK_WRITE(V7)//Ejecutar movimiento de posiciones
{
  EjeMov=param.asInt();//Lee el valor del pin virtual V7
  if(modo==1 && gpos==0 && EjeMov==1 && demo==0)
  {
    int j_cubico;
    //Para qt1
    j_cubico=interpolador_cubico(Bpos,10,Bq1);//(int n, float npuntos, float q[])
    for(int i=0;i<j_cubico;i++)
    {
      qt1[i]=qt[i];
      
    }
    //para qt2
    j_cubico=interpolador_cubico(Bpos,10,Bq2);
    for(int i=0;i<j_cubico;i++)
    {
      qt2[i]=qt[i];      
    }
    //para qt3
    j_cubico=interpolador_cubico(Bpos,10,Bq3);
    for(int i=0;i<j_cubico;i++)
    {
      qt3[i]=qt[i];      
    }
    //para qt4
    j_cubico=interpolador_cubico(Bpos,10,Bq4);
    for(int i=0;i<j_cubico;i++)
    {
      qt4[i]=qt[i];      
    } 
    //para qt5
    j_cubico=interpolador_cubico(Bpos,10,Bq5);
    for(int i=0;i<j_cubico;i++)
    {
      qt5[i]=qt[i];      
    }
  //----------------------------------------------------------------------------------
  //Se ejcuta el movimiento de los valores articulares qt1,.....qt5
  movimiento(j_cubico);//se realiza las trayectorias de interpolacion          
    
  }
  
  
}

BLYNK_WRITE(V8)//DEMO
{
  demo=param.asInt();//Lee el valor del pin virtual V8
  if(modo==0 && gpos==0 && EjeMov==0 && demo==1)
  {
    movimientoDemo();
  } 
}
BLYNK_WRITE(V9)//guardar posicion (0 calibrar y mueve servos  1 guarda posicion impide mover servos)
{
  gpos=param.asInt();//Lee el valor del pin virtual V9 
  if(modo==1 && gpos==1 && EjeMov==0 && demo==0)//condicion para guardar la posicion
  {
    //inicicalmente se tienen que presionar todos los pines virtuales cuando Bpos=0 es decir la posicion numero 0
    if(pres1==0 && Bpos>=1)//Si no se ha presionado el pin virtual q1
    {
      Bq1[Bpos]=Bq1[Bpos-1];
    }    
    if(pres2==0 && Bpos>=1)//Si no se ha presionado el pin virtual q2
    {
      Bq2[Bpos]=Bq2[Bpos-1];
    }
    if(pres3==0 && Bpos>=1)//Si no se ha presionado el pin virtual q3
    {
      Bq3[Bpos]=Bq3[Bpos-1];
    } 
    if(pres4==0 && Bpos>=1)//Si no se ha presionado el pin virtual q4
    {
      Bq4[Bpos]=Bq4[Bpos-1];
    }   
    if(pres5==0 && Bpos>=1)//Si no se ha presionado el pin virtual q5
    {
      Bq5[Bpos]=Bq5[Bpos-1];
    } 
    if(pres6==0 && Bpos>=1)//Si no se ha presionado el pin virtual q6(PINZA)
    {
      Bpinza[Bpos]=Bpinza[Bpos-1];
    }    



    //-----------------------------------------------------
    Bpos=Bpos+1;
    if(Bpos>9)
    {
      Bpos=9; 
    }
  }

  if(modo==1 && gpos==0 && EjeMov==0 && demo==0)//Cuando el boton vuelve a cero se reinicia los indicadores de presionar boton
  {
    pres1=0;
    pres2=0;
    pres3=0;
    pres4=0;
    pres5=0;
    pres6=0;
  }
  
}

//====================================================VOID SETUP=============================================
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  Blynk.begin(auth, ssid, password);
  servos.begin();
  servos.setPWMFreq(60); 
  WiFi.config(ip, gateway, subnet);  //asigna ip fija
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
  Serial.println("Server started");
  pinMode(R, OUTPUT);
  pinMode(G, OUTPUT);
  pinMode(B, OUTPUT);
  analogWrite(G,HIGH);  

}

//================================================VOID LOOP=========================================================
void loop() {
  Blynk.run();
  WiFiClient client = server.available();
  if (client)//??
  {
    delay(5);//Se sincroniza con el TimeOut de Matlab
      while (client.available())
      { 
           //------------------------------------------------------------------------------------------------------------
          float data = client.read();
          int n;//numero de puntos de interes del efector final
          int npuntos;//Numero de puntos para la interpolacion
          int ndata;//Numero de datos enviados por Matlab
          float Rpuntos[100];
          if(data>=0)//Verifica que el valor sea mayor o igual a cero
          {
            if(pos==0)//recibe el numero de puntos de interes del efector final
            {
              n=data;//numero de puntos de interes del efector final  
              ndata=(n*6)+2;//Numero de datos enviados por Matlab       
            }
            if(pos==1)//recibe el numero de puntos para la interpolacion (idealmente npuntos=10)
            {
              npuntos=data;          
            }
            if(pos>=2 && pos<ndata)//Recibe los puntos X Y Z Pinza Angulo CODO(0 --->-1)
            {
              Rpuntos[pos]=data;
            }
            if(pos==(ndata-1))//----------------------SE HACEN LOS CALCULOS DE CINEMATICA, INTERPOLACION Y SE EJECUTA EL MOVIMIENTO------------------------------
            {
              //==========================================================================================================================================
              //cinematica inversa
              int ipf=2;//indice para descomponer Rpuntos[] a pf[]
              float pf[3];//punto del efector final
              float q1[n];//Valores articulares para q1 obtenidos de la cinematica inversa
              float q2[n];
              float q3[n];
              float q4[n];
              float q5[n];//Valores articulares para q5 obtenidos de la cinematica inversa
              float pinza[n];
              float Angulo[n];
              float CODO[n];
              for(int i=0;i<n;i++)
              {
                pf[0]=Rpuntos[ipf];//obtenemos X 
                pf[1]=Rpuntos[ipf+1];//obtenemos Y          
                pf[2]=Rpuntos[ipf+2];//obtenemos Z              
                Bpinza[i]=Rpuntos[ipf+3];//obtenemos el valor de la pinza
                Angulo[i]=(-1.0*PI/180.0)*(Rpuntos[ipf+4]);//obtenemos el valor del angulo de acercamiento del efector final
                CODO[i]=Rpuntos[ipf+5];//obtenemos el CODO 
                if(CODO[i]==0)
                {
                  CODO[i]=-1;
                }
                ipf=ipf+6;//se pasa al siguente punto del vector Rpuntos
                cinematica_inversa_punto1(pf,CODO[i],Angulo[i]);
                q1[i]=q[1];//Valor retornado q por la cinematica inversa
                q2[i]=q[2];
                q3[i]=q[3];
                q4[i]=q[4];
                q5[i]=q[5];//Valor retornado q por la cinematica inversa
                
            
              }
              //---------------------------------------------------------------
              //INTERPOLACION utilizando los valores articulares q1,...q5 y obteniendo qt1,....qt5
              int j_cubico;//indice de obtener qt, recorre el vector qt
              //Para qt1
              j_cubico=interpolador_cubico(n,npuntos,q1);//valores interpolados qt
              for(int i=0;i<j_cubico;i++)
              {
                qt1[i]=qt[i];//Se retorna el valor de qt a qt1 de la funcion (interpolador_cubico)    
              }
              //Ajuste de ceros para qt1
               AJUSTE_CEROS(j_cubico,1);//(valor_articular, longitud_vector,articulacion)
            
              //Para qt2
              j_cubico=interpolador_cubico(n,npuntos,q2);//valores interpolados qt
              for(int i=0;i<j_cubico;i++)
              {
                qt2[i]=qt[i];//Se retorna el valor de qt a qt2 de la funcion (interpolador_cubico)   
              }
              //Ajuste de ceros para qt2
              AJUSTE_CEROS(j_cubico,2);//(valor_articular, longitud_vector,articulacion)
            
              //Para qt3
              j_cubico=interpolador_cubico(n,npuntos,q3);//valores interpolados qt
              for(int i=0;i<j_cubico;i++)
              {
                qt3[i]=qt[i];//Se retorna el valor de qt a qt3 de la funcion (interpolador_cubico)  
              }
              //Ajuste de ceros para qt3
              AJUSTE_CEROS(j_cubico,3);//(valor_articular, longitud_vector,articulacion)
            
              //Para qt4
              j_cubico=interpolador_cubico(n,npuntos,q4);//valores interpolados qt
              for(int i=0;i<j_cubico;i++)
              {
                qt4[i]=qt[i];//Se retorna el valor de qt a qt4 de la funcion (interpolador_cubico) 
              }
              //Ajuste de ceros para qt4
              AJUSTE_CEROS(j_cubico,4);//(valor_articular, longitud_vector,articulacion)
            
              //Para qt5
              j_cubico=interpolador_cubico(n,npuntos,q5);//valores interpolados qt
              for(int i=0;i<j_cubico;i++)
              {
                qt5[i]=qt[i];//Se retorna el valor de qt a qt5 de la funcion (interpolador_cubico)    
              }
              //Ajuste de ceros para qt5  
              AJUSTE_CEROS(j_cubico,5);//(valor_articular, longitud_vector,articulacion) 
              //----------------------------------------------------------------------------------
              //Se ejcuta el movimiento de los valores articulares qt1,.....qt5
              movimiento(j_cubico);//se realiza las trayectorias de interpolacion
                               
    
    
    
    
              //=================================================================================================================================================         
            }
    
            pos=pos+1;//Se incrementa el indice de posicion que recorre los datos recibidos de Matlab        
            
          }  
         
      }
      if (server.hasClient())
      {
        Serial.println("hasClient");
        return;
      }
    }
//Se reinicia la variable de posicion para la recepcion de datos de matlab
pos=0;

}

//=====================================FUNCIONES===============================================================
void cinematica_inversa_punto1(float pf[], float CODO, float Angulo)
{
  //pf es el punto del efector final que contienes los valores cartesianos x y z
  //CODO (1 ó -1) 1 codo abajo   -1 codo arriba
  //Angulo es el valor angular que se forma entre x5 del efector con la vertical Z0
  //la funcion devuelve los valores articulares [q1,q2,q3,q4,q5]
//  float q[6];

  //MEDIDAS DEL ROBOT
  float L[]={1, 163.79, 16.5, 32.5, 130, 135, 117.6};//L1 L2 L3A L3 L4 L5
  //para obtener q1
  float mb=sqrt(pow(pf[1],2)+pow(pf[0],2));
  float Db=sqrt(pow(mb,2)-pow(L[2],2));
  float beta1=atan2(L[2],Db);
  float alpha1=atan2(-pf[0],pf[1]);
  q[1]=alpha1-beta1;//q1
  //para obtener el punto de la muñeca
  float x5[]={-cos(Angulo)*sin(q[1]), cos(Angulo)*cos(q[1]), sin(Angulo)};
  float pm[]={(pf[0]-x5[0]*L[6]), (pf[1]-x5[1]*L[6]), (pf[2]-x5[2]*L[6])};
  float m=sqrt(pow(pm[1],2)+pow(pm[0],2));
  float D=sqrt(pow(m,2)-pow(L[2],2));

  //para obtener q3
  float J=sqrt(pow((D-L[3]),2)+(pow(pm[2]-L[1],2)));
  float cosq3=(pow(J,2)-pow(L[4],2)-(pow(L[5],2)))/(2*L[4]*L[5]);
  float senq3=CODO*sqrt(1.0-(pow(cosq3,2)));
  q[3]=atan2(senq3,cosq3);//q3
  
  //para obtener q2
  float beta2=atan2((L[5]*senq3),(L[4]+L[5]*cosq3));
  float alpha2=atan2((pm[2]-L[1]),(D-L[3]));
  q[2]=alpha2-beta2;//q2
  //para q4
  q[4]=0;
  //para q5
  q[5]=Angulo-q[3]-q[2];
  

 
}

//----------------------------------------------------------------------------------------------
int interpolador_cubico(int n, float npuntos, float q[])
{
    //La funcion recibe n(numero de puntos del efector); q[](Es el vector con los valores articulares dado por la cinematica inversa)
    //npuntos(Es numero de puntos para hacer interpolaciones debe ser mayor a 1)
    //Retorna la variable j que indica la longitud del vector de interpolacion
    //Retorna la variable qt que contiene los valores articulares interpolados en Radianes
    float t[n];
    for(int i=0;i<n;i++)
    {
      t[i]=i+1;
    }
    int m=(npuntos*(n-1))+(n-1);//se calculan el numero de posiciones que se obtinen con la interpolacion

    //trayectoria1=interpolador_cubico_dibujo(t,npuntos,q(1,:));%TRAYECTORIA DE LA ARTICULACION 1
    //P=interpolador_cubico(t,q);
    
    float qp[n];
    qp[0]=0;//velocidad inicial
    qp[n-1]=0;//velocidad final

    float signo1;
    float signo2;
    
    for(int i=1;i<(n-1);i++)//para recorrer las columnas
    {
      signo1=(q[i]-q[i-1])/abs((q[i]-q[i-1]));
      signo2=(q[i+1]-q[i])/abs((q[i+1]-q[i]));

      if(signo1==signo2 || (q[i-1]==q[i]) || (q[i]==q[i+1]))
      {
        qp[i]=0.5*(((q[i+1]-q[i])/(t[i+1]-t[i]))+((q[i]-q[i-1])/(t[i]-t[i-1])));        
      }
      else
      {
        qp[i]=0;        
      }
    
    }
    //obtiene los coeficientes de los polinomios
    float Pti[n-1];
    float Ptim1[n-1];
    float Pa[n-1];
    float Pb[n-1];
    float Pc[n-1];
    float Pd[n-1];
    int j=0;//indice para obtener qt, recorre el vector qt
//    float qt[m];//almacena los valores articulares interpolados
    for(int i=0;i<(n-1);i++)//para recorrer las columnas
    {
      float ti=t[i];//tiempo inicial intervalo
      float tii=t[i+1];//tiempo final intervalo
      float T=tii-ti;//perido que dura el intervalo}
      Pti[i]=ti;
      Ptim1[i]=tii;
      Pa[i]=q[i];
      Pb[i]=qp[i];
      Pc[i]=((3.0/pow(T,2))*(q[i+1]-q[i]))-((1.0/T)*(qp[i+1]+(2*qp[i])));
      Pd[i]=((-2.0/pow(T,3))*(q[i+1]-q[i]))+((1.0/pow(T,2))*(qp[i+1]+qp[i]));
      //Guardamos la posicion del indice j para mover la pinza
      if(i==0)
      {
        posPinza[i]=j;        
      }
      if(i>=1)
      {
        posPinza[i]=j-1;
      }
      

      //Obtencion de los valores articulares interpolados para q
      float inc=(tii-ti)/npuntos;//se obtiene el incremento
      for(float tt=ti; tt<=tii; tt=tt+inc)
      {
        qt[j]=Pa[i]+(Pb[i]*(tt-ti))+(Pc[i]*pow((tt-ti),2))+(Pd[i]*pow((tt-ti),3));
        j=j+1;
      }
      //Guardamos la posicion del indice j para mover la pinza
      if(i==(n-2))
      {
        posPinza[n-1]=j-1;
        
      }

    }

    return j;

}

//-----------------------------------------------------------------------------------------------------
void AJUSTE_CEROS(int j_cubico, int art)
{
  //RECIBE LOS VALORES ARTICULARES qt1 qt2 qt3 qt4 qt5 EN RADIANES Y LOS AJUSTA A LA POSICION DEL SERVOMOTOR 
  //Y RETORNA UN VALOR ENTERO PARA CADA ARTICULACION
  //j_cubico;indice de obtener qt, recorre el vector qt; es el tamaño del vector q
  //art: Es el numero de la articulacion para ajustar (1,2,3,4,5)
  //q[]={1,PI/7.0,PI/3.0,PI/9.0,PI/4.0,PI}; RECIBE
  //q[]={115.7143  105.0000   70.0000  135.0000         0}; DEVUELVE
  
  //para q(1) 1er grado libertad
  if(art==1)
  {
    
    for(int i=0;i<j_cubico;i++)
    {
      qt1[i]=qt1[i]*(180.0/PI);//Convierte de radianes a grados
      if(qt1[i]==-180 || qt1[i]==180)
      {
        qt1[i]=0;
      } 
    
      if(qt1[i]<-90)
      {
        qt1[i]=-90;    
      }
          
      
      if(qt1[i]>90)
      {
        qt1[i]=90;
      }
      if(qt1[i]>=-90 && qt1[i]<=90)
      {
        qt1[i]=qt1[i]+90;
      }
      
    }

  }
  


  //para q(2) 2do grado libertad
  if(art==2)
  {
    for(int i=0;i<j_cubico;i++)
    {
      qt2[i]=qt2[i]*(180.0/PI);//Convierte de radianes a grados
      if(qt2[i]<0)
      {
        qt2[i]=0;    
      }
        
    
      if(qt2[i]>180)
      {
        qt2[i]=180;
      }
      if(qt2[i]>=0 && qt2[i]<=180)
      {
        qt2[i]=qt2[i]+45;
      }

      
    }
    

  }

  //para q(3) 3er grado libertad
  if(art==3)
  {
    for(int i=0;i<j_cubico;i++)
    {
        qt3[i]=qt3[i]*(180.0/PI);//Convierte de radianes a grados
        qt3[i]=-1.0*qt3[i];//cambiamos el signo negativo
        if(qt3[i]<-90)
        {
          qt3[i]=-90;
        }
        if(qt3[i]>150)//rango de 240°
        {
          qt3[i]=150;
        }
        if(qt3[i]>=-90 && qt3[i]<=150)
        {
          qt3[i]=qt3[i]+90;//ajuste del cero del servo
        }
        
        
    }
    
  

  }
  //para q(4) 4to grado libertad
  if(art==4)
  {
    for(int i=0;i<j_cubico;i++)
    {
        qt4[i]=qt4[i]*(180.0/PI);//Convierte de radianes a grados
        if(qt4[i]<0)
        {
          qt4[i]=0;
        }
        if(qt4[i]>180)
        {
          qt4[i]=180;
        }
        if(qt4[i]>=0 && qt4[i]<=180)
        {
          qt4[i]=180-qt4[i];//ajuste del cero del servo
        }
        
    }
    
  }

  //para q(5) 5to grado libertad
  if(art==5)
  {
    for(int i=0;i<j_cubico;i++)
    {
        qt5[i]=qt5[i]*(180.0/PI);//Convierte de radianes a grados
        if(qt5[i]<-90)
        {
          qt5[i]=-90;
        }
        if(qt5[i]>90)
        {
          qt5[i]=90;
        }
        if(qt5[i]>=-90 && qt5[i]<=90)
        {
            qt5[i]=qt5[i]+90;//ajuste del cero del servo
            qt5[i]=180-qt5[i];//al girar q4 180° es necesario ajustar q5
        }
        
        
    }
   
  }


//  for(int i=1;i<6;i++)
//  {
//    Serial.println(q[i],4);
//  }
}


//----------------------------------------------------------------------------------
void movimiento(int j_cubico)
{
  byte in=0;//indice para la pinza
  
  for(int i=0;i<j_cubico;i++)
  {
      //para el servo1
      int duty=map(qt1[i],0,180,posA1,posB1);
      pwm.setPWM(servo1, 0, duty);
      //para el servo2
     if(qt2[i]<=135)
     {
      duty=map(qt2[i],0,270,posA2[0],posB2[0]);
      pwm.setPWM(servo2, 0, duty);      
     }
     if(qt2[i]>135)
     {
      duty=map(qt2[i],0,270,posA2[1],posB2[1]);
      pwm.setPWM(servo2, 0, duty);      
     }      
      //para el servo3
      duty=map(qt3[i],0,270,posA3,posB3);
      pwm.setPWM(servo3, 0, duty);
      //para el servo4
      duty=map(qt4[i],0,180,posA4,posB4);
      pwm.setPWM(servo4, 0, duty);
      //para el servo5
      duty=map(qt5[i],0,180,posA5,posB5);
      pwm.setPWM(servo5, 0, duty);
      delay(50);

      //Movemos la pinza
      if(posPinza[in]==i)
      {
        delay(500);
        int duty=map(Bpinza[in],0,180,posA6,posB6);
        pwm.setPWM(servo6,0,duty);
        in=in+1;
        delay(500);
      }      

    
  }
  pos=0;

   
}
//----------------------------------------------------------------------------------
void movimientoDemo()
{
      //se mueven las articulaciones una a una 
      int duty=map(0,0,180,posA6,posB6);//pinza
      pwm.setPWM(servo6, 0, duty);
      duty=map(90,0,180,posA5,posB5);
      pwm.setPWM(servo5, 0, duty);
      duty=map(180,0,180,posA4,posB4);
      pwm.setPWM(servo4, 0, duty);
      duty=map(90,0,270,posA3,posB3);
      pwm.setPWM(servo3, 0, duty);
      duty=map(135,0,270,posA2[0],posB2[0]);
      pwm.setPWM(servo2, 0, duty);
      //servo1
      for(int i=90;i<=180;i++)
      {
          duty=map(i,0,180,posA1,posB1);
          pwm.setPWM(servo1, 0, duty);
          delay(60);
      }
      for(int i=180;i>=0;i--)
      {
          duty=map(i,0,180,posA1,posB1);
          pwm.setPWM(servo1, 0, duty);
          delay(60);
      }
      for(int i=0;i<=90;i++)
      {
          duty=map(i,0,180,posA1,posB1);
          pwm.setPWM(servo1, 0, duty);
          delay(60);
      }
    
      //servo2
      for(int i=135;i>=90;i--)
      {
          duty=map(i,0,270,posA2[0],posB2[0]);
          pwm.setPWM(servo2, 0, duty);
          delay(50);
      }
      for(int i=90;i<=135;i++)
      {
          duty=map(i,0,270,posA2[0],posB2[0]);
          pwm.setPWM(servo2, 0, duty);
          delay(50);
      }
      //servo3
      for(int i=90;i<=220;i++)
      {
          duty=map(i,0,270,posA3,posB3);
          pwm.setPWM(servo3, 0, duty);
          delay(50);
      }
      for(int i=220;i>=90;i--)
      {
          duty=map(i,0,270,posA3,posB3);
          pwm.setPWM(servo3, 0, duty);
          delay(50);
      }
    
      //servo4
      for(int i=180;i>=0;i--)
      {
          duty=map(i,0,180,posA4,posB4);
          pwm.setPWM(servo4, 0, duty);
          delay(60);
      }
      for(int i=0;i<=180;i++)
      {
          duty=map(i,0,180,posA4,posB4);
          pwm.setPWM(servo4, 0, duty);
          delay(60);
      }
      //servo5
      for(int i=90;i<=180;i++)
      {
          duty=map(i,0,180,posA5,posB5);
          pwm.setPWM(servo5, 0, duty);
          delay(60);
      }
      for(int i=180;i>=90;i--)
      {
          duty=map(i,0,180,posA5,posB5);
          pwm.setPWM(servo5, 0, duty);
          delay(60);
      }
      //Servo6
      duty=map(50,0,180,posA6,posB6);
      pwm.setPWM(servo6, 0, duty);
      delay(500);
      duty=map(0,0,180,posA6,posB6);
      pwm.setPWM(servo6, 0, duty);
      delay(60);      

}
