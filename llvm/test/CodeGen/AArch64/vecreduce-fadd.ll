; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=aarch64-eabi -aarch64-neon-syntax=generic -mattr=+fullfp16 < %s | FileCheck --check-prefixes=CHECK,FULLFP16 %s
; RUN: llc --mtriple=aarch64-eabi -aarch64-neon-syntax=generic < %s | FileCheck %s --check-prefixes=CHECK,CHECKNOFP16

define float @add_HalfS(<2 x float> %bin.rdx)  {
; CHECK-LABEL: add_HalfS:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    ret
  %r = call fast float @llvm.vector.reduce.fadd.f32.v2f32(float -0.0, <2 x float> %bin.rdx)
  ret float %r
}

define half @add_HalfH(<4 x half> %bin.rdx)  {
; FULLFP16-LABEL: add_HalfH:
; FULLFP16:       // %bb.0:
; FULLFP16-NEXT:    faddp v0.4h, v0.4h, v0.4h
; FULLFP16-NEXT:    faddp h0, v0.2h
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: add_HalfH:
; CHECKNOFP16:       // %bb.0:
; CHECKNOFP16-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECKNOFP16-NEXT:    mov h1, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s2, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s2, s1
; CHECKNOFP16-NEXT:    mov h2, v0.h[2]
; CHECKNOFP16-NEXT:    mov h0, v0.h[3]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
  %r = call fast half @llvm.vector.reduce.fadd.f16.v4f16(half -0.0, <4 x half> %bin.rdx)
  ret half %r
}


define half @add_H(<8 x half> %bin.rdx)  {
; FULLFP16-LABEL: add_H:
; FULLFP16:       // %bb.0:
; FULLFP16-NEXT:    faddp v1.8h, v0.8h, v0.8h
; FULLFP16-NEXT:    faddp v0.8h, v1.8h, v0.8h
; FULLFP16-NEXT:    faddp h0, v0.2h
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: add_H:
; CHECKNOFP16:       // %bb.0:
; CHECKNOFP16-NEXT:    mov h1, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s2, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s2, s1
; CHECKNOFP16-NEXT:    mov h2, v0.h[2]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    mov h2, v0.h[3]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    mov h2, v0.h[4]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    mov h2, v0.h[5]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    mov h2, v0.h[6]
; CHECKNOFP16-NEXT:    mov h0, v0.h[7]
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s1, s1, s2
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
  %r = call fast half @llvm.vector.reduce.fadd.f16.v8f16(half -0.0, <8 x half> %bin.rdx)
  ret half %r
}

define float @add_S(<4 x float> %bin.rdx)  {
; CHECK-LABEL: add_S:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    ret
  %r = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %bin.rdx)
  ret float %r
}

define double @add_D(<2 x double> %bin.rdx)  {
; CHECK-LABEL: add_D:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp d0, v0.2d
; CHECK-NEXT:    ret
  %r = call fast double @llvm.vector.reduce.fadd.f64.v2f64(double -0.0, <2 x double> %bin.rdx)
  ret double %r
}

define half @add_2H(<16 x half> %bin.rdx)  {
; FULLFP16-LABEL: add_2H:
; FULLFP16:       // %bb.0:
; FULLFP16-NEXT:    fadd v0.8h, v0.8h, v1.8h
; FULLFP16-NEXT:    faddp v1.8h, v0.8h, v0.8h
; FULLFP16-NEXT:    faddp v0.8h, v1.8h, v0.8h
; FULLFP16-NEXT:    faddp h0, v0.2h
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: add_2H:
; CHECKNOFP16:       // %bb.0:
; CHECKNOFP16-NEXT:    mov h2, v1.h[1]
; CHECKNOFP16-NEXT:    mov h3, v0.h[1]
; CHECKNOFP16-NEXT:    fcvt s4, h1
; CHECKNOFP16-NEXT:    fcvt s5, h0
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s4, s5, s4
; CHECKNOFP16-NEXT:    mov h5, v0.h[2]
; CHECKNOFP16-NEXT:    fadd s2, s3, s2
; CHECKNOFP16-NEXT:    mov h3, v1.h[2]
; CHECKNOFP16-NEXT:    fcvt h4, s4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s3, s5, s3
; CHECKNOFP16-NEXT:    mov h5, v0.h[3]
; CHECKNOFP16-NEXT:    fadd s2, s4, s2
; CHECKNOFP16-NEXT:    mov h4, v1.h[3]
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s4, s5, s4
; CHECKNOFP16-NEXT:    mov h5, v0.h[4]
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[4]
; CHECKNOFP16-NEXT:    fcvt h4, s4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s3, s5, s3
; CHECKNOFP16-NEXT:    mov h5, v0.h[5]
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    mov h4, v1.h[5]
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s4, s5, s4
; CHECKNOFP16-NEXT:    mov h5, v0.h[6]
; CHECKNOFP16-NEXT:    mov h0, v0.h[7]
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[6]
; CHECKNOFP16-NEXT:    fcvt h4, s4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    mov h1, v1.h[7]
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s3, s5, s3
; CHECKNOFP16-NEXT:    fadd s0, s0, s1
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    fcvt h1, s2
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
  %r = call fast half @llvm.vector.reduce.fadd.f16.v16f16(half -0.0, <16 x half> %bin.rdx)
  ret half %r
}

