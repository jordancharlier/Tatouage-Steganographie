im=imread('C:\Users\sir\Downloads\td3.jpg');
//Execution: chargement de l'image im=imread('C:\Users\sir\Downloads\td3.jpg');
//c=[10,10,12]; Message un nombre = une letre ou un chiffre 
//R=titi(im,c); R=toto(R); tata(R);
function bool=v(X,c)
    taille_A=length(c)
    [y,x,coul]= size(X);
    if y<x then
        temp=y;
        else temp=x;
    end
    if temp>taille_A then
        bool=1;
    else 
        bool=0;
       
    end
endfunction


function ValAbsolue=ValAbsolu(I)
    if I<0 then
        ValAbsolue=I*(-1);
    else
        ValAbsolue=I;
    end
    
endfunction


function [R]= toto(X) //fonction qui décrypte
    [y,x,coul]= size(X);
    X=int16(X);
    count=1;
  //en haut a droite
    if X(1,x,1)==X(2,x-1,1) then
        for i=x-1:-1:1

            R(count)=X(1,i,1)-X(2,i,1);
            R(count)=ValAbsolu(R(count));        
            count=count+1;
           // printf('Result is:=%d i=%d   x=%d X(i,1,1)=%d X(i,2,1)=%d \n ',R(i-1),i,x,X(i,1,1),X(i,2,1))
        
    end
                
  end
  //en haut a gauche
  if X(1,1,1)==X(2,2,1) then
        for i=2:x
            R(i-1)=X(i,1,1)-X(i,2,1);
            R(i-1)=ValAbsolu(R(i-1));        
            printf('Result is:=%d i=%d   x=%d X(i,1,1)=%d X(i,2,1)=%d \n ',R(i-1),i,x,X(i,1,1),X(i,2,1))
            end
    end
    //en bas a gauche
  if  X(y,1,1)==X(y-1,2,1) then
        for i=y-1:-1:1
            R(count)=X(i,1,1)-X(i,2,1);
            R(count)=ValAbsolu(R(count));        
            count=count+1;
           // printf('Result is:=%d i=%d   x=%d X(i,1,1)=%d X(i,2,1)=%d \n ',R(i-1),i,x,X(i,1,1),X(i,2,1))
        
    end
                
  end
  //en bas a droite
  if  X(y,x,1)==X(y-1,x-1,1) then
        for i=y-1:-1:1
            R(count)=X(y,i,1)-X(y-1,i,1);
            R(count)=ValAbsolu(R(count));        
            count=count+1;
        
    end
                
  end
endfunction

function [Z]= tata(X) //Traduit code en chiffre ou lettre
    taille_X=length(X);
    for i=1: taille_X
        temp=X(i);
        temp=int32(temp);
        if temp>0 then 
            if temp<27 then 
                Z(i)=temp+96;
                printf(' LETTRE %d \n',Z(i));
            end
            if temp<= 38 & temp>=27 then
                Z(i)=temp+21;
                printf(' chiffre %d \n',Z(i));
        end
    end
   
end
 Z=char(Z);
endfunction

function [Z]= titi(X,c) //fonction qui crypte
    taille_A=length(c)
    [y,x,coul]= size(X);
    bool=v(X,c);
   //TEST POUR VOIR SI LE MESSAGE EST SUFFISAMENT PETIT
    if bool==0 then
        printf('Message trop trop long NONONONONO')
        else   
    // COPIE L'IMAGE EN COMMENCANT LA COPIE DE (1;1) à (2;2)
    for i=1:x-10
      for j=1:y-10
            for couleur=1: coul
             Z(i+1,j+1,couleur)=X(i,j,couleur)              
            end   end    end

Z=uint8(Z)
im2uint8(Z)//l'image est sous forme d'un tableau à 3 dimension (RGB)
    Z(1,1,1)=Z(2,2,1)
    Z(1,1,2)=Z(2,2,2)
    Z(1,1,3)=Z(2,2,3)
    for count=taille_A+2:x-9
     for undeuxtrois=1:3
     Z(1,count,undeuxtrois)=Z(2,count,undeuxtrois) 
     Z(count,1,undeuxtrois)=Z(count,2,undeuxtrois)
    end   end
    for counter2=1:3        
        for counter=2:taille_A+1
            bool=0;
            bool=check(Z,counter);
             bool2=0;
            bool2=check2(Z,counter);
            referenceX=Z(2,counter,counter2);
            referenceY=Z(counter,2,counter2);                
//      if referenceX<217 then                
        if bool==0 then                
        Z(1,counter,counter2)=referenceX+c(counter-1)   
    else 
         Z(1,counter,counter2)=referenceX-c(counter-1)  
         end
     
     if bool2==0 then                
         Z(counter,1,counter2)=referenceY+c(counter-1)   
    else 
Z(counter,1,counter2)=referenceY-c(counter-1)
 end end end 

imshow(Z)
end
endfunction

function TF=check(Z,C) //Unifie le changement de couleur donc si un composant est sup à 217 les trois RGB dimninue de la valeur du chiffre
TF=0;
for rgb=1:3
    if Z(2,C,rgb)>=217 then
        TF=1;
    end  
end

endfunction
function TF=check2(Z,C)//PAreil mais verticalement
TF=0;
for rgb=1:3
    if Z(C,2,rgb)>=217 then
        TF=1;
    end  
end

endfunction


funcprot(0)
