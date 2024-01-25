; ModuleID = 'patricia.ll'
source_filename = "patricia.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

%struct.ptree = type { i64, ptr, i8, i8, ptr, ptr }
%struct.ptree_mask = type { i64, ptr }

; Function Attrs: noinline nounwind
define dso_local ptr @pat_insert(ptr noundef %0, ptr noundef %1) local_unnamed_addr #0 {
  %3 = icmp ne ptr %1, null
  %4 = icmp ne ptr %0, null
  %or.cond = and i1 %4, %3
  br i1 %or.cond, label %5, label %177

5:                                                ; preds = %2
  %6 = getelementptr inbounds %struct.ptree, ptr %0, i64 0, i32 1
  %7 = load ptr, ptr %6, align 8
  %.not = icmp eq ptr %7, null
  br i1 %.not, label %177, label %8

8:                                                ; preds = %5
  %9 = load i64, ptr %7, align 8
  %10 = load i64, ptr %0, align 8
  %11 = and i64 %10, %9
  store i64 %11, ptr %0, align 8
  %.phi.trans.insert = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 3
  %.pre = load i8, ptr %.phi.trans.insert, align 1
  br label %12

12:                                               ; preds = %12, %8
  %13 = phi i8 [ %.pre, %8 ], [ %20, %12 ]
  %.076 = phi ptr [ %1, %8 ], [ %18, %12 ]
  %14 = zext i8 %13 to i32
  %15 = tail call fastcc i64 @bit(i32 noundef signext %14, i64 noundef %11)
  %.not81 = icmp eq i64 %15, 0
  %16 = getelementptr inbounds %struct.ptree, ptr %.076, i64 0, i32 5
  %17 = getelementptr inbounds %struct.ptree, ptr %.076, i64 0, i32 4
  %.in = select i1 %.not81, ptr %17, ptr %16
  %18 = load ptr, ptr %.in, align 8
  %19 = getelementptr inbounds %struct.ptree, ptr %18, i64 0, i32 3
  %20 = load i8, ptr %19, align 1
  %21 = icmp ult i8 %13, %20
  br i1 %21, label %12, label %22, !llvm.loop !5

22:                                               ; preds = %12
  %23 = load i64, ptr %18, align 8
  %24 = icmp eq i64 %11, %23
  br i1 %24, label %.preheader, label %.preheader84.preheader

.preheader84.preheader:                           ; preds = %22
  %25 = tail call fastcc i64 @bit(i32 noundef signext 1, i64 noundef %11)
  %26 = tail call fastcc i64 @bit(i32 noundef signext 1, i64 noundef %23)
  %27 = icmp eq i64 %25, %26
  br i1 %27, label %.preheader84.1, label %.critedge

.preheader:                                       ; preds = %22
  %28 = getelementptr inbounds %struct.ptree, ptr %18, i64 0, i32 2
  %29 = load i8, ptr %28, align 8
  %.not102 = icmp eq i8 %29, 0
  br i1 %.not102, label %._crit_edge.thread, label %.lr.ph

._crit_edge.thread:                               ; preds = %.preheader
  %30 = zext i8 %29 to i64
  %31 = shl nuw nsw i64 %30, 4
  %32 = add nuw nsw i64 %31, 16
  %33 = tail call noalias ptr @malloc(i64 noundef %32) #7
  br label %._crit_edge99.thread

.lr.ph:                                           ; preds = %.preheader
  %34 = load i64, ptr %7, align 8
  %35 = getelementptr inbounds %struct.ptree, ptr %18, i64 0, i32 1
  %36 = load ptr, ptr %35, align 8
  %wide.trip.count = zext i8 %29 to i64
  br label %38

37:                                               ; preds = %38
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %._crit_edge, label %38, !llvm.loop !7

38:                                               ; preds = %.lr.ph, %37
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %37 ]
  %39 = getelementptr inbounds %struct.ptree_mask, ptr %36, i64 %indvars.iv
  %40 = load i64, ptr %39, align 8
  %41 = icmp eq i64 %34, %40
  br i1 %41, label %42, label %37

42:                                               ; preds = %38
  %43 = getelementptr inbounds %struct.ptree_mask, ptr %7, i64 0, i32 1
  %44 = load ptr, ptr %43, align 8
  %45 = getelementptr inbounds %struct.ptree_mask, ptr %36, i64 %indvars.iv, i32 1
  store ptr %44, ptr %45, align 8
  %46 = load ptr, ptr %6, align 8
  tail call void @free(ptr noundef %46)
  tail call void @free(ptr noundef %0)
  br label %177

