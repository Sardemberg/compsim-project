;==================================
;File: 
;Description:
;Author: 
;Version: 
;=================================

.code
	JMP mostrar_questao_um

mostrar_questao_um:
	LDI primeiro_ptr
	JZ responder_questao_um
	INT output

	MOV 1
	ADD primeiro_ptr
	STA primeiro_ptr
	JMP mostrar_questao_um

responder_questao_um:
	LDA mask_input
	INT input
	STA escolha

	MOV 0
	SUB escolha
	JN checar_questao_um

	JMP responder_questao_um

end:
	INT exit

.data
	;syscall exit
	exit: DD 25
	input: DD 20
	mask_input: DD 0x100

	primeira_questao: INITB "Onde rufino bebe?", "1 - Preta", "2 - Tonhao", "3 - Vermelho", 0
	primeira_resposta: DD 49
	primeiro_ptr: DD primeira_questao

	output: DD 21
	questao: DD 1
	mask_output: DD 0x000
	opcao: DD 49
	
.bss
	escolha: RESD 1

.stack 10
