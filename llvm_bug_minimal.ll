; Minimal reproducer for LLVM WebAssembly backend offset folding bug
; 
; Bug: WebAssembly backend fails to fold constant GEP offsets into 
; load/store offset parameters when the base pointer comes from a 
; GEP instruction with a variable index in a loop context.
;
; Expected: i64.load offset=8 and i64.store offset=2576
; Actual: i32.const 8, i32.add, i64.load and i32.const 2576, i32.add, i64.store

target datalayout = "e-m:e-p:32:32-p10:8:8-p20:8:8-i64:64-n32:64-S128-ni:1:10:20"
target triple = "wasm32-unknown-unknown"

define void @offset_folding_bug(ptr %data, i32 %n) {
entry:
  %arr = alloca [100 x i64], align 8
  br label %loop

loop:
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop ]
  
  ; GEP with variable index
  %base = getelementptr inbounds [100 x i64], ptr %arr, i32 0, i32 %i
  
  ; These constant offsets should be folded into load/store instructions
  ; but are not when base comes from GEP with variable index
  %ptr1 = getelementptr inbounds i8, ptr %base, i32 8
  %val = load i64, ptr %ptr1, align 8
  
  %ptr2 = getelementptr inbounds i8, ptr %base, i32 2576
  store i64 %val, ptr %ptr2, align 8
  
  %i.next = add i32 %i, 1
  %cond = icmp ult i32 %i.next, %n
  br i1 %cond, label %loop, label %exit

exit:
  ret void
}