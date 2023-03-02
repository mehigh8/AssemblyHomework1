section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    ;; Parcurg sirurile caracter cu caracter
while:
	xor eax, eax
	mov eax, [ebp + 20]
	sub eax, ecx
	dec eax

	xor ebx, ebx
	mov bl, byte[esi + ecx]
	xor bl, byte[edi + eax]
	mov byte[edx + ecx], bl

	cmp ecx, 0
	je out_of_loop

	loop while

	;; Intru din nou in while pentru ca instructiunea loop nu acopera
	;; cazul cand ecx este 0
	jmp while

out_of_loop:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY