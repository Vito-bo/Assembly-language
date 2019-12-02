实验二：典型循环程序：数组、最大数、负数个数
1.	程序2-1：改进“实验一”中十进制数显示程序（程序1-3），以实际位数在屏幕显示十进制数（去掉前面多余的0）。
data segment
d dw 20
data ends

stack segment stack
    db 1024 dup(0)
stack ends

code segment
	assume cs:code,ds:data,ss:stack
	
begin: 		mov ax,data
            mov ds,ax
			mov ax,d
			mov bl,0  ;位数
			mov cl,10 ;除数
f1:			div cl
			push ax  
			mov ah,0
			inc bl
			cmp al,0
			jnz f1
f2:			pop dx
			mov dl,dh
			add dl,30h
			mov ah,2
			int 21h
			dec bl
			cmp bl,0
			jnz f2
exit:		mov ah,4ch
			int 21h
code ends
end  begin 
 
2.	程序2-2：改进程序2-1，以带符号数形式显示十进制数。
data segment
d dw 20
data ends

stack segment stack
    db 1024 dup(0)
stack ends

code segment
	assume cs:code,ds:data,ss:stack
	
begin: 		mov ax,data
            mov ds,ax
			mov ax,d
			cmp ax,0
			jns f    ;判断是否是负数
			mov ah,2
			mov dl,'-'  ;如果是负数，则打印-
			int 21h
			mov ax,0   ;将负数转成正数
			sub ax,d
f:			mov bl,0
			mov cl,10
f1:			div cl
			push ax
			mov ah,0
			inc bl
			cmp al,0
			jnz f1
f2:			pop dx
			mov dl,dh
			add dl,30h
			mov ah,2
			int 21h
			dec bl
			cmp bl,0
			jnz f2
exit:		mov ah,4ch
			int 21h
code ends
end  begin 
 
3.	程序2-3：数组显示程序，要求：在数据段定义一个数组，其中存放若干个dw类型数据，编写程序将数组中元素以十进制形式显示。
data segment
N dw 6 dup(12,15,48,123,145,2)
data ends

stack segment stack
    db 1024 dup(0)
stack ends

code segment
	assume cs:code,ds:data,ss:stack
	
begin: 		mov ax,data
            mov ds,ax
			lea si,N
			mov cl,10
			mov ch,6   ;数组里元素的个数
f:			mov ax,[si]
			mov bl,0
f1:			div cl
			push ax
			mov ah,0
			inc bl
			cmp al,0
			jnz f1
f2:			pop dx
			mov dl,dh
			add dl,30h
			mov ah,2
			int 21h
			dec bl
			cmp bl,0
			jnz f2
			mov ah,2
			mov dl,' '
			int 21h
			inc si
			inc si
			dec ch
			cmp ch,0
			jnz f
exit:		mov ah,4ch
			int 21h
code ends
end  begin 
 
4.	程序2-4：求数组中元素最大数程序，要求：在数据段定义一个数组，其中存放若干个dw类型数据，编写程序求数组中元素最大数，并将数组元素及最大数输出。
data segment
N dw 6 dup(12,15,48,123,145,2)
data ends

stack segment stack
    db 1024 dup(0)
stack ends

code segment
	assume cs:code,ds:data,ss:stack
	
begin: 		mov ax,data
            mov ds,ax
			lea si,N
			mov ch,6
			mov ax,[si]  ;将数组第一个元素赋值
s1:			inc si
			inc si
			cmp ax,[si]  ;比较两个数的大小
			jns s2
			mov ax,[si]
s2:			dec ch
			cmp ch,1
			jnz s1
f:			mov bl,0
			mov cl,10
f1:			div cl
			push ax
			mov ah,0
			inc bl
			cmp al,0
			jnz f1
f2:			pop dx
			mov dl,dh
			add dl,30h
			mov ah,2
			int 21h
			dec bl
			cmp bl,0
			jnz f2
exit:		mov ah,4ch
			int 21h
code ends
end  begin 
 
5.	程序2-5：求数组中负数个数程序，要求：在数据段定义一个数组，其中存放若干个dw类型带符号数据，编写程序求数组中负数个数，并将数组元素及负数个数输出。
data segment
N dw 7 dup(12,-15,48,-123,145,2);0表示负数个数
data ends

stack segment stack
    db 1024 dup(0)
stack ends

code segment
	assume cs:code,ds:data,ss:stack
	
begin: 		mov ax,data
            mov ds,ax
			lea si,N
			mov bh,0 ;负数个数
			mov cl,10;除数
			mov ch,6 ;数组元素的个数
f:			mov bl,0
			mov ax,[si]  
			cmp ax,0  ;如果是正数直接输出
			jns f1
			mov ah,2
			mov dl,'-'
			int 21h
			mov ax,0
			sub ax,[si]  
			inc bh
f1:			div cl
			push ax
			mov ah,0
			inc bl
			cmp al,0
			jnz f1
f2:			pop dx
			mov dl,dh
			add dl,30h
			mov ah,2
			int 21h
			dec bl
			cmp bl,0
			jnz f2
			mov ah,2
			mov dl,' '
			int 21h
			inc si
			inc si
			dec ch
			cmp ch,1
			jns f
			mov ah,2
			mov dl,0ah
			int 21h
			mov ah,2
			mov dl,0dh
			int 21h
			add bh,30h
			mov ah,2
			mov dl,bh
			int 21h
exit:		mov ah,4ch
			int 21h
code ends
end  begin 
 

