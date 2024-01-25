; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

%struct.adpcm_state = type { i16, i8 }
%struct._reent = type { i32, ptr, ptr, ptr, i32, [25 x i8], i32, ptr, i32, ptr, ptr, i32, ptr, ptr, i32, ptr, %union.anon.0, ptr, %struct._atexit, ptr, %struct._glue, [3 x %struct.__sFILE] }
%union.anon.0 = type { %struct.anon.1 }
%struct.anon.1 = type { [30 x ptr], [30 x i32] }
%struct._atexit = type { ptr, i32, [32 x ptr], %struct._on_exit_args }
%struct._on_exit_args = type { [32 x ptr], [32 x ptr], i32, i32 }
%struct._glue = type { ptr, i32, ptr }
%struct.__sFILE = type { ptr, i32, i32, i16, i16, %struct.__sbuf, i32, ptr, ptr, ptr, ptr, ptr, %struct.__sbuf, ptr, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64, ptr, i32, %struct._mbstate_t, i32 }
%struct.__sbuf = type { ptr, i32 }
%struct._mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }

@sbuf = dso_local global [1000 x i16] zeroinitializer, align 2
@.str = private unnamed_addr constant [11 x i8] c"input file\00", align 1
@abuf = dso_local global [500 x i8] zeroinitializer, align 1
@state = dso_local global %struct.adpcm_state zeroinitializer, align 2
@_impure_ptr = external dso_local local_unnamed_addr global ptr, align 8
@.str.1 = private unnamed_addr constant [28 x i8] c"Final valprev=%d, index=%d\0A\00", align 1

; Function Attrs: noreturn nounwind
define dso_local signext i32 @main() local_unnamed_addr #0 {
  %1 = tail call signext i32 @read(i32 noundef signext 0, ptr noundef nonnull @sbuf, i32 noundef signext 2000) #4
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %.loopexit, label %.preheader

.loopexit:                                        ; preds = %5, %0
  tail call void @perror(ptr noundef nonnull @.str) #5
  tail call void @exit(i32 noundef signext 1) #6
  unreachable

.preheader:                                       ; preds = %5, %0
  %3 = phi i32 [ %9, %5 ], [ %1, %0 ]
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %11, label %5

5:                                                ; preds = %.preheader
  %6 = lshr i32 %3, 1
  tail call void @adpcm_coder(ptr noundef nonnull @sbuf, ptr noundef nonnull @abuf, i32 noundef signext %6, ptr noundef nonnull @state) #4
  %7 = lshr i32 %3, 2
  %8 = tail call signext i32 @write(i32 noundef signext 1, ptr noundef nonnull @abuf, i32 noundef signext %7) #4
  %9 = tail call signext i32 @read(i32 noundef signext 0, ptr noundef nonnull @sbuf, i32 noundef signext 2000) #4
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %.loopexit, label %.preheader

11:                                               ; preds = %.preheader
  %12 = load ptr, ptr @_impure_ptr, align 8, !tbaa !4
  %13 = getelementptr inbounds %struct._reent, ptr %12, i64 0, i32 3
  %14 = load ptr, ptr %13, align 8, !tbaa !8
  %15 = load i16, ptr @state, align 2, !tbaa !14
  %16 = load i8, ptr getelementptr inbounds (%struct.adpcm_state, ptr @state, i64 0, i32 1), align 2, !tbaa !17
  %17 = sext i16 %15 to i32
  %18 = zext i8 %16 to i32
  %19 = tail call signext i32 (ptr, ptr, ...) @fprintf(ptr noundef %14, ptr noundef nonnull @.str.1, i32 noundef signext %17, i32 noundef signext %18)
  tail call void @exit(i32 noundef signext 0) #6
  unreachable
}

declare dso_local signext i32 @read(...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local void @perror(ptr nocapture noundef readonly) local_unnamed_addr #2

; Function Attrs: noreturn
declare dso_local void @exit(i32 noundef signext) local_unnamed_addr #3

declare dso_local void @adpcm_coder(ptr noundef, ptr noundef, i32 noundef signext, ptr noundef) local_unnamed_addr #1

declare dso_local signext i32 @write(...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noundef signext i32 @fprintf(ptr nocapture noundef, ptr nocapture noundef readonly, ...) local_unnamed_addr #2

attributes #0 = { noreturn nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #1 = { "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #2 = { nofree nounwind "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #3 = { noreturn "frame-pointer"="none" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #4 = { nounwind }
attributes #5 = { cold }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}
!llvm.module.flags = !{!1, !2, !3}

!0 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git 4ba6a9c9f65bbc8bd06e3652cb20fd4dfc846137)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 1, !"target-abi", !"lp64d"}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{!5, !5, i64 0}
!5 = !{!"any pointer", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C/C++ TBAA"}
!8 = !{!9, !5, i64 24}
!9 = !{!"_reent", !10, i64 0, !5, i64 8, !5, i64 16, !5, i64 24, !10, i64 32, !6, i64 36, !10, i64 64, !5, i64 72, !10, i64 80, !5, i64 88, !5, i64 96, !10, i64 104, !5, i64 112, !5, i64 120, !10, i64 128, !5, i64 136, !6, i64 144, !5, i64 504, !11, i64 512, !5, i64 1304, !13, i64 1312, !6, i64 1336}
!10 = !{!"int", !6, i64 0}
!11 = !{!"_atexit", !5, i64 0, !10, i64 8, !6, i64 16, !12, i64 272}
!12 = !{!"_on_exit_args", !6, i64 0, !6, i64 256, !10, i64 512, !10, i64 516}
!13 = !{!"_glue", !5, i64 0, !10, i64 8, !5, i64 16}
!14 = !{!15, !16, i64 0}
!15 = !{!"adpcm_state", !16, i64 0, !6, i64 2}
!16 = !{!"short", !6, i64 0}
!17 = !{!15, !6, i64 2}