define float @add_2S(<8 x float> %bin.rdx)  {
; CHECK-LABEL: add_2S:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    ret
  %r = call fast float @llvm.vector.reduce.fadd.f32.v8f32(float -0.0, <8 x float> %bin.rdx)
  ret float %r
}

define double @add_2D(<4 x double> %bin.rdx)  {
; CHECK-LABEL: add_2D:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    faddp d0, v0.2d
; CHECK-NEXT:    ret
  %r = call fast double @llvm.vector.reduce.fadd.f64.v4f64(double -0.0, <4 x double> %bin.rdx)
  ret double %r
}

; Added at least one test where the start value is not -0.0.
define float @add_S_init_42(<4 x float> %bin.rdx)  {
; CHECK-LABEL: add_S_init_42:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    mov w8, #1109917696
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %r = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float 42.0, <4 x float> %bin.rdx)
  ret float %r
}

; FIXME: The faddp.4s in the loop should not use v0.4s as second operand,
; because this introduces an unnecessary cross-iteration dependency.
define float @fadd_reduction_v4f32_in_loop(ptr %ptr.start) {
; CHECK-LABEL: fadd_reduction_v4f32_in_loop:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi d0, #0000000000000000
; CHECK-NEXT:    mov x8, xzr
; CHECK-NEXT:  .LBB9_1: // %loop
; CHECK-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr q1, [x0, x8]
; CHECK-NEXT:    add x8, x8, #16
; CHECK-NEXT:    cmp w8, #112
; CHECK-NEXT:    faddp v1.4s, v1.4s, v1.4s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    fadd s0, s1, s0
; CHECK-NEXT:    b.ne .LBB9_1
; CHECK-NEXT:  // %bb.2: // %exit
; CHECK-NEXT:    ret
entry:
  br label %loop

loop:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr = phi ptr [ %ptr.start, %entry ], [ %ptr.next, %loop ]
  %red = phi float [ 0.000000e+00, %entry ], [ %red.next, %loop ]
  %lv = load <4 x float>, ptr %ptr, align 4
  %r = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %lv)
  %red.next = fadd fast float %r, %red
  %ec = icmp eq i32 %iv, 7
  %ptr.next = getelementptr inbounds float, ptr %ptr, i64 4
  %iv.next= add nuw nsw i32 %iv, 1
  br i1 %ec, label %exit, label %loop

exit:
  ret float %red.next
}

