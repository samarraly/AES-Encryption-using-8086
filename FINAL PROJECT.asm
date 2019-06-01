
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  row1 macro array ,w1
    local l0
    mov al,0
    mov si,0
    mov di,0
 l0:mov al,array[si]  
    mov w1[di],al
    add si,4
    inc di
    cmp di,4 
    jnz l0

 endm
 
   row2 macro array ,w2
    local l1 
    mov al,0
    mov si,1
    mov di,0
 l1:mov al,array[si]  
    mov w2[di],al
    add si,4
    inc di
    cmp di,4 
    jnz l1

 endm

  row3 macro array ,w3
    local l2
    mov al,0
    mov si,2
    mov di,0
 l2:mov al,array[si]  
    mov w3[di],al
    add si,4
    inc di
    cmp di,4 
    jnz l2

 endm

   
  row4 macro array ,w4
    local l3
    mov al,0
    mov si,3
    mov di,0
 l3:mov al,array[si]  
    mov w4[di],al
    add si,4
    inc di
    cmp di,4 
    jnz l3

  endm 
  
  shiftrow2 macro w2
   mov al,0
   mov bl,0
   mov si,0
   mov al,w2[0]
   mov bl,w2[1]
   mov w2[0],bl
   mov bl,w2[2]
   mov w2[1],bl
   mov bl,w2[3]
   mov w2[2],bl
   mov w2[3],al
   endm
   
   shiftrow3 macro w3
    mov al,0
    mov bl,0
    mov cl,0
    mov si,0
    mov al,w3[0]
    mov bl,w3[1]
    mov cl,w3[2]
    mov w3[0],cl
    mov cl,w3[3]
    mov w3[1],cl
    mov w3[2],al
    mov w3[3],bl
    endm
   shiftrow4 macro w4 
    mov al,0
    mov bl,0
    mov cl,0
    mov dl,0
    mov si,0
    mov al,w4[0]
    mov bl,w4[1] 
    mov cl,w4[2]    
    mov dl,w4[3]
    mov w4[0],dl
    mov w4[1],al
    mov w4[2],bl
    mov w4[3],cl
   endm 
   
    return macro array, w1,w2,w3,w4
    mov si,0
    mov di,0
    mov al,0
l4: mov al,w1[di]
    mov array[si],al
    add si,4
    inc di
    cmp di,4
    jnz l4
    
    mov si,1
    mov di,0
    mov al,0
l5: mov al,w2[di]
    mov array[si],al
    add si,4
    inc di
    cmp di,4
    jnz l5
   
    mov si,2
    mov di,0
    mov al,0
l6: mov al,w3[di]
    mov array[si],al
    add si,4
    inc di
    cmp di,4
    jnz l6
        
    mov si,3
    mov di,0
    mov al,0
l7: mov al,w4[di]
    mov array[si],al
    add si,4
    inc di
    cmp di,4
    jnz l7    
    
  endm  
    
    
   
   
    shiftrows macro array ,w1,w2,w3,w4
  
    row1 array,w1
    
    row2 array,w2
    
    row3 array,w3
    
    row4 array,w4  
    
    shiftrow2 w2
    shiftrow3 w3 
    shiftrow4 w4
    
    return array ,w1,w2,w3,w4   
    endm
    
       
       
       
       
       
       
       
       
       
       
       
       
       
       
       


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Mixcolumns MACRO array,key1,key2,key3,key4,column
 local l0
 local l8
    mov cx,0 
    mov si,0
 l8:mov di,0
 l0:mov al,0
    mov al,array[si]
    mov column[di],al
    inc si 
    inc di
    cmp di,4 
    jnz l0
    sub si,4
    multiplication key1,column
    
    mov array[si],dh 
    mov dh,0
    inc si   
    multiplication key2,column
 
    
    mov array[si],dh 
    mov dh,0
    inc si    
    multiplication key3,column
     
    
    mov array[si],dh 
    mov dh,0
    inc si    
    multiplication key4,column
     
    
    mov array[si],dh 
    mov dh,0
    inc si     
    cmp si,16
    jnz l8 
    
    ENDM
      
