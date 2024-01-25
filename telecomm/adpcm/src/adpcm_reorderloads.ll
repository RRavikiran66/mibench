; ModuleID = 'adpcm.ll'
source_filename = "adpcm.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

%struct.adpcm_state = type { i16, i8 }

@stepsizeTable = internal unnamed_addr constant [89 x i32] [i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 16, i32 17, i32 19, i32 21, i32 23, i32 25, i32 28, i32 31, i32 34, i32 37, i32 41, i32 45, i32 50, i32 55, i32 60, i32 66, i32 73, i32 80, i32 88, i32 97, i32 107, i32 118, i32 130, i32 143, i32 157, i32 173, i32 190, i32 209, i32 230, i32 253, i32 279, i32 307, i32 337, i32 371, i32 408, i32 449, i32 494, i32 544, i32 598, i32 658, i32 724, i32 796, i32 876, i32 963, i32 1060, i32 1166, i32 1282, i32 1411, i32 1552, i32 1707, i32 1878, i32 2066, i32 2272, i32 2499, i32 2749, i32 3024, i32 3327, i32 3660, i32 4026, i32 4428, i32 4871, i32 5358, i32 5894, i32 6484, i32 7132, i32 7845, i32 8630, i32 9493, i32 10442, i32 11487, i32 12635, i32 13899, i32 15289, i32 16818, i32 18500, i32 20350, i32 22385, i32 24623, i32 27086, i32 29794, i32 32767], align 4
@indexTable = internal unnamed_addr constant [16 x i32] [i32 -1, i32 -1, i32 -1, i32 -1, i32 2, i32 4, i32 6, i32 8, i32 -1, i32 -1, i32 -1, i32 -1, i32 2, i32 4, i32 6, i32 8], align 4

; Function Attrs: nofree nosync nounwind
define dso_local void @adpcm_coder(ptr nocapture noundef readonly %0, ptr nocapture noundef writeonly %1, i32 noundef signext %2, ptr nocapture noundef %3) local_unnamed_addr #0 {
  %5 = getelementptr inbounds %struct.adpcm_state, ptr %3, i64 0, i32 1
  %6 = load i16, ptr %3, align 2, !tbaa !4
  %7 = load i8, ptr %5, align 2, !tbaa !9
  %8 = icmp sgt i32 %2, 0
  br i1 %8, label %9, label %87

9:                                                ; preds = %4
  %10 = zext i8 %7 to i64
  %11 = getelementptr inbounds [89 x i32], ptr @stepsizeTable, i64 0, i64 %10
  %12 = load i32, ptr %11, align 4, !tbaa !10
  %13 = zext i8 %7 to i32
  %14 = sext i16 %6 to i32
  br label %15

15:                                               ; preds = %75, %9
  %16 = phi i32 [ %78, %75 ], [ 1, %9 ]
  %17 = phi i32 [ %77, %75 ], [ undef, %9 ]
  %18 = phi i32 [ %63, %75 ], [ %13, %9 ]
  %19 = phi i32 [ %55, %75 ], [ %14, %9 ]
  %20 = phi i32 [ %66, %75 ], [ %12, %9 ]
  %21 = phi i32 [ %79, %75 ], [ %2, %9 ]
  %22 = phi ptr [ %24, %75 ], [ %0, %9 ]
  %23 = phi ptr [ %76, %75 ], [ %1, %9 ]
  %24 = getelementptr inbounds i16, ptr %22, i64 1
  %25 = load i16, ptr %22, align 2, !tbaa !12
  %26 = sext i16 %25 to i32
  %27 = sub nsw i32 %26, %19
  %28 = icmp slt i32 %27, 0
  %29 = lshr i32 %27, 28
  %30 = and i32 %29, 8
  %31 = tail call i32 @llvm.abs.i32(i32 %27, i1 true)
  %32 = ashr i32 %20, 3
  %33 = icmp slt i32 %31, %20
  %34 = select i1 %33, i32 0, i32 4
  %35 = select i1 %33, i32 0, i32 %20
  %36 = sub nsw i32 %31, %35
  %37 = add nsw i32 %35, %32
  %38 = ashr i32 %20, 1
  %39 = icmp slt i32 %36, %38
  %40 = or i32 %34, 2
  %41 = select i1 %39, i32 %34, i32 %40
  %42 = select i1 %39, i32 0, i32 %38
  %43 = sub nsw i32 %36, %42
  %44 = add nsw i32 %37, %42
  %45 = ashr i32 %20, 2
  %46 = icmp slt i32 %43, %45
  %47 = xor i1 %46, true
  %48 = zext i1 %47 to i32
  %49 = select i1 %46, i32 0, i32 %45
  %50 = add nsw i32 %44, %49
  %51 = sub i32 0, %50
  %52 = select i1 %28, i32 %51, i32 %50
  %53 = add i32 %52, %19
  %54 = tail call i32 @llvm.smax.i32(i32 %53, i32 -32768)
  %55 = tail call i32 @llvm.smin.i32(i32 %54, i32 32767)
  %56 = or i32 %41, %30
  %57 = or i32 %56, %48
  %58 = zext i32 %57 to i64
  %59 = getelementptr inbounds [16 x i32], ptr @indexTable, i64 0, i64 %58
  %60 = load i32, ptr %59, align 4, !tbaa !10
  %61 = add nsw i32 %60, %18
  %62 = tail call i32 @llvm.smax.i32(i32 %61, i32 0)
  %63 = tail call i32 @llvm.umin.i32(i32 %62, i32 88)
  %64 = zext i32 %63 to i64
  %65 = getelementptr inbounds [89 x i32], ptr @stepsizeTable, i64 0, i64 %64
  %66 = load i32, ptr %65, align 4, !tbaa !10
  %67 = icmp eq i32 %16, 0
  br i1 %67, label %71, label %68