; FIXME: The faddp.4h in the loop should not use v0.4h as second operand,
; because this introduces an unnecessary cross-iteration dependency.
define half @fadd_reduction_v4f16_in_loop(ptr %ptr.start) {
; FULLFP16-LABEL: fadd_reduction_v4f16_in_loop:
; FULLFP16:       // %bb.0: // %entry
; FULLFP16-NEXT:    movi d0, #0000000000000000
; FULLFP16-NEXT:    mov x8, xzr
; FULLFP16-NEXT:  .LBB10_1: // %loop
; FULLFP16-NEXT:    // =>This Inner Loop Header: Depth=1
; FULLFP16-NEXT:    ldr d1, [x0, x8]
; FULLFP16-NEXT:    add x8, x8, #8
; FULLFP16-NEXT:    cmp w8, #56
; FULLFP16-NEXT:    faddp v1.4h, v1.4h, v1.4h
; FULLFP16-NEXT:    faddp h1, v1.2h
; FULLFP16-NEXT:    fadd h0, h1, h0
; FULLFP16-NEXT:    b.ne .LBB10_1
; FULLFP16-NEXT:  // %bb.2: // %exit
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: fadd_reduction_v4f16_in_loop:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    adrp x9, .LCPI10_0
; CHECKNOFP16-NEXT:    mov x8, xzr
; CHECKNOFP16-NEXT:    ldr h0, [x9, :lo12:.LCPI10_0]
; CHECKNOFP16-NEXT:  .LBB10_1: // %loop
; CHECKNOFP16-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECKNOFP16-NEXT:    ldr d1, [x0, x8]
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    add x8, x8, #8
; CHECKNOFP16-NEXT:    cmp w8, #56
; CHECKNOFP16-NEXT:    mov h2, v1.h[1]
; CHECKNOFP16-NEXT:    fcvt s3, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s3, s2
; CHECKNOFP16-NEXT:    mov h3, v1.h[2]
; CHECKNOFP16-NEXT:    mov h1, v1.h[3]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s1, s2, s1
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    b.ne .LBB10_1
; CHECKNOFP16-NEXT:  // %bb.2: // %exit
; CHECKNOFP16-NEXT:    ret
entry:
  br label %loop

loop:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr = phi ptr [ %ptr.start, %entry ], [ %ptr.next, %loop ]
  %red = phi half [ 0.000000e+00, %entry ], [ %red.next, %loop ]
  %lv = load <4 x half>, ptr %ptr, align 4
  %r = call fast half @llvm.vector.reduce.fadd.f16.v4f16(half -0.0, <4 x half> %lv)
  %red.next = fadd fast half %r, %red
  %ec = icmp eq i32 %iv, 7
  %ptr.next = getelementptr inbounds half, ptr %ptr, i64 4
  %iv.next= add nuw nsw i32 %iv, 1
  br i1 %ec, label %exit, label %loop

exit:
  ret half %red.next
}

; FIXME: The faddp.8h in the loop should not use v0.8h as second operand,
; because this introduces an unnecessary cross-iteration dependency.
define half @fadd_reduction_v8f16_in_loop(ptr %ptr.start) {
; FULLFP16-LABEL: fadd_reduction_v8f16_in_loop:
; FULLFP16:       // %bb.0: // %entry
; FULLFP16-NEXT:    movi d0, #0000000000000000
; FULLFP16-NEXT:    mov x8, xzr
; FULLFP16-NEXT:  .LBB11_1: // %loop
; FULLFP16-NEXT:    // =>This Inner Loop Header: Depth=1
; FULLFP16-NEXT:    ldr q1, [x0, x8]
; FULLFP16-NEXT:    add x8, x8, #8
; FULLFP16-NEXT:    cmp w8, #56
; FULLFP16-NEXT:    faddp v2.8h, v1.8h, v1.8h
; FULLFP16-NEXT:    faddp v1.8h, v2.8h, v1.8h
; FULLFP16-NEXT:    faddp h1, v1.2h
; FULLFP16-NEXT:    fadd h0, h1, h0
; FULLFP16-NEXT:    b.ne .LBB11_1
; FULLFP16-NEXT:  // %bb.2: // %exit
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: fadd_reduction_v8f16_in_loop:
; CHECKNOFP16:       // %bb.0: // %entry
; CHECKNOFP16-NEXT:    adrp x9, .LCPI11_0
; CHECKNOFP16-NEXT:    mov x8, xzr
; CHECKNOFP16-NEXT:    ldr h0, [x9, :lo12:.LCPI11_0]
; CHECKNOFP16-NEXT:  .LBB11_1: // %loop
; CHECKNOFP16-NEXT:    // =>This Inner Loop Header: Depth=1
; CHECKNOFP16-NEXT:    ldr q1, [x0, x8]
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    add x8, x8, #8
; CHECKNOFP16-NEXT:    cmp w8, #56
; CHECKNOFP16-NEXT:    mov h2, v1.h[1]
; CHECKNOFP16-NEXT:    fcvt s3, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s3, s2
; CHECKNOFP16-NEXT:    mov h3, v1.h[2]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[3]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[4]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[5]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    mov h3, v1.h[6]
; CHECKNOFP16-NEXT:    mov h1, v1.h[7]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s2, s2, s3
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fadd s1, s2, s1
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fadd s0, s1, s0
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    b.ne .LBB11_1
; CHECKNOFP16-NEXT:  // %bb.2: // %exit
; CHECKNOFP16-NEXT:    ret
entry:
  br label %loop

loop:
  %iv = phi i32 [ 1, %entry ], [ %iv.next, %loop ]
  %ptr = phi ptr [ %ptr.start, %entry ], [ %ptr.next, %loop ]
  %red = phi half [ 0.000000e+00, %entry ], [ %red.next, %loop ]
  %lv = load <8 x half>, ptr %ptr, align 4
  %r = call fast half @llvm.vector.reduce.fadd.f16.v8f16(half -0.0, <8 x half> %lv)
  %red.next = fadd fast half %r, %red
  %ec = icmp eq i32 %iv, 7
  %ptr.next = getelementptr inbounds half, ptr %ptr, i64 4
  %iv.next= add nuw nsw i32 %iv, 1
  br i1 %ec, label %exit, label %loop

exit:
  ret half %red.next
}