._crit_edge:                                      ; preds = %37
  %47 = zext i8 %29 to i64
  %48 = shl nuw nsw i64 %47, 4
  %49 = add nuw nsw i64 %48, 16
  %50 = tail call noalias ptr @malloc(i64 noundef %49) #7
  br i1 %.not102, label %._crit_edge99.thread, label %.lr.ph98

.lr.ph98:                                         ; preds = %._crit_edge
  %51 = getelementptr inbounds %struct.ptree, ptr %18, i64 0, i32 1
  br label %52

52:                                               ; preds = %.lr.ph98, %63
  %.096 = phi i32 [ 0, %.lr.ph98 ], [ %.1, %63 ]
  %.17395 = phi i32 [ 0, %.lr.ph98 ], [ %.2, %63 ]
  %.07494 = phi ptr [ %50, %.lr.ph98 ], [ %64, %63 ]
  %53 = load ptr, ptr %6, align 8
  %54 = load i64, ptr %53, align 8
  %55 = load ptr, ptr %51, align 8
  %56 = sext i32 %.17395 to i64
  %57 = getelementptr inbounds %struct.ptree_mask, ptr %55, i64 %56
  %58 = load i64, ptr %57, align 8
  %59 = icmp ugt i64 %54, %58
  br i1 %59, label %60, label %62

60:                                               ; preds = %52
  tail call void @llvm.memmove.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(16) %.07494, ptr noundef nonnull align 1 dereferenceable(16) %57, i64 16, i1 false)
  %61 = add nsw i32 %.17395, 1
  br label %63

62:                                               ; preds = %52
  tail call void @llvm.memmove.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(16) %.07494, ptr noundef nonnull align 1 dereferenceable(16) %53, i64 16, i1 false)
  store i64 4294967295, ptr %53, align 8
  br label %63

63:                                               ; preds = %60, %62
  %.2 = phi i32 [ %61, %60 ], [ %.17395, %62 ]
  %.1 = phi i32 [ %.096, %60 ], [ 1, %62 ]
  %64 = getelementptr inbounds %struct.ptree_mask, ptr %.07494, i64 1
  %65 = load i8, ptr %28, align 8
  %66 = zext i8 %65 to i32
  %67 = icmp slt i32 %.2, %66
  br i1 %67, label %52, label %._crit_edge99, !llvm.loop !8

._crit_edge99:                                    ; preds = %63
  %.not83 = icmp eq i32 %.1, 0
  br i1 %.not83, label %._crit_edge99.thread, label %._crit_edge99._crit_edge

._crit_edge99._crit_edge:                         ; preds = %._crit_edge99
  %.pre107 = load ptr, ptr %6, align 8
  br label %70

._crit_edge99.thread:                             ; preds = %._crit_edge.thread, %._crit_edge, %._crit_edge99
  %.074.lcssa111 = phi ptr [ %64, %._crit_edge99 ], [ %33, %._crit_edge.thread ], [ %50, %._crit_edge ]
  %68 = phi ptr [ %50, %._crit_edge99 ], [ %33, %._crit_edge.thread ], [ %50, %._crit_edge ]
  %69 = load ptr, ptr %6, align 8
  tail call void @llvm.memmove.p0.p0.i64(ptr noundef nonnull align 1 dereferenceable(16) %.074.lcssa111, ptr noundef nonnull align 1 dereferenceable(16) %69, i64 16, i1 false)
  br label %70

70:                                               ; preds = %._crit_edge99._crit_edge, %._crit_edge99.thread
  %71 = phi ptr [ %50, %._crit_edge99._crit_edge ], [ %68, %._crit_edge99.thread ]
  %72 = phi ptr [ %.pre107, %._crit_edge99._crit_edge ], [ %69, %._crit_edge99.thread ]
  tail call void @free(ptr noundef %72)
  tail call void @free(ptr noundef nonnull %0)
  %73 = load i8, ptr %28, align 8
  %74 = add i8 %73, 1
  %75 = getelementptr inbounds %struct.ptree, ptr %18, i64 0, i32 1
  %76 = load ptr, ptr %75, align 8
  store i8 %74, ptr %28, align 8
  tail call void @free(ptr noundef %76)
  store ptr %71, ptr %75, align 8
  br label %177