68:                                               ; preds = %15
  %69 = shl nuw nsw i32 %57, 4
  %70 = and i32 %69, 240
  br label %75

71:                                               ; preds = %15
  %72 = or i32 %57, %17
  %73 = trunc i32 %72 to i8
  %74 = getelementptr inbounds i8, ptr %23, i64 1
  store i8 %73, ptr %23, align 1, !tbaa !13
  br label %75

75:                                               ; preds = %71, %68
  %76 = phi ptr [ %23, %68 ], [ %74, %71 ]
  %77 = phi i32 [ %70, %68 ], [ %17, %71 ]
  %78 = xor i32 %16, 1
  %79 = add nsw i32 %21, -1
  %80 = icmp sgt i32 %21, 1
  br i1 %80, label %15, label %81

81:                                               ; preds = %75
  %82 = trunc i32 %63 to i8
  %83 = trunc i32 %55 to i16
  %84 = icmp eq i32 %78, 0
  br i1 %84, label %85, label %87

85:                                               ; preds = %81
  %86 = trunc i32 %77 to i8
  store i8 %86, ptr %76, align 1, !tbaa !13
  br label %87

87:                                               ; preds = %85, %81, %4
  %88 = phi i8 [ %82, %85 ], [ %82, %81 ], [ %7, %4 ]
  %89 = phi i16 [ %83, %85 ], [ %83, %81 ], [ %6, %4 ]
  store i16 %89, ptr %3, align 2, !tbaa !4
  store i8 %88, ptr %5, align 2, !tbaa !9
  ret void
}

; Function Attrs: nofree nosync nounwind
define dso_local void @adpcm_decoder(ptr nocapture noundef readonly %0, ptr nocapture noundef writeonly %1, i32 noundef signext %2, ptr nocapture noundef %3) local_unnamed_addr #0 {
  %5 = getelementptr inbounds %struct.adpcm_state, ptr %3, i64 0, i32 1
  %6 = load i16, ptr %3, align 2, !tbaa !4
  %7 = load i8, ptr %5, align 2, !tbaa !9
  %8 = icmp sgt i32 %2, 0
  br i1 %8, label %9, label %74

9:                                                ; preds = %4
  %10 = zext i8 %7 to i64
  %11 = getelementptr inbounds [89 x i32], ptr @stepsizeTable, i64 0, i64 %10
  %12 = load i32, ptr %11, align 4, !tbaa !10
  %13 = zext i8 %7 to i32
  %14 = sext i16 %6 to i32
  br label %15

