global execution
extern benchmark
extern printf
extern scanf


segment .data
    Benchmark db "This assembly module has completed the benchmarking phase.", 10, 0
    Report db "Here is the report", 10, 0

    BeforePush db "Time on the clock before the push instruction: %d tics", 10, 0
    AfterPush db "Time on the clock after the push instruction: %d tics", 10, 0
    
    BeforeAdd db "Time on the clock before the add instruction: %d tics", 10, 0
    AfterAdd db "Time on the clock after the add instruction: %d tics", 10, 0
    
    ExecutionTime db "Execution time was %d tics.", 10, 0

    Results db "Now you know which instruction was faster and which was slower.", 10, 0
    SendToDriver db "The fast execution time will be sent to the driver.", 10, 0


segment .bss
    align 64
    Save resb 832


segment .text
    execution:
        push        rbp
        mov         rbp, rsp
        push        rbx
        push        rcx
        push        rdx
        push        rsi
        push        rdi
        push        r8
        push        r9
        push        r10
        push        r11
        push        r12
        push        r13
        push        r14
        push        r15
        pushf

        mov rax, 7
        mov rdx, 0
        xsave [Save]

        mov rax, 0
        mov rdi, Benchmark
        call printf

        mov rax, 0
        mov rdi, Report
        call printf

        xor rax, rax
        xor rdx, rdx
        cpuid
        rdtsc
        shl rdx, 32
        or rax, rdx
        mov r13, rax

        push rdx

        xor rax, rax
        xor rdx, rdx
        cpuid
        rdtsc
        shl rdx, 32
        or rax, rdx
        mov r14, rax

        pop rdx 

        mov rax, 0
        mov rdi, BeforePush 
        mov rsi, r13
        call printf

        mov rax, 0
        mov rdi, AfterPush
        mov rsi, r14
        call printf

        sub r14, r13

        mov r15, r14

        mov rax, 0
        mov rdi, ExecutionTime
        mov rsi, r14
        call printf

        xor rax, rax
        xor rdx, rdx
        cpuid
        rdtsc
        shl rdx, 32
        or rax, rdx
        mov r13, rax

        add rbx, rcx

        xor rax, rax
        xor rdx, rdx
        cpuid
        rdtsc
        shl rdx, 32
        or rax, rdx
        mov r14, rax

        mov rax, 0
        mov rdi, BeforeAdd 
        mov rsi, r13
        call printf

        mov rax, 0
        mov rdi, AfterAdd
        mov rsi, r14
        call printf

        sub r14, r13

        mov rax, 0
        mov rdi, ExecutionTime
        mov rsi, r14
        call printf

        cmp r14, r15
        jl push

        mov r12, r15
        jmp finish

    push:
        mov r12, r14


    finish:
        mov rax, 0
        mov rdi, Results
        call printf

        mov rax, 0
        mov rdi, SendToDriver
        call printf

        mov rax, 7
        mov rdx, 0
        xrstor [Save]

        ;Move the value of r11 to xmm0 to return it to the main.c file  
        mov rax, r12               ;Move the value of the sum to xmm0 for return

        popf
        pop         r15
        pop         r14
        pop         r13
        pop         r12
        pop         r11
        pop         r10
        pop         r9
        pop         r8
        pop         rdi
        pop         rsi
        pop         rdx
        pop         rcx
        pop         rbx
        pop         rbp

        ret