multiplication Macro key,column      
    local l4
    local l1
    local l3
    local l2
    local lend
    local end
    mov cx,0
    mov bp,0  
    
    mov dh,0 
    
    mov bl,0 
    
    mov bh,0 
    mov cl,0
      
 l4:mov bl,column[bp]
   
    mov bh,key[bp]
   
    cmp bh,002H 
    
    jnz l1
    
    shl bl,1
    
    jnc lend 
    
    xor bl,01BH
    
    jmp lend 
 
 l1:cmp bh,003h
   
    jnz l2
   
    add cl,bl
   
    shl cl,1
   
    jnc l3
   
    xor bl,01BH
 
 l3:xor bl,cl  
   
    jmp lend
 
 l2:cmp bh,001h
    
     jz lend
     
lend: xor dh,bl


   inc bp 

   cmp bp,4 

   jnz l4 
ENDM

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
addround MACRO array,key
        Local l1 
        mov cx,0
        mov si,0 
     l1:mov AL,array[si]
        mov bl,key[si]
        XOR Al,bl 
        mov Array[si],Al
        inc si
        CMP si,16
        JNZ l1 
ENDM 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


Subbytes MACRO array,sbox
     local l
     local end   
    ;GETTING THE ROW AND COL FROM STATE ARRAY
    mov al,0
    mov cx,0
    mov si,0
    mov ah,0 
    l:cmp si,16
    jz end
    mov al,array[si]
    mov bl,010H
    div bl 
    mov row,al 
    mov col,ah
    ;GETTING THE INDEX OF ELEMENTS FROM S-BOX 
    mov cl,16
    mul cl 
    add al,col 
    ;PUTTING THE ELEMENT FROM S-BOX ARRAY TO ITS CORRESPONDING INDEX IN STATE ARRAY
    mov di,ax
    mov al,sbox[di]
    mov array[si],al
    inc si
    jmp l  
    
  end:
  endm 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  


 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.CODE SEGMENT
 

INPUtt PROC
mov si,0
MOV AX,@DATA        ;for moving data to data segment
MOV DS,AX
      
XOR BX,BX        ;initially BX value is equal to 0
MOV CL,4 

l1:MOV AH,1

INT 21H 
 
CMP AL,0DH   ;compare whether the pressed key is 'ENTER' or not
JE l1     ;If it is equal to 'Enter' then stop taking first value
         
      
CMP AL,39h   ;compare the input whether it is letter or digit.39h is the ascii value of 9
jG LETTER1
          
AND AL,0FH   ;if it is digit then convert it's ascii value to real value by masking
JMP SHIFT1
          
LETTER1:          ;if it is letter then subtract 37h from it to find it's real value
SUB AL,37H

SHIFT1:
shl AL,4
SHL BX,CL    ;shift bx 4 digit left for taking next value
OR  BL,AL    ;making 'or' will add the current value with previous value


mov temp[si],al
inc si
cmp si,32
jnz l1
MOV AH,4CH


mov si,0
mov di,0
l0:mov cx,0

mov dx,0
mov cl,temp[si]
inc si
mov dl,temp[si]

shr dx,4

add cl,dl

mov array[di],cl 
inc si
inc di
cmp di,16
jnz l0 
  