15:                                               ; preds = %30, %9
  %16 = phi i32 [ %35, %30 ], [ 0, %9 ]
  %17 = phi i32 [ %33, %30 ], [ undef, %9 ]
  %18 = phi i32 [ %41, %30 ], [ %13, %9 ]
  %19 = phi i32 [ %63, %30 ], [ %14, %9 ]
  %20 = phi i32 [ %66, %30 ], [ %12, %9 ]
  %21 = phi i32 [ %69, %30 ], [ %2, %9 ]
  %22 = phi ptr [ %68, %30 ], [ %1, %9 ]
  %23 = phi ptr [ %31, %30 ], [ %0, %9 ]
  %24 = icmp eq i32 %16, 0
  br i1 %24, label %25, label %30

25:                                               ; preds = %15
  %26 = getelementptr inbounds i8, ptr %23, i64 1
  %27 = load i8, ptr %23, align 1, !tbaa !13
  %28 = zext i8 %27 to i32
  %29 = lshr i32 %28, 4
  br label %30

30:                                               ; preds = %25, %15
  %31 = phi ptr [ %26, %25 ], [ %23, %15 ]
  %32 = phi i32 [ %29, %25 ], [ %17, %15 ]
  %33 = phi i32 [ %28, %25 ], [ %17, %15 ]
  %34 = and i32 %32, 15
  %35 = xor i32 %16, 1
  %36 = zext i32 %34 to i64
  %37 = getelementptr inbounds [16 x i32], ptr @indexTable, i64 0, i64 %36
  %38 = load i32, ptr %37, align 4, !tbaa !10
  %39 = add nsw i32 %38, %18
  %40 = tail call i32 @llvm.smax.i32(i32 %39, i32 0)
  %41 = tail call i32 @llvm.umin.i32(i32 %40, i32 88)
  %42 = and i32 %32, 8
  %43 = ashr i32 %20, 3
  %44 = and i32 %32, 4
  %45 = icmp eq i32 %44, 0
  %46 = select i1 %45, i32 0, i32 %20
  %47 = add nsw i32 %46, %43
  %48 = and i32 %32, 2
  %49 = icmp eq i32 %48, 0
  %50 = ashr i32 %20, 1
  %51 = select i1 %49, i32 0, i32 %50
  %52 = add nsw i32 %47, %51
  %53 = and i32 %32, 1
  %54 = icmp eq i32 %53, 0
  %55 = ashr i32 %20, 2
  %56 = select i1 %54, i32 0, i32 %55
  %57 = add nsw i32 %52, %56
  %58 = icmp eq i32 %42, 0
  %59 = sub i32 0, %57
  %60 = select i1 %58, i32 %57, i32 %59
  %61 = add i32 %60, %19
  %62 = tail call i32 @llvm.smax.i32(i32 %61, i32 -32768)
  %63 = tail call i32 @llvm.smin.i32(i32 %62, i32 32767)
  %64 = zext i32 %41 to i64
  %65 = getelementptr inbounds [89 x i32], ptr @stepsizeTable, i64 0, i64 %64
  %66 = load i32, ptr %65, align 4, !tbaa !10
  %67 = trunc i32 %63 to i16
  %68 = getelementptr inbounds i16, ptr %22, i64 1
  store i16 %67, ptr %22, align 2, !tbaa !12
  %69 = add nsw i32 %21, -1
  %70 = icmp sgt i32 %21, 1
  br i1 %70, label %15, label %71

71:                                               ; preds = %30
  %72 = trunc i32 %63 to i16
  %73 = trunc i32 %41 to i8
  br label %74

74:                                               ; preds = %71, %4
  %75 = phi i16 [ %6, %4 ], [ %72, %71 ]
  %76 = phi i8 [ %7, %4 ], [ %73, %71 ]
  store i16 %75, ptr %3, align 2, !tbaa !4
  store i8 %76, ptr %5, align 2, !tbaa !9
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smax.i32(i32, i32) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.umin.i32(i32, i32) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.abs.i32(i32, i1 immarg) #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.smin.i32(i32, i32) #1

attributes #0 = { nofree nosync nounwind "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64d"}
!2 = !{i32 1, !"SmallDataLimit", i32 8}
!3 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git 4ba6a9c9f65bbc8bd06e3652cb20fd4dfc846137)"}
!4 = !{!5, !6, i64 0}
!5 = !{!"adpcm_state", !6, i64 0, !7, i64 2}
!6 = !{!"short", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C/C++ TBAA"}
!9 = !{!5, !7, i64 2}
!10 = !{!11, !11, i64 0}
!11 = !{!"int", !7, i64 0}
!12 = !{!6, !6, i64 0}
!13 = !{!7, !7, i64 0}