.preheader84.1:                                   ; preds = %.preheader84.preheader
  %77 = tail call fastcc i64 @bit(i32 noundef signext 2, i64 noundef %11)
  %78 = tail call fastcc i64 @bit(i32 noundef signext 2, i64 noundef %23)
  %79 = icmp eq i64 %77, %78
  br i1 %79, label %.preheader84.2, label %.critedge

.preheader84.2:                                   ; preds = %.preheader84.1
  %80 = tail call fastcc i64 @bit(i32 noundef signext 3, i64 noundef %11)
  %81 = tail call fastcc i64 @bit(i32 noundef signext 3, i64 noundef %23)
  %82 = icmp eq i64 %80, %81
  br i1 %82, label %.preheader84.3, label %.critedge

.preheader84.3:                                   ; preds = %.preheader84.2
  %83 = tail call fastcc i64 @bit(i32 noundef signext 4, i64 noundef %11)
  %84 = tail call fastcc i64 @bit(i32 noundef signext 4, i64 noundef %23)
  %85 = icmp eq i64 %83, %84
  br i1 %85, label %.preheader84.4, label %.critedge

.preheader84.4:                                   ; preds = %.preheader84.3
  %86 = tail call fastcc i64 @bit(i32 noundef signext 5, i64 noundef %11)
  %87 = tail call fastcc i64 @bit(i32 noundef signext 5, i64 noundef %23)
  %88 = icmp eq i64 %86, %87
  br i1 %88, label %.preheader84.5, label %.critedge

.preheader84.5:                                   ; preds = %.preheader84.4
  %89 = tail call fastcc i64 @bit(i32 noundef signext 6, i64 noundef %11)
  %90 = tail call fastcc i64 @bit(i32 noundef signext 6, i64 noundef %23)
  %91 = icmp eq i64 %89, %90
  br i1 %91, label %.preheader84.6, label %.critedge

.preheader84.6:                                   ; preds = %.preheader84.5
  %92 = tail call fastcc i64 @bit(i32 noundef signext 7, i64 noundef %11)
  %93 = tail call fastcc i64 @bit(i32 noundef signext 7, i64 noundef %23)
  %94 = icmp eq i64 %92, %93
  br i1 %94, label %.preheader84.7, label %.critedge

.preheader84.7:                                   ; preds = %.preheader84.6
  %95 = tail call fastcc i64 @bit(i32 noundef signext 8, i64 noundef %11)
  %96 = tail call fastcc i64 @bit(i32 noundef signext 8, i64 noundef %23)
  %97 = icmp eq i64 %95, %96
  br i1 %97, label %.preheader84.8, label %.critedge

.preheader84.8:                                   ; preds = %.preheader84.7
  %98 = tail call fastcc i64 @bit(i32 noundef signext 9, i64 noundef %11)
  %99 = tail call fastcc i64 @bit(i32 noundef signext 9, i64 noundef %23)
  %100 = icmp eq i64 %98, %99
  br i1 %100, label %.preheader84.9, label %.critedge

.preheader84.9:                                   ; preds = %.preheader84.8
  %101 = tail call fastcc i64 @bit(i32 noundef signext 10, i64 noundef %11)
  %102 = tail call fastcc i64 @bit(i32 noundef signext 10, i64 noundef %23)
  %103 = icmp eq i64 %101, %102
  br i1 %103, label %.preheader84.10, label %.critedge

.preheader84.10:                                  ; preds = %.preheader84.9
  %104 = tail call fastcc i64 @bit(i32 noundef signext 11, i64 noundef %11)
  %105 = tail call fastcc i64 @bit(i32 noundef signext 11, i64 noundef %23)
  %106 = icmp eq i64 %104, %105
  br i1 %106, label %.preheader84.11, label %.critedge

.preheader84.11:                                  ; preds = %.preheader84.10
  %107 = tail call fastcc i64 @bit(i32 noundef signext 12, i64 noundef %11)
  %108 = tail call fastcc i64 @bit(i32 noundef signext 12, i64 noundef %23)
  %109 = icmp eq i64 %107, %108
  br i1 %109, label %.preheader84.12, label %.critedge

.preheader84.12:                                  ; preds = %.preheader84.11
  %110 = tail call fastcc i64 @bit(i32 noundef signext 13, i64 noundef %11)
  %111 = tail call fastcc i64 @bit(i32 noundef signext 13, i64 noundef %23)
  %112 = icmp eq i64 %110, %111
  br i1 %112, label %.preheader84.13, label %.critedge