define half @fadd_reduct_reassoc_v8f16(<8 x half> %a, <8 x half> %b) {
; FULLFP16-LABEL: fadd_reduct_reassoc_v8f16:
; FULLFP16:       // %bb.0:
; FULLFP16-NEXT:    faddp v2.8h, v0.8h, v0.8h
; FULLFP16-NEXT:    faddp v3.8h, v1.8h, v1.8h
; FULLFP16-NEXT:    faddp v0.8h, v2.8h, v0.8h
; FULLFP16-NEXT:    faddp v1.8h, v3.8h, v1.8h
; FULLFP16-NEXT:    faddp h0, v0.2h
; FULLFP16-NEXT:    faddp h1, v1.2h
; FULLFP16-NEXT:    fadd h0, h0, h1
; FULLFP16-NEXT:    ret
;
; CHECKNOFP16-LABEL: fadd_reduct_reassoc_v8f16:
; CHECKNOFP16:       // %bb.0:
; CHECKNOFP16-NEXT:    mov h2, v0.h[1]
; CHECKNOFP16-NEXT:    mov h3, v1.h[1]
; CHECKNOFP16-NEXT:    fcvt s4, h0
; CHECKNOFP16-NEXT:    fcvt s5, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s4, s2
; CHECKNOFP16-NEXT:    fadd s3, s5, s3
; CHECKNOFP16-NEXT:    mov h4, v0.h[2]
; CHECKNOFP16-NEXT:    mov h5, v1.h[2]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fadd s3, s3, s5
; CHECKNOFP16-NEXT:    mov h4, v0.h[3]
; CHECKNOFP16-NEXT:    mov h5, v1.h[3]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fadd s3, s3, s5
; CHECKNOFP16-NEXT:    mov h4, v0.h[4]
; CHECKNOFP16-NEXT:    mov h5, v1.h[4]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fadd s3, s3, s5
; CHECKNOFP16-NEXT:    mov h4, v0.h[5]
; CHECKNOFP16-NEXT:    mov h5, v1.h[5]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fadd s3, s3, s5
; CHECKNOFP16-NEXT:    mov h4, v0.h[6]
; CHECKNOFP16-NEXT:    mov h5, v1.h[6]
; CHECKNOFP16-NEXT:    mov h0, v0.h[7]
; CHECKNOFP16-NEXT:    mov h1, v1.h[7]
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s4, h4
; CHECKNOFP16-NEXT:    fcvt s5, h5
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s2, s2, s4
; CHECKNOFP16-NEXT:    fadd s3, s3, s5
; CHECKNOFP16-NEXT:    fcvt h2, s2
; CHECKNOFP16-NEXT:    fcvt h3, s3
; CHECKNOFP16-NEXT:    fcvt s2, h2
; CHECKNOFP16-NEXT:    fcvt s3, h3
; CHECKNOFP16-NEXT:    fadd s0, s2, s0
; CHECKNOFP16-NEXT:    fadd s1, s3, s1
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    fcvt h1, s1
; CHECKNOFP16-NEXT:    fcvt s1, h1
; CHECKNOFP16-NEXT:    fcvt s0, h0
; CHECKNOFP16-NEXT:    fadd s0, s0, s1
; CHECKNOFP16-NEXT:    fcvt h0, s0
; CHECKNOFP16-NEXT:    ret
  %r1 = call fast half @llvm.vector.reduce.fadd.f16.v8f16(half -0.0, <8 x half> %a)
  %r2 = call fast half @llvm.vector.reduce.fadd.f16.v8f16(half -0.0, <8 x half> %b)
  %r = fadd fast half %r1, %r2
  ret half %r
}

