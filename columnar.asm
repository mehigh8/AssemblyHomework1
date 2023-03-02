section .data
    extern len_cheie, len_haystack
    ind_key dd 0

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    xor edx, edx
    xor ecx, ecx
    mov dword[ind_key], 0

while_key:
    xor eax, eax
    ;; Preiau indicele vectorului de chei
    mov ecx, [ind_key]
    ;; Preiau coloana
    mov eax, [edi + ecx * 4]
    xor ecx, ecx
    ;; Preiau caracterul
    mov cl, [esi + eax]
while_cipher:
    ;; Adaug caracterul in ciphertext
    mov byte[ebx + edx], cl
    inc edx
    ;; Trec la pozitia urmatorului caracter si verific daca nu am iesit din sir
    add eax, [len_cheie]
    cmp eax, [len_haystack]
    jge out_while_cipher
    ;; Daca nu am iesit trec la urmatorul caracter
    mov cl, [esi + eax]
    jmp while_cipher
out_while_cipher:
    inc dword[ind_key]
    mov ecx, [ind_key]
    ;; Daca am parcurs toate elementele din key ies din 'while'
    cmp ecx, [len_cheie]
    je out_while_key
    jmp while_key
out_while_key:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY