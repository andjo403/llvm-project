; RUN: not llvm-as < %s 2>&1 | FileCheck %s

declare ptr @dummy()

; CHECK: noundef applies only to load instructions, use attributes for calls or invokes
define void @test_not_load() {
  call ptr @dummy(), !noundef !{}
  ret void
}

; CHECK: noundef metadata must be empty
define void @test_invalid_arg(ptr %p) {
  load ptr, ptr %p, !noundef !{i32 0}
  ret void
}