.preheader84.13:                                  ; preds = %.preheader84.12
  %113 = tail call fastcc i64 @bit(i32 noundef signext 14, i64 noundef %11)
  %114 = tail call fastcc i64 @bit(i32 noundef signext 14, i64 noundef %23)
  %115 = icmp eq i64 %113, %114
  br i1 %115, label %.preheader84.14, label %.critedge

.preheader84.14:                                  ; preds = %.preheader84.13
  %116 = tail call fastcc i64 @bit(i32 noundef signext 15, i64 noundef %11)
  %117 = tail call fastcc i64 @bit(i32 noundef signext 15, i64 noundef %23)
  %118 = icmp eq i64 %116, %117
  br i1 %118, label %.preheader84.15, label %.critedge

.preheader84.15:                                  ; preds = %.preheader84.14
  %119 = tail call fastcc i64 @bit(i32 noundef signext 16, i64 noundef %11)
  %120 = tail call fastcc i64 @bit(i32 noundef signext 16, i64 noundef %23)
  %121 = icmp eq i64 %119, %120
  br i1 %121, label %.preheader84.16, label %.critedge

.preheader84.16:                                  ; preds = %.preheader84.15
  %122 = tail call fastcc i64 @bit(i32 noundef signext 17, i64 noundef %11)
  %123 = tail call fastcc i64 @bit(i32 noundef signext 17, i64 noundef %23)
  %124 = icmp eq i64 %122, %123
  br i1 %124, label %.preheader84.17, label %.critedge

.preheader84.17:                                  ; preds = %.preheader84.16
  %125 = tail call fastcc i64 @bit(i32 noundef signext 18, i64 noundef %11)
  %126 = tail call fastcc i64 @bit(i32 noundef signext 18, i64 noundef %23)
  %127 = icmp eq i64 %125, %126
  br i1 %127, label %.preheader84.18, label %.critedge

.preheader84.18:                                  ; preds = %.preheader84.17
  %128 = tail call fastcc i64 @bit(i32 noundef signext 19, i64 noundef %11)
  %129 = tail call fastcc i64 @bit(i32 noundef signext 19, i64 noundef %23)
  %130 = icmp eq i64 %128, %129
  br i1 %130, label %.preheader84.19, label %.critedge

.preheader84.19:                                  ; preds = %.preheader84.18
  %131 = tail call fastcc i64 @bit(i32 noundef signext 20, i64 noundef %11)
  %132 = tail call fastcc i64 @bit(i32 noundef signext 20, i64 noundef %23)
  %133 = icmp eq i64 %131, %132
  br i1 %133, label %.preheader84.20, label %.critedge

.preheader84.20:                                  ; preds = %.preheader84.19
  %134 = tail call fastcc i64 @bit(i32 noundef signext 21, i64 noundef %11)
  %135 = tail call fastcc i64 @bit(i32 noundef signext 21, i64 noundef %23)
  %136 = icmp eq i64 %134, %135
  br i1 %136, label %.preheader84.21, label %.critedge

.preheader84.21:                                  ; preds = %.preheader84.20
  %137 = tail call fastcc i64 @bit(i32 noundef signext 22, i64 noundef %11)
  %138 = tail call fastcc i64 @bit(i32 noundef signext 22, i64 noundef %23)
  %139 = icmp eq i64 %137, %138
  br i1 %139, label %.preheader84.22, label %.critedge

.preheader84.22:                                  ; preds = %.preheader84.21
  %140 = tail call fastcc i64 @bit(i32 noundef signext 23, i64 noundef %11)
  %141 = tail call fastcc i64 @bit(i32 noundef signext 23, i64 noundef %23)
  %142 = icmp eq i64 %140, %141
  br i1 %142, label %.preheader84.23, label %.critedge

.preheader84.23:                                  ; preds = %.preheader84.22
  %143 = tail call fastcc i64 @bit(i32 noundef signext 24, i64 noundef %11)
  %144 = tail call fastcc i64 @bit(i32 noundef signext 24, i64 noundef %23)
  %145 = icmp eq i64 %143, %144
  br i1 %145, label %.preheader84.24, label %.critedge

