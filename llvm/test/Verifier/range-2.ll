; RUN: llvm-as < %s -o /dev/null

define i8 @f1(ptr %x) {
entry:
  %y = load i8, ptr %x, align 1, !range !0
  ret i8 %y
}
!0 = !{i8 0, i8 1}

define i8 @f2(ptr %x) {
entry:
  %y = load i8, ptr %x, align 1, !range !1
  ret i8 %y
}
!1 = !{i8 255, i8 1}

define i8 @f3(ptr %x) {
entry:
  %y = load i8, ptr %x, align 1, !range !2
  ret i8 %y
}
!2 = !{i8 1, i8 3, i8 5, i8 42}

define i8 @f4(ptr %x) {
entry:
  %y = load i8, ptr %x, align 1, !range !3
  ret i8 %y
}
!3 = !{i8 -1, i8 0, i8 1, i8 2}

define i8 @f5(ptr %x) {
entry:
  %y = load i8, ptr %x, align 1, !range !4
  ret i8 %y
}
!4 = !{i8 -1, i8 0, i8 1, i8 -2}
