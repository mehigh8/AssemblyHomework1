;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    ind_tags dd 0
    ind_cache dd 0

section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    mov dword[ind_tags], 0
    ;; Calculez tag-ul asociat adresei
    mov esi, edx
    shr esi, OFFSET_BITS
    shl esi, OFFSET_BITS
    ;; Caut in tags daca exista deja tag-ul curent
while_tags:
    push edx
    mov edx, [ind_tags]
    cmp [ebx + edx * 4], esi
    je found_tag

    pop edx
    inc dword[ind_tags]
    cmp dword[ind_tags], CACHE_LINES
    je out_while_tags
    jmp while_tags

out_while_tags:
    ;; Daca nu am gasit tag-ul curent acesta va fi adaugat in tags
    ;; pe pozitia to_replace
    mov dword[ind_cache], 0
    mov dword[ebx + edi * 4], esi

    push eax
    push ebx
    push edx
    ;; Preiau adresa primului element de pe linia din cache pe care
    ;; trebuie sa o populez
    lea eax, [ecx + edi * CACHE_LINE_SIZE]
    ;; Populez linia din cache
while_cache:
    mov ebx, [ind_cache]
    xor edx, edx
    mov dl, byte[esi]
    mov byte[eax + ebx], dl
    ;; Incrementez adresa de la care preiau elementul si indicele coloanei
    inc esi
    inc dword[ind_cache]
    cmp dword[ind_cache], CACHE_LINE_SIZE
    je out_while_cache
    jmp while_cache

out_while_cache:
    ;; Dupa ce am populat linia din cache ramane sa mut in reg valoarea
    ;; elementului din cache
    mov esi, eax
    pop edx
    pop ebx
    pop eax
    push ebx
    ;; Calculez offset-ul
    shl edx, TAG_BITS
    shr edx, TAG_BITS
    mov bl, byte[esi + edx]
    mov byte[eax], bl
    pop ebx
    jmp end

found_tag:
    ;; Daca am gasit tag-ul inseamna ca pot prelua valoarea elementului din
    ;; cache de pe linia cu indicele egal cu cel pe care am gasit tag-ul
    pop edx
    xor esi, esi
    push ebx
    mov ebx, [ind_tags]
    ;; Preiau adresa primului element de pe linia din cache
    lea esi, [ecx + ebx * CACHE_LINE_SIZE]
    ;; Calculez offset-ul
    shl edx, TAG_BITS
    shr edx, TAG_BITS
    xor ebx, ebx
    mov bl, byte[esi + edx]
    mov byte[eax], bl
    pop ebx
end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


