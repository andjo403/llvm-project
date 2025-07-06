; RUN: opt < %s -disable-output "-passes=print<scalar-evolution>" 2>&1 | FileCheck %s

; Check that we convert
;   zext((a * b)<nuw>)
; to
;   (zext(a) * zext(b))<nuw>

declare i32 @get_int();

; Transform doesn't apply here, because %a lacks range metadata.
; CHECK-LABEL: @no_range
define void @no_range() {
  %a = call i32 @get_int()
  %b = mul i32 %a, 4
  %c = zext i32 %b to i64
  ; CHECK: %c
  ; CHECK-NEXT: --> (zext i32 (4 * %a) to i64)
  ret void
}

; CHECK-LABEL: @range
define void @range() {
  %a = call range(i32 0, 100) i32 @get_int()
  %b = mul i32 %a, 4
  %c = zext i32 %b to i64
  ; CHECK: %c
  ; CHECK-NEXT: --> (4 * (zext i32 %a to i64))<nuw><nsw>
  ret void
}

; CHECK-LABEL: @no_nuw
define void @no_nuw() {
  %a = call range(i32 0, 3) i32 @get_int()
  %b = mul i32 %a, -100
  ; CHECK: %b
  ; CHECK-NEXT: -->  (-100 * %a)<nsw>
  ret void
}
