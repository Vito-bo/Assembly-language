data segment
message db 'hello world','$'
data ends
stack segment para stack 'stack'
db 1024 dup(?)
stack ends
code segment 
assume cs:code,ds:data,ss:stack,es:data
begin:mov ax,data
      mov ds,ax
	  mov es,ax
	  mov dx,offset message
	  mov ah,9
	  int 21h
	  mov ah,4ch
	  int 21h
code ends
     end begin
	 