define float @fadd_reduct_reassoc_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v2.4s, v2.4s, v3.4s
; CHECK-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    faddp v1.4s, v2.4s, v2.4s
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %r1 = call fast float @llvm.vector.reduce.fadd.f32.v8f32(float -0.0, <8 x float> %a)
  %r2 = call fast float @llvm.vector.reduce.fadd.f32.v8f32(float -0.0, <8 x float> %b)
  %r = fadd fast float %r1, %r2
  ret float %r
}

define float @fadd_reduct_reassoc_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp v1.4s, v1.4s, v1.4s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %r1 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %a)
  %r2 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %b)
  %r = fadd fast float %r1, %r2
  ret float %r
}

define float @fadd_reduct_reassoc_v4f32_init(float %i, <4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v4f32_init:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp v1.4s, v1.4s, v1.4s
; CHECK-NEXT:    faddp v2.4s, v2.4s, v2.4s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    faddp s1, v2.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %r1 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float %i, <4 x float> %a)
  %r2 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %b)
  %r = fadd fast float %r1, %r2
  ret float %r
}

define float @fadd_reduct_reassoc_v4v8f32(<4 x float> %a, <8 x float> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v4v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v1.4s, v1.4s, v2.4s
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp v1.4s, v1.4s, v1.4s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    fadd s0, s0, s1
; CHECK-NEXT:    ret
  %r1 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %a)
  %r2 = call fast float @llvm.vector.reduce.fadd.f32.v8f32(float -0.0, <8 x float> %b)
  %r = fadd fast float %r1, %r2
  ret float %r
}

define double @fadd_reduct_reassoc_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fadd v2.2d, v2.2d, v3.2d
; CHECK-NEXT:    fadd v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    faddp d1, v2.2d
; CHECK-NEXT:    faddp d0, v0.2d
; CHECK-NEXT:    fadd d0, d0, d1
; CHECK-NEXT:    ret
  %r1 = call fast double @llvm.vector.reduce.fadd.f64.v4f64(double -0.0, <4 x double> %a)
  %r2 = call fast double @llvm.vector.reduce.fadd.f64.v4f64(double -0.0, <4 x double> %b)
  %r = fadd fast double %r1, %r2
  ret double %r
}

define float @fadd_reduct_reassoc_v4f32_extrause(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fadd_reduct_reassoc_v4f32_extrause:
; CHECK:       // %bb.0:
; CHECK-NEXT:    faddp v0.4s, v0.4s, v0.4s
; CHECK-NEXT:    faddp v1.4s, v1.4s, v1.4s
; CHECK-NEXT:    faddp s0, v0.2s
; CHECK-NEXT:    faddp s1, v1.2s
; CHECK-NEXT:    fadd s1, s0, s1
; CHECK-NEXT:    fmul s0, s1, s0
; CHECK-NEXT:    ret
  %r1 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %a)
  %r2 = call fast float @llvm.vector.reduce.fadd.f32.v4f32(float -0.0, <4 x float> %b)
  %r = fadd fast float %r1, %r2
  %p = fmul float %r, %r1
  ret float %p
}

; Function Attrs: nounwind readnone
declare half @llvm.vector.reduce.fadd.f16.v4f16(half, <4 x half>)
declare half @llvm.vector.reduce.fadd.f16.v8f16(half, <8 x half>)
declare half @llvm.vector.reduce.fadd.f16.v16f16(half, <16 x half>)
declare float @llvm.vector.reduce.fadd.f32.v2f32(float, <2 x float>)
declare float @llvm.vector.reduce.fadd.f32.v4f32(float, <4 x float>)
declare float @llvm.vector.reduce.fadd.f32.v8f32(float, <8 x float>)
declare double @llvm.vector.reduce.fadd.f64.v2f64(double, <2 x double>)
declare double @llvm.vector.reduce.fadd.f64.v4f64(double, <4 x double>)
