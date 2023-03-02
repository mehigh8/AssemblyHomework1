; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    ;; Interschimb registrii pentru a avea contorul pe ecx pentru a putea
    ;; folosi intructiunea de loop
    xchg edx, ecx
    ;; Pentru a nu iesi din vector decrementez contorul
    dec ecx
while:
	xor eax, eax
	xor ebx, ebx

	mov eax, [edi + ecx * my_date_size + my_date.year]
	cmp [esi + my_date.year], eax
	;; Daca anul curent este mai mare trebuie sa compar lunile
	jg if_month
	;; Altfel inseamna ca persoana are 0 ani
	mov dword[edx + ecx * 4], 0
	jmp end_while

if_month:
	;; Calculez varsta daca atat luna cat si ziua ar fi mai mari sau egale
	mov ebx, [esi + my_date.year]
	sub ebx, eax
	xor eax, eax

	mov ax, word[edi + ecx * my_date_size + my_date.month]
	cmp word[esi + my_date.month], ax
	;; Daca luna este egala cu cea din ziua de nastere compar zilele
	je if_day
	;; Daca este mai mare nu mai este necesara nicio comparatie
	jg print
	;; Altfel inseamna ca inca nu a fost ziua persoanei in anul curent
	dec ebx
	mov [edx + ecx * 4], ebx
	jmp end_while

if_day:
	xor eax, eax
	mov ax, word[edi + ecx * my_date_size + my_date.day]
	cmp word[esi + my_date.day], ax
	;; Daca ziua curenta este mai mare sau egala inseamna ca persoana si-a
	;; serbat ziua anul acesta.
	jge print
	;; Altfel inseamna ca nu a fost inca ziua persoanei
	dec ebx
	mov [edx + ecx * 4], ebx
	jmp end_while

print:
	mov [edx + ecx * 4], ebx

end_while:
	cmp ecx, 0
	;; Conditie necesara pentru reintrarea in while
	je out_of_loop
	loop while

	;; Intru din nou in while pentru ca instructiunea loop nu acopera
	;; cazul cand ecx este 0
	jmp while

out_of_loop:
	;; Interschimb din nou registrii pentru transmiterea corecta a rezultatelor
	xchg edx, ecx

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