INPUTt ENDP   

 SUBBYTES array, SBOX
 shiftrows array ,w1,w2,w3,w4
 MIXCOLUMNS array,KEY1,KEY2,KEY3,KEY4,COLUMN
 ADDROUND array,KEY
 
 OUTPUT PROC 
       
    mov si,0 
    xor ch,ch ; ch initially zero
    mov cx,0  ; put 4 in cx to 
    mov ah,2  ; used to print a character 
      
    l9: 
    cmp si,15
    jz endcode 
    mov bh,array[si]
    inc si
   
    
    
    for:  
    mov dl,bh  ; put the first element w need to print in dl 
    shr dl,4   ;shift dl right by 4  
    shl bx,4   ; shift bx left by 4  
    
    cmp dl,10  ;cmp by 10 to see ifif it's a letter 
    jge Letter ; if its a letter jump to (if greater than or equal 10 then a letter )  
    
    ;if not then a digit
    
    add dl,48  ; getting the ascii value of the digit by adding 48 to the digit 
    int 21h    ; print it 
    jmp endloop 
            
            
    letter:
    add dl,55   ; getting the axcii value of the letter by adding 55 to the letter 
    int 21h     ; print it 
    
    endloop: ; repeat for next value 
    inc cx 
    cmp cx,2
    jnz for
    mov cx,0
    jmp l9
    

               
  endcode: mov ah,4ch ; exit code 
           int 21h 
           
    

 OUTPUT endp
 ret
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 .DATA SEGMENT
    temp db 32 dup(00h)
   ; array db 032H,043H,0f6H,0a8H,088H,05aH,030H,08dH,031H,031H,098H,0a2H,0e0H,037H,007H,034H
    array DB 16 DUP(00h)
    key1 db 002H,003H,001H,001H
    key2 db 001H,002H,003H,001H
    key3 db 001H,001H,002H,003H
    key4 db 003H,001H,001H,002H
    column db 00H,00H,00H,00H
    key db 16 DUP (0FFH) 
    row db 0H
    col db 0H 
    sbox db 063H,07cH,077H,07bH,0f2H,06bH,06fH, 0c5H,030H,01H,067H,02bH,0feH,0d7H,0abH,076H,0caH,082H,
    db  0c9H,07dH,0faH,059H,047H,0f0H,0adH,0d4H,0a2H,0afH,09cH,0a4H,072H,0c0H,0b7H,0fdH,093H,026H,036H,
    db  03fH,0f7H,0ccH,034H,0a5H,0e5H,0f1H,071H,0d8H,031H,015H,004H,0c7H,023H,0c3H,018H,096H,005H,09aH,
    db  007H,012H,080H,0e2H,0ebH,027H,0b2H,075H,009H,083H,02cH,01aH,01bH,06eH,05aH,0a0H,052H,03bH,0d6H,
    db  0b3H,029H,0e3H,02fH,084H,053H,0d1H,000H,0edH,020H,0fcH,0b1H,05bH,06aH,0cbH,0beH,039H,04aH,04cH,
    db  058H,0cfH,0d0H,0efH,0aaH,0fbH,043H,04dH,033H,085H,045H,0f9H,002H,07fH,050H,03cH,09fH,0a8H,051H,
    db  0a3H,040H,08fH,092H,09dH,,038H,0f5H,0bcH,0b6H,0daH,021H,010H,0ffH,0f3H,0d2H,0cdH,00cH,013H,0ecH,
    db  05fH,097H,044H,017H,0c4H,0a7H,07eH,03dH,064H,05dH,019H,073H,060H,081H,04fH,0dcH,022H,02aH,090H,
    db  088H,046H,0eeH,0b8H,014H,0deH,05eH,00bH,0dbH,0e0H,032H,03aH,00aH,049H,006H,024H,05cH,0c2H,0d3H
    db  0acH,062H,091H,095H,0e4H,079H,0e7H,0c8H,037H,06dH,08dH,0d5H,04eH,0a9H,06cH,056H,0f4H,0eaH,065H,
    db  07aH,0aeH,008H,0baH,078H,025H,02eH,01cH,0a6H,0b4H,0c6H,0e8H,0ddH,074H,01fH,04bH,0bdH,08bH,08aH,
    db  070H,03eH,0b5H,066H,048H,003H,0f6H,00eH,061H,035H,057H,0b9H,086H,0c1H,01dH,09eH,0e1H,0f8H,098H,
    db  011H,069H,0d9H,08eH,094H,09bH,01eH,087H,0e9H,0ceH,055H,028H,0dfH,08cH,0a1H,089H,00dH,0bfH,0e6H,
    db  042H,068H,041H,099H,02dH,00fH,0b0H,054H,0bbH,016H  
    w1 db 0H,0H,0H,0H    
    w2 db 0H,0H,0H,0H  
    w3 db 0H,0H,0H,0H  
    w4 db 0H,0H,0H,0H