.preheader84.24:                                  ; preds = %.preheader84.23
  %146 = tail call fastcc i64 @bit(i32 noundef signext 25, i64 noundef %11)
  %147 = tail call fastcc i64 @bit(i32 noundef signext 25, i64 noundef %23)
  %148 = icmp eq i64 %146, %147
  br i1 %148, label %.preheader84.25, label %.critedge

.preheader84.25:                                  ; preds = %.preheader84.24
  %149 = tail call fastcc i64 @bit(i32 noundef signext 26, i64 noundef %11)
  %150 = tail call fastcc i64 @bit(i32 noundef signext 26, i64 noundef %23)
  %151 = icmp eq i64 %149, %150
  br i1 %151, label %.preheader84.26, label %.critedge

.preheader84.26:                                  ; preds = %.preheader84.25
  %152 = tail call fastcc i64 @bit(i32 noundef signext 27, i64 noundef %11)
  %153 = tail call fastcc i64 @bit(i32 noundef signext 27, i64 noundef %23)
  %154 = icmp eq i64 %152, %153
  br i1 %154, label %.preheader84.27, label %.critedge

.preheader84.27:                                  ; preds = %.preheader84.26
  %155 = tail call fastcc i64 @bit(i32 noundef signext 28, i64 noundef %11)
  %156 = tail call fastcc i64 @bit(i32 noundef signext 28, i64 noundef %23)
  %157 = icmp eq i64 %155, %156
  br i1 %157, label %.preheader84.28, label %.critedge

.preheader84.28:                                  ; preds = %.preheader84.27
  %158 = tail call fastcc i64 @bit(i32 noundef signext 29, i64 noundef %11)
  %159 = tail call fastcc i64 @bit(i32 noundef signext 29, i64 noundef %23)
  %160 = icmp eq i64 %158, %159
  br i1 %160, label %.preheader84.29, label %.critedge

.preheader84.29:                                  ; preds = %.preheader84.28
  %161 = tail call fastcc i64 @bit(i32 noundef signext 30, i64 noundef %11)
  %162 = tail call fastcc i64 @bit(i32 noundef signext 30, i64 noundef %23)
  %163 = icmp eq i64 %161, %162
  br i1 %163, label %.preheader84.30, label %.critedge

.preheader84.30:                                  ; preds = %.preheader84.29
  %164 = tail call fastcc i64 @bit(i32 noundef signext 31, i64 noundef %11)
  %165 = tail call fastcc i64 @bit(i32 noundef signext 31, i64 noundef %23)
  %166 = icmp eq i64 %164, %165
  %spec.select = select i1 %166, i32 32, i32 31
  br label %.critedge

.critedge:                                        ; preds = %.preheader84.30, %.preheader84.29, %.preheader84.28, %.preheader84.27, %.preheader84.26, %.preheader84.25, %.preheader84.24, %.preheader84.23, %.preheader84.22, %.preheader84.21, %.preheader84.20, %.preheader84.19, %.preheader84.18, %.preheader84.17, %.preheader84.16, %.preheader84.15, %.preheader84.14, %.preheader84.13, %.preheader84.12, %.preheader84.11, %.preheader84.10, %.preheader84.9, %.preheader84.8, %.preheader84.7, %.preheader84.6, %.preheader84.5, %.preheader84.4, %.preheader84.3, %.preheader84.2, %.preheader84.1, %.preheader84.preheader
  %.3.lcssa = phi i32 [ 1, %.preheader84.preheader ], [ 2, %.preheader84.1 ], [ 3, %.preheader84.2 ], [ 4, %.preheader84.3 ], [ 5, %.preheader84.4 ], [ 6, %.preheader84.5 ], [ 7, %.preheader84.6 ], [ 8, %.preheader84.7 ], [ 9, %.preheader84.8 ], [ 10, %.preheader84.9 ], [ 11, %.preheader84.10 ], [ 12, %.preheader84.11 ], [ 13, %.preheader84.12 ], [ 14, %.preheader84.13 ], [ 15, %.preheader84.14 ], [ 16, %.preheader84.15 ], [ 17, %.preheader84.16 ], [ 18, %.preheader84.17 ], [ 19, %.preheader84.18 ], [ 20, %.preheader84.19 ], [ 21, %.preheader84.20 ], [ 22, %.preheader84.21 ], [ 23, %.preheader84.22 ], [ 24, %.preheader84.23 ], [ 25, %.preheader84.24 ], [ 26, %.preheader84.25 ], [ 27, %.preheader84.26 ], [ 28, %.preheader84.27 ], [ 29, %.preheader84.28 ], [ 30, %.preheader84.29 ], [ %spec.select, %.preheader84.30 ]
  %167 = zext i8 %.pre to i32
  %168 = tail call fastcc i64 @bit(i32 noundef signext %167, i64 noundef %11)
  %.not82 = icmp eq i64 %168, 0
  br i1 %.not82, label %173, label %169

