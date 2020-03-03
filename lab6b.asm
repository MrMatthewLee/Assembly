;******************************************************************************************
;* Program Name:	lab 6b
;* Programmer:		Matthew Lee
;* Class:	 		CSCI 2160-001
;* Lab:   			Lab 6a
;* Date:  			3/3/2020
;* Purpose:			Lab 6b showcasing and learning more about Procs and handling output
;******************************************************************************************

	.486			;tells the assembler we are working with 32-bit code
	.model flat		;tells the assembler we have a flat memory model - all addresses 32 bit
	.stack 100h		;tells the assembler how many bytes we want on the stack
	.LISTALL
	;tells the operating system (OS) to clean up our running program
	ExitProcess	PROTO	Near32	STDCALL, dwExitCode:DWORD
	GetStdHandle PROTO Near32 STDCALL, nStdHandle:DWORD
	putstring	PROTO Near32 STDCALL, lpString:DWORD
	WriteConsoleA PROTO Near32 STDCALL,
		hConsoleOutput:DWORD, 
		lpBuffer:PTR BYTE, 
		dwNumberOfCharsToWrite:DWORD, 
		lpNumberOfCharsWritten:PTR DWORD, 
		lpReserved:DWORD 
	STD_OUTPUT_HANDLE EQU -11	;-11 for STDOUT in Windows
	.data
;place your variables and other data for your programs here
strName				BYTE 13,10," Name: Matthew Lee",0
strClass			BYTE 13,10,"Class: CSCI 2160-001",0
strDate				BYTE 13,10," Date: End Of Lab",0
strLab				BYTE 13,10,"  Lab: Lab 6b",0
_stdOutput			DWORD ?
dBytesWritten		DWORD ?
	.code
_start:				;label for OS -- tells where to start execution
	mov EAX, -1
main PROC
	mov EAX, 0
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE	;Getting the OutputHandle for later use
	mov _stdOutput, EAX						;Moving return value to Memory for later use
	push LENGTHOF strName
	push OFFSET strName
	call printString
	add ESP, 8
	push LENGTHOF strClass
	push OFFSET strClass
	call printString
	add ESP, 8
	push LENGTHOF strDate
	push OFFSET strDate
	call printString
	add ESP, 8
	push LENGTHOF strLab
	push OFFSET strLab
	call printString
	add ESP, 8
	INVOKE ExitProcess, 0	;0 = normal termination in OS-land	
PUBLIC _start		;tells the linker this is a global label -- single entry point
main ENDP
;Other Procs
COMMENT %
*******************************************************************************************
* Name: printString																		                                    *
* Purpose:																				                                        *
*	The purpose of this method is to print strings to the Output Console				            *
*																						                                              *
* Date Created: March 3rd, 2020															                              *
* Date Last Modified: March 3rd, 2020													                            *
*																						                                              *
* Notes on specifications, special algorithms, and assumptions:							              *
*		Uses the ConsoleWriteA 	WINAPI function											                          *
*																						                                              *
*	@param	lpStringToPrint:DWORD														                                *
*	@param	dStringLength:DWORD															                                *												  			  
*	@return void																		                                        *
******************************************************************************************%
printString PROC
	push EBP
	mov EBP, ESP
	push EAX
	push EBX
	push EDX
	mov EBX, [EBP+8]
	mov EDX, [EBP+12]
	INVOKE WriteConsoleA, _stdOutput, EBX, EDX, ADDR dBytesWritten, 0
	pop EDX
	pop EBX
	pop EAX
	pop EBP
	ret
printString ENDP
END					;tells the assembler to ignore all instructions beyond this point