169:                                              ; preds = %.critedge
  %170 = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 5
  %171 = load ptr, ptr %170, align 8
  %172 = tail call fastcc ptr @insertR(ptr noundef %171, ptr noundef nonnull %0, i32 noundef signext %.3.lcssa, ptr noundef nonnull %1)
  store ptr %172, ptr %170, align 8
  br label %177

173:                                              ; preds = %.critedge
  %174 = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 4
  %175 = load ptr, ptr %174, align 8
  %176 = tail call fastcc ptr @insertR(ptr noundef %175, ptr noundef nonnull %0, i32 noundef signext %.3.lcssa, ptr noundef nonnull %1)
  store ptr %176, ptr %174, align 8
  br label %177

177:                                              ; preds = %169, %173, %2, %5, %70, %42
  %.075 = phi ptr [ %18, %42 ], [ %18, %70 ], [ null, %5 ], [ null, %2 ], [ %0, %173 ], [ %0, %169 ]
  ret ptr %.075
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone willreturn
define internal fastcc i64 @bit(i32 noundef signext %0, i64 noundef %1) unnamed_addr #1 {
  %3 = lshr i32 -2147483648, %0
  %4 = sext i32 %3 to i64
  %5 = and i64 %4, %1
  ret i64 %5
}

; Function Attrs: inaccessiblemem_or_argmemonly mustprogress nounwind willreturn allockind("free")
declare dso_local void @free(ptr allocptr nocapture noundef) local_unnamed_addr #2

; Function Attrs: inaccessiblememonly mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0)
declare dso_local noalias noundef ptr @malloc(i64 noundef) local_unnamed_addr #3

; Function Attrs: argmemonly nofree noinline nosync nounwind
define internal fastcc ptr @insertR(ptr noundef %0, ptr noundef %1, i32 noundef signext %2, ptr nocapture noundef readonly %3) unnamed_addr #4 {
  %5 = getelementptr inbounds %struct.ptree, ptr %0, i64 0, i32 3
  %6 = load i8, ptr %5, align 1
  %7 = zext i8 %6 to i32
  %.not = icmp slt i32 %7, %2
  br i1 %.not, label %8, label %common.ret

8:                                                ; preds = %4
  %9 = getelementptr inbounds %struct.ptree, ptr %3, i64 0, i32 3
  %10 = load i8, ptr %9, align 1
  %.not32 = icmp ugt i8 %6, %10
  br i1 %.not32, label %19, label %common.ret

common.ret:                                       ; preds = %8, %4
  %11 = trunc i32 %2 to i8
  %12 = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 3
  store i8 %11, ptr %12, align 1
  %13 = load i64, ptr %1, align 8
  %14 = tail call fastcc i64 @bit(i32 noundef signext %2, i64 noundef %13)
  %.not34 = icmp eq i64 %14, 0
  %15 = select i1 %.not34, ptr %1, ptr %0
  %16 = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 4
  store ptr %15, ptr %16, align 8
  %17 = select i1 %.not34, ptr %0, ptr %1
  %18 = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 5
  store ptr %17, ptr %18, align 8
  br label %common.ret36

19:                                               ; preds = %8
  %20 = load i64, ptr %1, align 8
  %21 = tail call fastcc i64 @bit(i32 noundef signext %7, i64 noundef %20)
  %.not33 = icmp eq i64 %21, 0
  br i1 %.not33, label %26, label %22

common.ret36:                                     ; preds = %26, %22, %common.ret
  %common.ret36.op = phi ptr [ %1, %common.ret ], [ %0, %22 ], [ %0, %26 ]
  ret ptr %common.ret36.op

22:                                               ; preds = %19
  %23 = getelementptr inbounds %struct.ptree, ptr %0, i64 0, i32 5
  %24 = load ptr, ptr %23, align 8
  %25 = tail call fastcc ptr @insertR(ptr noundef %24, ptr noundef nonnull %1, i32 noundef signext %2, ptr noundef nonnull %0)
  store ptr %25, ptr %23, align 8
  br label %common.ret36

26:                                               ; preds = %19
  %27 = getelementptr inbounds %struct.ptree, ptr %0, i64 0, i32 4
  %28 = load ptr, ptr %27, align 8
  %29 = tail call fastcc ptr @insertR(ptr noundef %28, ptr noundef nonnull %1, i32 noundef signext %2, ptr noundef nonnull %0)
  store ptr %29, ptr %27, align 8
  br label %common.ret36
}

; Function Attrs: mustprogress nofree noinline norecurse nosync nounwind readnone willreturn
define dso_local signext i32 @pat_remove(ptr noundef readnone %0, ptr nocapture noundef readnone %1) local_unnamed_addr #1 {
  ret i32 0
}

; Function Attrs: nofree noinline norecurse nosync nounwind readonly
define dso_local ptr @pat_search(i64 noundef %0, ptr noundef readonly %1) local_unnamed_addr #5 {
  %.not = icmp eq ptr %1, null
  br i1 %.not, label %26, label %.preheader.preheader

.preheader.preheader:                             ; preds = %2
  %.phi.trans.insert = getelementptr inbounds %struct.ptree, ptr %1, i64 0, i32 3
  %.pre = load i8, ptr %.phi.trans.insert, align 1
  br label %.preheader

.preheader:                                       ; preds = %.preheader.preheader, %.preheader
  %3 = phi i8 [ %16, %.preheader ], [ %.pre, %.preheader.preheader ]
  %.019 = phi ptr [ %spec.select, %.preheader ], [ null, %.preheader.preheader ]
  %.018 = phi ptr [ %14, %.preheader ], [ %1, %.preheader.preheader ]
  %4 = load i64, ptr %.018, align 8
  %5 = getelementptr inbounds %struct.ptree, ptr %.018, i64 0, i32 1
  %6 = load ptr, ptr %5, align 8
  %7 = load i64, ptr %6, align 8
  %8 = and i64 %7, %0
  %9 = icmp eq i64 %4, %8
  %spec.select = select i1 %9, ptr %.018, ptr %.019
  %10 = zext i8 %3 to i32
  %11 = tail call fastcc i64 @bit(i32 noundef signext %10, i64 noundef %0)
  %.not21 = icmp eq i64 %11, 0
  %12 = getelementptr inbounds %struct.ptree, ptr %.018, i64 0, i32 5
  %13 = getelementptr inbounds %struct.ptree, ptr %.018, i64 0, i32 4
  %.in = select i1 %.not21, ptr %13, ptr %12
  %14 = load ptr, ptr %.in, align 8
  %15 = getelementptr inbounds %struct.ptree, ptr %14, i64 0, i32 3
  %16 = load i8, ptr %15, align 1
  %17 = icmp ult i8 %3, %16
  br i1 %17, label %.preheader, label %18, !llvm.loop !9

18:                                               ; preds = %.preheader
  %19 = load i64, ptr %14, align 8
  %20 = getelementptr inbounds %struct.ptree, ptr %14, i64 0, i32 1
  %21 = load ptr, ptr %20, align 8
  %22 = load i64, ptr %21, align 8
  %23 = and i64 %22, %0
  %24 = icmp eq i64 %19, %23
  %25 = select i1 %24, ptr %14, ptr %spec.select
  br label %26

26:                                               ; preds = %2, %18
  %.0 = phi ptr [ %25, %18 ], [ null, %2 ]
  ret ptr %.0
}

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #6

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #1 = { mustprogress nofree noinline norecurse nosync nounwind readnone willreturn "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #2 = { inaccessiblemem_or_argmemonly mustprogress nounwind willreturn allockind("free") "alloc-family"="malloc" "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #3 = { inaccessiblememonly mustprogress nofree nounwind willreturn allockind("alloc,uninitialized") allocsize(0) "alloc-family"="malloc" "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #4 = { argmemonly nofree noinline nosync nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #5 = { nofree noinline norecurse nosync nounwind readonly "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #6 = { argmemonly nocallback nofree nounwind willreturn }
attributes #7 = { allocsize(0) }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"target-abi", !"lp64d"}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{i32 1, !"SmallDataLimit", i32 8}
!4 = !{!"clang version 15.0.0 (https://github.com/llvm/llvm-project.git 4ba6a9c9f65bbc8bd06e3652cb20fd4dfc846137)"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
