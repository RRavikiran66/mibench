; ModuleID = 'patricia.c'
source_filename = "patricia.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n64-S128"
target triple = "riscv64-unknown-unknown"

%struct.ptree = type { i64, ptr, i8, i8, ptr, ptr }
%struct.ptree_mask = type { i64, ptr }

; Function Attrs: noinline nounwind
define dso_local ptr @pat_insert(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %11 = load ptr, ptr %5, align 8
  %12 = icmp ne ptr %11, null
  br i1 %12, label %13, label %21

13:                                               ; preds = %2
  %14 = load ptr, ptr %4, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %16, label %21

16:                                               ; preds = %13
  %17 = load ptr, ptr %4, align 8
  %18 = getelementptr inbounds %struct.ptree, ptr %17, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = icmp ne ptr %19, null
  br i1 %20, label %22, label %21

21:                                               ; preds = %16, %13, %2
  store ptr null, ptr %3, align 8
  br label %250

22:                                               ; preds = %16
  %23 = load ptr, ptr %4, align 8
  %24 = getelementptr inbounds %struct.ptree, ptr %23, i32 0, i32 1
  %25 = load ptr, ptr %24, align 8
  %26 = getelementptr inbounds %struct.ptree_mask, ptr %25, i32 0, i32 0
  %27 = load i64, ptr %26, align 8
  %28 = load ptr, ptr %4, align 8
  %29 = getelementptr inbounds %struct.ptree, ptr %28, i32 0, i32 0
  %30 = load i64, ptr %29, align 8
  %31 = and i64 %30, %27
  store i64 %31, ptr %29, align 8
  %32 = load ptr, ptr %5, align 8
  store ptr %32, ptr %6, align 8
  br label %33

33:                                               ; preds = %57, %22
  %34 = load ptr, ptr %6, align 8
  %35 = getelementptr inbounds %struct.ptree, ptr %34, i32 0, i32 3
  %36 = load i8, ptr %35, align 1
  %37 = zext i8 %36 to i32
  store i32 %37, ptr %9, align 4
  %38 = load ptr, ptr %6, align 8
  %39 = getelementptr inbounds %struct.ptree, ptr %38, i32 0, i32 3
  %40 = load i8, ptr %39, align 1
  %41 = zext i8 %40 to i32
  %42 = load ptr, ptr %4, align 8
  %43 = getelementptr inbounds %struct.ptree, ptr %42, i32 0, i32 0
  %44 = load i64, ptr %43, align 8
  %45 = call i64 @bit(i32 noundef signext %41, i64 noundef %44)
  %46 = icmp ne i64 %45, 0
  br i1 %46, label %47, label %51

47:                                               ; preds = %33
  %48 = load ptr, ptr %6, align 8
  %49 = getelementptr inbounds %struct.ptree, ptr %48, i32 0, i32 5
  %50 = load ptr, ptr %49, align 8
  br label %55

51:                                               ; preds = %33
  %52 = load ptr, ptr %6, align 8
  %53 = getelementptr inbounds %struct.ptree, ptr %52, i32 0, i32 4
  %54 = load ptr, ptr %53, align 8
  br label %55

55:                                               ; preds = %51, %47
  %56 = phi ptr [ %50, %47 ], [ %54, %51 ]
  store ptr %56, ptr %6, align 8
  br label %57

57:                                               ; preds = %55
  %58 = load i32, ptr %9, align 4
  %59 = load ptr, ptr %6, align 8
  %60 = getelementptr inbounds %struct.ptree, ptr %59, i32 0, i32 3
  %61 = load i8, ptr %60, align 1
  %62 = zext i8 %61 to i32
  %63 = icmp slt i32 %58, %62
  br i1 %63, label %33, label %64, !llvm.loop !5

64:                                               ; preds = %57
  %65 = load ptr, ptr %4, align 8
  %66 = getelementptr inbounds %struct.ptree, ptr %65, i32 0, i32 0
  %67 = load i64, ptr %66, align 8
  %68 = load ptr, ptr %6, align 8
  %69 = getelementptr inbounds %struct.ptree, ptr %68, i32 0, i32 0
  %70 = load i64, ptr %69, align 8
  %71 = icmp eq i64 %67, %70
  br i1 %71, label %72, label %196

72:                                               ; preds = %64
  store i32 0, ptr %9, align 4
  br label %73

73:                                               ; preds = %114, %72
  %74 = load i32, ptr %9, align 4
  %75 = load ptr, ptr %6, align 8
  %76 = getelementptr inbounds %struct.ptree, ptr %75, i32 0, i32 2
  %77 = load i8, ptr %76, align 8
  %78 = zext i8 %77 to i32
  %79 = icmp slt i32 %74, %78
  br i1 %79, label %80, label %117

80:                                               ; preds = %73
  %81 = load ptr, ptr %4, align 8
  %82 = getelementptr inbounds %struct.ptree, ptr %81, i32 0, i32 1
  %83 = load ptr, ptr %82, align 8
  %84 = getelementptr inbounds %struct.ptree_mask, ptr %83, i32 0, i32 0
  %85 = load i64, ptr %84, align 8
  %86 = load ptr, ptr %6, align 8
  %87 = getelementptr inbounds %struct.ptree, ptr %86, i32 0, i32 1
  %88 = load ptr, ptr %87, align 8
  %89 = load i32, ptr %9, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds %struct.ptree_mask, ptr %88, i64 %90
  %92 = getelementptr inbounds %struct.ptree_mask, ptr %91, i32 0, i32 0
  %93 = load i64, ptr %92, align 8
  %94 = icmp eq i64 %85, %93
  br i1 %94, label %95, label %113

95:                                               ; preds = %80
  %96 = load ptr, ptr %4, align 8
  %97 = getelementptr inbounds %struct.ptree, ptr %96, i32 0, i32 1
  %98 = load ptr, ptr %97, align 8
  %99 = getelementptr inbounds %struct.ptree_mask, ptr %98, i32 0, i32 1
  %100 = load ptr, ptr %99, align 8
  %101 = load ptr, ptr %6, align 8
  %102 = getelementptr inbounds %struct.ptree, ptr %101, i32 0, i32 1
  %103 = load ptr, ptr %102, align 8
  %104 = load i32, ptr %9, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds %struct.ptree_mask, ptr %103, i64 %105
  %107 = getelementptr inbounds %struct.ptree_mask, ptr %106, i32 0, i32 1
  store ptr %100, ptr %107, align 8
  %108 = load ptr, ptr %4, align 8
  %109 = getelementptr inbounds %struct.ptree, ptr %108, i32 0, i32 1
  %110 = load ptr, ptr %109, align 8
  call void @free(ptr noundef %110)
  %111 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %111)
  store ptr null, ptr %4, align 8
  %112 = load ptr, ptr %6, align 8
  store ptr %112, ptr %3, align 8
  br label %250

113:                                              ; preds = %80
  br label %114

114:                                              ; preds = %113
  %115 = load i32, ptr %9, align 4
  %116 = add nsw i32 %115, 1
  store i32 %116, ptr %9, align 4
  br label %73, !llvm.loop !7

117:                                              ; preds = %73
  %118 = load ptr, ptr %6, align 8
  %119 = getelementptr inbounds %struct.ptree, ptr %118, i32 0, i32 2
  %120 = load i8, ptr %119, align 8
  %121 = zext i8 %120 to i32
  %122 = add nsw i32 %121, 1
  %123 = sext i32 %122 to i64
  %124 = mul i64 16, %123
  %125 = call noalias ptr @malloc(i64 noundef %124) #3
  store ptr %125, ptr %7, align 8
  store i32 0, ptr %10, align 4
  store i32 0, ptr %9, align 4
  %126 = load ptr, ptr %7, align 8
  store ptr %126, ptr %8, align 8
  br label %127

127:                                              ; preds = %169, %117
  %128 = load i32, ptr %9, align 4
  %129 = load ptr, ptr %6, align 8
  %130 = getelementptr inbounds %struct.ptree, ptr %129, i32 0, i32 2
  %131 = load i8, ptr %130, align 8
  %132 = zext i8 %131 to i32
  %133 = icmp slt i32 %128, %132
  br i1 %133, label %134, label %172

134:                                              ; preds = %127
  %135 = load ptr, ptr %4, align 8
  %136 = getelementptr inbounds %struct.ptree, ptr %135, i32 0, i32 1
  %137 = load ptr, ptr %136, align 8
  %138 = getelementptr inbounds %struct.ptree_mask, ptr %137, i32 0, i32 0
  %139 = load i64, ptr %138, align 8
  %140 = load ptr, ptr %6, align 8
  %141 = getelementptr inbounds %struct.ptree, ptr %140, i32 0, i32 1
  %142 = load ptr, ptr %141, align 8
  %143 = load i32, ptr %9, align 4
  %144 = sext i32 %143 to i64
  %145 = getelementptr inbounds %struct.ptree_mask, ptr %142, i64 %144
  %146 = getelementptr inbounds %struct.ptree_mask, ptr %145, i32 0, i32 0
  %147 = load i64, ptr %146, align 8
  %148 = icmp ugt i64 %139, %147
  br i1 %148, label %149, label %159

149:                                              ; preds = %134
  %150 = load ptr, ptr %6, align 8
  %151 = getelementptr inbounds %struct.ptree, ptr %150, i32 0, i32 1
  %152 = load ptr, ptr %151, align 8
  %153 = load i32, ptr %9, align 4
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds %struct.ptree_mask, ptr %152, i64 %154
  %156 = load ptr, ptr %8, align 8
  call void @bcopy(ptr noundef %155, ptr noundef %156, i64 noundef 16)
  %157 = load i32, ptr %9, align 4
  %158 = add nsw i32 %157, 1
  store i32 %158, ptr %9, align 4
  br label %168

159:                                              ; preds = %134
  %160 = load ptr, ptr %4, align 8
  %161 = getelementptr inbounds %struct.ptree, ptr %160, i32 0, i32 1
  %162 = load ptr, ptr %161, align 8
  %163 = load ptr, ptr %8, align 8
  call void @bcopy(ptr noundef %162, ptr noundef %163, i64 noundef 16)
  %164 = load ptr, ptr %4, align 8
  %165 = getelementptr inbounds %struct.ptree, ptr %164, i32 0, i32 1
  %166 = load ptr, ptr %165, align 8
  %167 = getelementptr inbounds %struct.ptree_mask, ptr %166, i32 0, i32 0
  store i64 4294967295, ptr %167, align 8
  store i32 1, ptr %10, align 4
  br label %168

168:                                              ; preds = %159, %149
  br label %169

169:                                              ; preds = %168
  %170 = load ptr, ptr %8, align 8
  %171 = getelementptr inbounds %struct.ptree_mask, ptr %170, i32 1
  store ptr %171, ptr %8, align 8
  br label %127, !llvm.loop !8

172:                                              ; preds = %127
  %173 = load i32, ptr %10, align 4
  %174 = icmp ne i32 %173, 0
  br i1 %174, label %180, label %175

175:                                              ; preds = %172
  %176 = load ptr, ptr %4, align 8
  %177 = getelementptr inbounds %struct.ptree, ptr %176, i32 0, i32 1
  %178 = load ptr, ptr %177, align 8
  %179 = load ptr, ptr %8, align 8
  call void @bcopy(ptr noundef %178, ptr noundef %179, i64 noundef 16)
  br label %180

180:                                              ; preds = %175, %172
  %181 = load ptr, ptr %4, align 8
  %182 = getelementptr inbounds %struct.ptree, ptr %181, i32 0, i32 1
  %183 = load ptr, ptr %182, align 8
  call void @free(ptr noundef %183)
  %184 = load ptr, ptr %4, align 8
  call void @free(ptr noundef %184)
  store ptr null, ptr %4, align 8
  %185 = load ptr, ptr %6, align 8
  %186 = getelementptr inbounds %struct.ptree, ptr %185, i32 0, i32 2
  %187 = load i8, ptr %186, align 8
  %188 = add i8 %187, 1
  store i8 %188, ptr %186, align 8
  %189 = load ptr, ptr %6, align 8
  %190 = getelementptr inbounds %struct.ptree, ptr %189, i32 0, i32 1
  %191 = load ptr, ptr %190, align 8
  call void @free(ptr noundef %191)
  %192 = load ptr, ptr %7, align 8
  %193 = load ptr, ptr %6, align 8
  %194 = getelementptr inbounds %struct.ptree, ptr %193, i32 0, i32 1
  store ptr %192, ptr %194, align 8
  %195 = load ptr, ptr %6, align 8
  store ptr %195, ptr %3, align 8
  br label %250

196:                                              ; preds = %64
  store i32 1, ptr %9, align 4
  br label %197

197:                                              ; preds = %215, %196
  %198 = load i32, ptr %9, align 4
  %199 = icmp slt i32 %198, 32
  br i1 %199, label %200, label %212

200:                                              ; preds = %197
  %201 = load i32, ptr %9, align 4
  %202 = load ptr, ptr %4, align 8
  %203 = getelementptr inbounds %struct.ptree, ptr %202, i32 0, i32 0
  %204 = load i64, ptr %203, align 8
  %205 = call i64 @bit(i32 noundef signext %201, i64 noundef %204)
  %206 = load i32, ptr %9, align 4
  %207 = load ptr, ptr %6, align 8
  %208 = getelementptr inbounds %struct.ptree, ptr %207, i32 0, i32 0
  %209 = load i64, ptr %208, align 8
  %210 = call i64 @bit(i32 noundef signext %206, i64 noundef %209)
  %211 = icmp eq i64 %205, %210
  br label %212

212:                                              ; preds = %200, %197
  %213 = phi i1 [ false, %197 ], [ %211, %200 ]
  br i1 %213, label %214, label %218

214:                                              ; preds = %212
  br label %215

215:                                              ; preds = %214
  %216 = load i32, ptr %9, align 4
  %217 = add nsw i32 %216, 1
  store i32 %217, ptr %9, align 4
  br label %197, !llvm.loop !9

218:                                              ; preds = %212
  %219 = load ptr, ptr %5, align 8
  %220 = getelementptr inbounds %struct.ptree, ptr %219, i32 0, i32 3
  %221 = load i8, ptr %220, align 1
  %222 = zext i8 %221 to i32
  %223 = load ptr, ptr %4, align 8
  %224 = getelementptr inbounds %struct.ptree, ptr %223, i32 0, i32 0
  %225 = load i64, ptr %224, align 8
  %226 = call i64 @bit(i32 noundef signext %222, i64 noundef %225)
  %227 = icmp ne i64 %226, 0
  br i1 %227, label %228, label %238

228:                                              ; preds = %218
  %229 = load ptr, ptr %5, align 8
  %230 = getelementptr inbounds %struct.ptree, ptr %229, i32 0, i32 5
  %231 = load ptr, ptr %230, align 8
  %232 = load ptr, ptr %4, align 8
  %233 = load i32, ptr %9, align 4
  %234 = load ptr, ptr %5, align 8
  %235 = call ptr @insertR(ptr noundef %231, ptr noundef %232, i32 noundef signext %233, ptr noundef %234)
  %236 = load ptr, ptr %5, align 8
  %237 = getelementptr inbounds %struct.ptree, ptr %236, i32 0, i32 5
  store ptr %235, ptr %237, align 8
  br label %248

238:                                              ; preds = %218
  %239 = load ptr, ptr %5, align 8
  %240 = getelementptr inbounds %struct.ptree, ptr %239, i32 0, i32 4
  %241 = load ptr, ptr %240, align 8
  %242 = load ptr, ptr %4, align 8
  %243 = load i32, ptr %9, align 4
  %244 = load ptr, ptr %5, align 8
  %245 = call ptr @insertR(ptr noundef %241, ptr noundef %242, i32 noundef signext %243, ptr noundef %244)
  %246 = load ptr, ptr %5, align 8
  %247 = getelementptr inbounds %struct.ptree, ptr %246, i32 0, i32 4
  store ptr %245, ptr %247, align 8
  br label %248

248:                                              ; preds = %238, %228
  %249 = load ptr, ptr %4, align 8
  store ptr %249, ptr %3, align 8
  br label %250

250:                                              ; preds = %248, %180, %95, %21
  %251 = load ptr, ptr %3, align 8
  ret ptr %251
}

; Function Attrs: noinline nounwind
define internal i64 @bit(i32 noundef signext %0, i64 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i64, align 8
  store i32 %0, ptr %3, align 4
  store i64 %1, ptr %4, align 8
  %5 = load i64, ptr %4, align 8
  %6 = load i32, ptr %3, align 4
  %7 = sub nsw i32 31, %6
  %8 = shl i32 1, %7
  %9 = sext i32 %8 to i64
  %10 = and i64 %5, %9
  ret i64 %10
}

declare dso_local void @free(ptr noundef) #1

; Function Attrs: allocsize(0)
declare dso_local noalias ptr @malloc(i64 noundef) #2

declare dso_local void @bcopy(ptr noundef, ptr noundef, i64 noundef) #1

; Function Attrs: noinline nounwind
define internal ptr @insertR(ptr noundef %0, ptr noundef %1, i32 noundef signext %2, ptr noundef %3) #0 {
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  %9 = alloca ptr, align 8
  store ptr %0, ptr %6, align 8
  store ptr %1, ptr %7, align 8
  store i32 %2, ptr %8, align 4
  store ptr %3, ptr %9, align 8
  %10 = load ptr, ptr %6, align 8
  %11 = getelementptr inbounds %struct.ptree, ptr %10, i32 0, i32 3
  %12 = load i8, ptr %11, align 1
  %13 = zext i8 %12 to i32
  %14 = load i32, ptr %8, align 4
  %15 = icmp sge i32 %13, %14
  br i1 %15, label %26, label %16

16:                                               ; preds = %4
  %17 = load ptr, ptr %6, align 8
  %18 = getelementptr inbounds %struct.ptree, ptr %17, i32 0, i32 3
  %19 = load i8, ptr %18, align 1
  %20 = zext i8 %19 to i32
  %21 = load ptr, ptr %9, align 8
  %22 = getelementptr inbounds %struct.ptree, ptr %21, i32 0, i32 3
  %23 = load i8, ptr %22, align 1
  %24 = zext i8 %23 to i32
  %25 = icmp sle i32 %20, %24
  br i1 %25, label %26, label %60

26:                                               ; preds = %16, %4
  %27 = load i32, ptr %8, align 4
  %28 = trunc i32 %27 to i8
  %29 = load ptr, ptr %7, align 8
  %30 = getelementptr inbounds %struct.ptree, ptr %29, i32 0, i32 3
  store i8 %28, ptr %30, align 1
  %31 = load i32, ptr %8, align 4
  %32 = load ptr, ptr %7, align 8
  %33 = getelementptr inbounds %struct.ptree, ptr %32, i32 0, i32 0
  %34 = load i64, ptr %33, align 8
  %35 = call i64 @bit(i32 noundef signext %31, i64 noundef %34)
  %36 = icmp ne i64 %35, 0
  br i1 %36, label %37, label %39

37:                                               ; preds = %26
  %38 = load ptr, ptr %6, align 8
  br label %41

39:                                               ; preds = %26
  %40 = load ptr, ptr %7, align 8
  br label %41

41:                                               ; preds = %39, %37
  %42 = phi ptr [ %38, %37 ], [ %40, %39 ]
  %43 = load ptr, ptr %7, align 8
  %44 = getelementptr inbounds %struct.ptree, ptr %43, i32 0, i32 4
  store ptr %42, ptr %44, align 8
  %45 = load i32, ptr %8, align 4
  %46 = load ptr, ptr %7, align 8
  %47 = getelementptr inbounds %struct.ptree, ptr %46, i32 0, i32 0
  %48 = load i64, ptr %47, align 8
  %49 = call i64 @bit(i32 noundef signext %45, i64 noundef %48)
  %50 = icmp ne i64 %49, 0
  br i1 %50, label %51, label %53

51:                                               ; preds = %41
  %52 = load ptr, ptr %7, align 8
  br label %55

53:                                               ; preds = %41
  %54 = load ptr, ptr %6, align 8
  br label %55

55:                                               ; preds = %53, %51
  %56 = phi ptr [ %52, %51 ], [ %54, %53 ]
  %57 = load ptr, ptr %7, align 8
  %58 = getelementptr inbounds %struct.ptree, ptr %57, i32 0, i32 5
  store ptr %56, ptr %58, align 8
  %59 = load ptr, ptr %7, align 8
  store ptr %59, ptr %5, align 8
  br label %92

60:                                               ; preds = %16
  %61 = load ptr, ptr %6, align 8
  %62 = getelementptr inbounds %struct.ptree, ptr %61, i32 0, i32 3
  %63 = load i8, ptr %62, align 1
  %64 = zext i8 %63 to i32
  %65 = load ptr, ptr %7, align 8
  %66 = getelementptr inbounds %struct.ptree, ptr %65, i32 0, i32 0
  %67 = load i64, ptr %66, align 8
  %68 = call i64 @bit(i32 noundef signext %64, i64 noundef %67)
  %69 = icmp ne i64 %68, 0
  br i1 %69, label %70, label %80

70:                                               ; preds = %60
  %71 = load ptr, ptr %6, align 8
  %72 = getelementptr inbounds %struct.ptree, ptr %71, i32 0, i32 5
  %73 = load ptr, ptr %72, align 8
  %74 = load ptr, ptr %7, align 8
  %75 = load i32, ptr %8, align 4
  %76 = load ptr, ptr %6, align 8
  %77 = call ptr @insertR(ptr noundef %73, ptr noundef %74, i32 noundef signext %75, ptr noundef %76)
  %78 = load ptr, ptr %6, align 8
  %79 = getelementptr inbounds %struct.ptree, ptr %78, i32 0, i32 5
  store ptr %77, ptr %79, align 8
  br label %90

80:                                               ; preds = %60
  %81 = load ptr, ptr %6, align 8
  %82 = getelementptr inbounds %struct.ptree, ptr %81, i32 0, i32 4
  %83 = load ptr, ptr %82, align 8
  %84 = load ptr, ptr %7, align 8
  %85 = load i32, ptr %8, align 4
  %86 = load ptr, ptr %6, align 8
  %87 = call ptr @insertR(ptr noundef %83, ptr noundef %84, i32 noundef signext %85, ptr noundef %86)
  %88 = load ptr, ptr %6, align 8
  %89 = getelementptr inbounds %struct.ptree, ptr %88, i32 0, i32 4
  store ptr %87, ptr %89, align 8
  br label %90

90:                                               ; preds = %80, %70
  %91 = load ptr, ptr %6, align 8
  store ptr %91, ptr %5, align 8
  br label %92

92:                                               ; preds = %90, %55
  %93 = load ptr, ptr %5, align 8
  ret ptr %93
}

; Function Attrs: noinline nounwind
define dso_local signext i32 @pat_remove(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca ptr, align 8
  %11 = alloca ptr, align 8
  %12 = alloca ptr, align 8
  %13 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  %14 = load ptr, ptr %4, align 8
  %15 = icmp ne ptr %14, null
  br i1 %15, label %16, label %24

16:                                               ; preds = %2
  %17 = load ptr, ptr %4, align 8
  %18 = getelementptr inbounds %struct.ptree, ptr %17, i32 0, i32 1
  %19 = load ptr, ptr %18, align 8
  %20 = icmp ne ptr %19, null
  br i1 %20, label %21, label %24

21:                                               ; preds = %16
  %22 = load ptr, ptr %10, align 8
  %23 = icmp ne ptr %22, null
  br i1 %23, label %25, label %24

24:                                               ; preds = %21, %16, %2
  store i32 0, ptr %3, align 4
  br label %331

25:                                               ; preds = %21
  %26 = load ptr, ptr %5, align 8
  store ptr %26, ptr %10, align 8
  store ptr %26, ptr %6, align 8
  store ptr %26, ptr %7, align 8
  br label %27

27:                                               ; preds = %53, %25
  %28 = load ptr, ptr %10, align 8
  %29 = getelementptr inbounds %struct.ptree, ptr %28, i32 0, i32 3
  %30 = load i8, ptr %29, align 1
  %31 = zext i8 %30 to i32
  store i32 %31, ptr %13, align 4
  %32 = load ptr, ptr %6, align 8
  store ptr %32, ptr %7, align 8
  %33 = load ptr, ptr %10, align 8
  store ptr %33, ptr %6, align 8
  %34 = load ptr, ptr %10, align 8
  %35 = getelementptr inbounds %struct.ptree, ptr %34, i32 0, i32 3
  %36 = load i8, ptr %35, align 1
  %37 = zext i8 %36 to i32
  %38 = load ptr, ptr %4, align 8
  %39 = getelementptr inbounds %struct.ptree, ptr %38, i32 0, i32 0
  %40 = load i64, ptr %39, align 8
  %41 = call i64 @bit(i32 noundef signext %37, i64 noundef %40)
  %42 = icmp ne i64 %41, 0
  br i1 %42, label %43, label %47

43:                                               ; preds = %27
  %44 = load ptr, ptr %10, align 8
  %45 = getelementptr inbounds %struct.ptree, ptr %44, i32 0, i32 5
  %46 = load ptr, ptr %45, align 8
  br label %51

47:                                               ; preds = %27
  %48 = load ptr, ptr %10, align 8
  %49 = getelementptr inbounds %struct.ptree, ptr %48, i32 0, i32 4
  %50 = load ptr, ptr %49, align 8
  br label %51

51:                                               ; preds = %47, %43
  %52 = phi ptr [ %46, %43 ], [ %50, %47 ]
  store ptr %52, ptr %10, align 8
  br label %53

53:                                               ; preds = %51
  %54 = load i32, ptr %13, align 4
  %55 = load ptr, ptr %10, align 8
  %56 = getelementptr inbounds %struct.ptree, ptr %55, i32 0, i32 3
  %57 = load i8, ptr %56, align 1
  %58 = zext i8 %57 to i32
  %59 = icmp slt i32 %54, %58
  br i1 %59, label %27, label %60, !llvm.loop !10

60:                                               ; preds = %53
  %61 = load ptr, ptr %10, align 8
  %62 = getelementptr inbounds %struct.ptree, ptr %61, i32 0, i32 0
  %63 = load i64, ptr %62, align 8
  %64 = load ptr, ptr %4, align 8
  %65 = getelementptr inbounds %struct.ptree, ptr %64, i32 0, i32 0
  %66 = load i64, ptr %65, align 8
  %67 = icmp ne i64 %63, %66
  br i1 %67, label %68, label %69

68:                                               ; preds = %60
  store i32 0, ptr %3, align 4
  br label %331

69:                                               ; preds = %60
  %70 = load ptr, ptr %10, align 8
  %71 = getelementptr inbounds %struct.ptree, ptr %70, i32 0, i32 2
  %72 = load i8, ptr %71, align 8
  %73 = zext i8 %72 to i32
  %74 = icmp eq i32 %73, 1
  br i1 %74, label %75, label %239

75:                                               ; preds = %69
  %76 = load ptr, ptr %10, align 8
  %77 = getelementptr inbounds %struct.ptree, ptr %76, i32 0, i32 3
  %78 = load i8, ptr %77, align 1
  %79 = zext i8 %78 to i32
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %81, label %82

81:                                               ; preds = %75
  store i32 0, ptr %3, align 4
  br label %331

82:                                               ; preds = %75
  %83 = load ptr, ptr %10, align 8
  %84 = getelementptr inbounds %struct.ptree, ptr %83, i32 0, i32 1
  %85 = load ptr, ptr %84, align 8
  %86 = getelementptr inbounds %struct.ptree_mask, ptr %85, i32 0, i32 0
  %87 = load i64, ptr %86, align 8
  %88 = load ptr, ptr %4, align 8
  %89 = getelementptr inbounds %struct.ptree, ptr %88, i32 0, i32 1
  %90 = load ptr, ptr %89, align 8
  %91 = getelementptr inbounds %struct.ptree_mask, ptr %90, i32 0, i32 0
  %92 = load i64, ptr %91, align 8
  %93 = icmp ne i64 %87, %92
  br i1 %93, label %94, label %95

94:                                               ; preds = %82
  store i32 0, ptr %3, align 4
  br label %331

95:                                               ; preds = %82
  %96 = load ptr, ptr %6, align 8
  store ptr %96, ptr %8, align 8
  store ptr %96, ptr %9, align 8
  br label %97

97:                                               ; preds = %122, %95
  %98 = load ptr, ptr %8, align 8
  %99 = getelementptr inbounds %struct.ptree, ptr %98, i32 0, i32 3
  %100 = load i8, ptr %99, align 1
  %101 = zext i8 %100 to i32
  store i32 %101, ptr %13, align 4
  %102 = load ptr, ptr %8, align 8
  store ptr %102, ptr %9, align 8
  %103 = load ptr, ptr %8, align 8
  %104 = getelementptr inbounds %struct.ptree, ptr %103, i32 0, i32 3
  %105 = load i8, ptr %104, align 1
  %106 = zext i8 %105 to i32
  %107 = load ptr, ptr %6, align 8
  %108 = getelementptr inbounds %struct.ptree, ptr %107, i32 0, i32 0
  %109 = load i64, ptr %108, align 8
  %110 = call i64 @bit(i32 noundef signext %106, i64 noundef %109)
  %111 = icmp ne i64 %110, 0
  br i1 %111, label %112, label %116

112:                                              ; preds = %97
  %113 = load ptr, ptr %8, align 8
  %114 = getelementptr inbounds %struct.ptree, ptr %113, i32 0, i32 5
  %115 = load ptr, ptr %114, align 8
  br label %120

116:                                              ; preds = %97
  %117 = load ptr, ptr %8, align 8
  %118 = getelementptr inbounds %struct.ptree, ptr %117, i32 0, i32 4
  %119 = load ptr, ptr %118, align 8
  br label %120

120:                                              ; preds = %116, %112
  %121 = phi ptr [ %115, %112 ], [ %119, %116 ]
  store ptr %121, ptr %8, align 8
  br label %122

122:                                              ; preds = %120
  %123 = load i32, ptr %13, align 4
  %124 = load ptr, ptr %8, align 8
  %125 = getelementptr inbounds %struct.ptree, ptr %124, i32 0, i32 3
  %126 = load i8, ptr %125, align 1
  %127 = zext i8 %126 to i32
  %128 = icmp slt i32 %123, %127
  br i1 %128, label %97, label %129, !llvm.loop !11

129:                                              ; preds = %122
  %130 = load ptr, ptr %9, align 8
  %131 = getelementptr inbounds %struct.ptree, ptr %130, i32 0, i32 3
  %132 = load i8, ptr %131, align 1
  %133 = zext i8 %132 to i32
  %134 = load ptr, ptr %6, align 8
  %135 = getelementptr inbounds %struct.ptree, ptr %134, i32 0, i32 0
  %136 = load i64, ptr %135, align 8
  %137 = call i64 @bit(i32 noundef signext %133, i64 noundef %136)
  %138 = icmp ne i64 %137, 0
  br i1 %138, label %139, label %143

139:                                              ; preds = %129
  %140 = load ptr, ptr %10, align 8
  %141 = load ptr, ptr %9, align 8
  %142 = getelementptr inbounds %struct.ptree, ptr %141, i32 0, i32 5
  store ptr %140, ptr %142, align 8
  br label %147

143:                                              ; preds = %129
  %144 = load ptr, ptr %10, align 8
  %145 = load ptr, ptr %9, align 8
  %146 = getelementptr inbounds %struct.ptree, ptr %145, i32 0, i32 4
  store ptr %144, ptr %146, align 8
  br label %147

147:                                              ; preds = %143, %139
  %148 = load ptr, ptr %7, align 8
  %149 = getelementptr inbounds %struct.ptree, ptr %148, i32 0, i32 3
  %150 = load i8, ptr %149, align 1
  %151 = zext i8 %150 to i32
  %152 = load ptr, ptr %4, align 8
  %153 = getelementptr inbounds %struct.ptree, ptr %152, i32 0, i32 0
  %154 = load i64, ptr %153, align 8
  %155 = call i64 @bit(i32 noundef signext %151, i64 noundef %154)
  %156 = icmp ne i64 %155, 0
  br i1 %156, label %157, label %179

157:                                              ; preds = %147
  %158 = load ptr, ptr %6, align 8
  %159 = getelementptr inbounds %struct.ptree, ptr %158, i32 0, i32 3
  %160 = load i8, ptr %159, align 1
  %161 = zext i8 %160 to i32
  %162 = load ptr, ptr %4, align 8
  %163 = getelementptr inbounds %struct.ptree, ptr %162, i32 0, i32 0
  %164 = load i64, ptr %163, align 8
  %165 = call i64 @bit(i32 noundef signext %161, i64 noundef %164)
  %166 = icmp ne i64 %165, 0
  br i1 %166, label %167, label %171

167:                                              ; preds = %157
  %168 = load ptr, ptr %6, align 8
  %169 = getelementptr inbounds %struct.ptree, ptr %168, i32 0, i32 4
  %170 = load ptr, ptr %169, align 8
  br label %175

171:                                              ; preds = %157
  %172 = load ptr, ptr %6, align 8
  %173 = getelementptr inbounds %struct.ptree, ptr %172, i32 0, i32 5
  %174 = load ptr, ptr %173, align 8
  br label %175

175:                                              ; preds = %171, %167
  %176 = phi ptr [ %170, %167 ], [ %174, %171 ]
  %177 = load ptr, ptr %7, align 8
  %178 = getelementptr inbounds %struct.ptree, ptr %177, i32 0, i32 5
  store ptr %176, ptr %178, align 8
  br label %201

179:                                              ; preds = %147
  %180 = load ptr, ptr %6, align 8
  %181 = getelementptr inbounds %struct.ptree, ptr %180, i32 0, i32 3
  %182 = load i8, ptr %181, align 1
  %183 = zext i8 %182 to i32
  %184 = load ptr, ptr %4, align 8
  %185 = getelementptr inbounds %struct.ptree, ptr %184, i32 0, i32 0
  %186 = load i64, ptr %185, align 8
  %187 = call i64 @bit(i32 noundef signext %183, i64 noundef %186)
  %188 = icmp ne i64 %187, 0
  br i1 %188, label %189, label %193

189:                                              ; preds = %179
  %190 = load ptr, ptr %6, align 8
  %191 = getelementptr inbounds %struct.ptree, ptr %190, i32 0, i32 4
  %192 = load ptr, ptr %191, align 8
  br label %197

193:                                              ; preds = %179
  %194 = load ptr, ptr %6, align 8
  %195 = getelementptr inbounds %struct.ptree, ptr %194, i32 0, i32 5
  %196 = load ptr, ptr %195, align 8
  br label %197

197:                                              ; preds = %193, %189
  %198 = phi ptr [ %192, %189 ], [ %196, %193 ]
  %199 = load ptr, ptr %7, align 8
  %200 = getelementptr inbounds %struct.ptree, ptr %199, i32 0, i32 4
  store ptr %198, ptr %200, align 8
  br label %201

201:                                              ; preds = %197, %175
  %202 = load ptr, ptr %10, align 8
  %203 = getelementptr inbounds %struct.ptree, ptr %202, i32 0, i32 1
  %204 = load ptr, ptr %203, align 8
  %205 = getelementptr inbounds %struct.ptree_mask, ptr %204, i32 0, i32 1
  %206 = load ptr, ptr %205, align 8
  %207 = icmp ne ptr %206, null
  br i1 %207, label %208, label %214

208:                                              ; preds = %201
  %209 = load ptr, ptr %10, align 8
  %210 = getelementptr inbounds %struct.ptree, ptr %209, i32 0, i32 1
  %211 = load ptr, ptr %210, align 8
  %212 = getelementptr inbounds %struct.ptree_mask, ptr %211, i32 0, i32 1
  %213 = load ptr, ptr %212, align 8
  call void @free(ptr noundef %213)
  br label %214

214:                                              ; preds = %208, %201
  %215 = load ptr, ptr %10, align 8
  %216 = getelementptr inbounds %struct.ptree, ptr %215, i32 0, i32 1
  %217 = load ptr, ptr %216, align 8
  call void @free(ptr noundef %217)
  %218 = load ptr, ptr %10, align 8
  %219 = load ptr, ptr %6, align 8
  %220 = icmp ne ptr %218, %219
  br i1 %220, label %221, label %237

221:                                              ; preds = %214
  %222 = load ptr, ptr %6, align 8
  %223 = getelementptr inbounds %struct.ptree, ptr %222, i32 0, i32 0
  %224 = load i64, ptr %223, align 8
  %225 = load ptr, ptr %10, align 8
  %226 = getelementptr inbounds %struct.ptree, ptr %225, i32 0, i32 0
  store i64 %224, ptr %226, align 8
  %227 = load ptr, ptr %6, align 8
  %228 = getelementptr inbounds %struct.ptree, ptr %227, i32 0, i32 1
  %229 = load ptr, ptr %228, align 8
  %230 = load ptr, ptr %10, align 8
  %231 = getelementptr inbounds %struct.ptree, ptr %230, i32 0, i32 1
  store ptr %229, ptr %231, align 8
  %232 = load ptr, ptr %6, align 8
  %233 = getelementptr inbounds %struct.ptree, ptr %232, i32 0, i32 2
  %234 = load i8, ptr %233, align 8
  %235 = load ptr, ptr %10, align 8
  %236 = getelementptr inbounds %struct.ptree, ptr %235, i32 0, i32 2
  store i8 %234, ptr %236, align 8
  br label %237

237:                                              ; preds = %221, %214
  %238 = load ptr, ptr %6, align 8
  call void @free(ptr noundef %238)
  store i32 1, ptr %3, align 4
  br label %331

239:                                              ; preds = %69
  store i32 0, ptr %13, align 4
  br label %240

240:                                              ; preds = %264, %239
  %241 = load i32, ptr %13, align 4
  %242 = load ptr, ptr %10, align 8
  %243 = getelementptr inbounds %struct.ptree, ptr %242, i32 0, i32 2
  %244 = load i8, ptr %243, align 8
  %245 = zext i8 %244 to i32
  %246 = icmp slt i32 %241, %245
  br i1 %246, label %247, label %267

247:                                              ; preds = %240
  %248 = load ptr, ptr %4, align 8
  %249 = getelementptr inbounds %struct.ptree, ptr %248, i32 0, i32 1
  %250 = load ptr, ptr %249, align 8
  %251 = getelementptr inbounds %struct.ptree_mask, ptr %250, i32 0, i32 0
  %252 = load i64, ptr %251, align 8
  %253 = load ptr, ptr %10, align 8
  %254 = getelementptr inbounds %struct.ptree, ptr %253, i32 0, i32 1
  %255 = load ptr, ptr %254, align 8
  %256 = load i32, ptr %13, align 4
  %257 = sext i32 %256 to i64
  %258 = getelementptr inbounds %struct.ptree_mask, ptr %255, i64 %257
  %259 = getelementptr inbounds %struct.ptree_mask, ptr %258, i32 0, i32 0
  %260 = load i64, ptr %259, align 8
  %261 = icmp eq i64 %252, %260
  br i1 %261, label %262, label %263

262:                                              ; preds = %247
  br label %267

263:                                              ; preds = %247
  br label %264

264:                                              ; preds = %263
  %265 = load i32, ptr %13, align 4
  %266 = add nsw i32 %265, 1
  store i32 %266, ptr %13, align 4
  br label %240, !llvm.loop !12

267:                                              ; preds = %262, %240
  %268 = load i32, ptr %13, align 4
  %269 = load ptr, ptr %10, align 8
  %270 = getelementptr inbounds %struct.ptree, ptr %269, i32 0, i32 2
  %271 = load i8, ptr %270, align 8
  %272 = zext i8 %271 to i32
  %273 = icmp sge i32 %268, %272
  br i1 %273, label %274, label %275

274:                                              ; preds = %267
  store i32 0, ptr %3, align 4
  br label %331

275:                                              ; preds = %267
  %276 = load ptr, ptr %10, align 8
  %277 = getelementptr inbounds %struct.ptree, ptr %276, i32 0, i32 2
  %278 = load i8, ptr %277, align 8
  %279 = zext i8 %278 to i32
  %280 = sub nsw i32 %279, 1
  %281 = sext i32 %280 to i64
  %282 = mul i64 16, %281
  %283 = call noalias ptr @malloc(i64 noundef %282) #3
  store ptr %283, ptr %11, align 8
  store i32 0, ptr %13, align 4
  %284 = load ptr, ptr %11, align 8
  store ptr %284, ptr %12, align 8
  br label %285

285:                                              ; preds = %317, %275
  %286 = load i32, ptr %13, align 4
  %287 = load ptr, ptr %10, align 8
  %288 = getelementptr inbounds %struct.ptree, ptr %287, i32 0, i32 2
  %289 = load i8, ptr %288, align 8
  %290 = zext i8 %289 to i32
  %291 = icmp slt i32 %286, %290
  br i1 %291, label %292, label %320

292:                                              ; preds = %285
  %293 = load ptr, ptr %4, align 8
  %294 = getelementptr inbounds %struct.ptree, ptr %293, i32 0, i32 1
  %295 = load ptr, ptr %294, align 8
  %296 = getelementptr inbounds %struct.ptree_mask, ptr %295, i32 0, i32 0
  %297 = load i64, ptr %296, align 8
  %298 = load ptr, ptr %10, align 8
  %299 = getelementptr inbounds %struct.ptree, ptr %298, i32 0, i32 1
  %300 = load ptr, ptr %299, align 8
  %301 = load i32, ptr %13, align 4
  %302 = sext i32 %301 to i64
  %303 = getelementptr inbounds %struct.ptree_mask, ptr %300, i64 %302
  %304 = getelementptr inbounds %struct.ptree_mask, ptr %303, i32 0, i32 0
  %305 = load i64, ptr %304, align 8
  %306 = icmp ne i64 %297, %305
  br i1 %306, label %307, label %316

307:                                              ; preds = %292
  %308 = load ptr, ptr %10, align 8
  %309 = getelementptr inbounds %struct.ptree, ptr %308, i32 0, i32 1
  %310 = load ptr, ptr %309, align 8
  %311 = load i32, ptr %13, align 4
  %312 = sext i32 %311 to i64
  %313 = getelementptr inbounds %struct.ptree_mask, ptr %310, i64 %312
  %314 = load ptr, ptr %12, align 8
  %315 = getelementptr inbounds %struct.ptree_mask, ptr %314, i32 1
  store ptr %315, ptr %12, align 8
  call void @bcopy(ptr noundef %313, ptr noundef %314, i64 noundef 16)
  br label %316

316:                                              ; preds = %307, %292
  br label %317

317:                                              ; preds = %316
  %318 = load i32, ptr %13, align 4
  %319 = add nsw i32 %318, 1
  store i32 %319, ptr %13, align 4
  br label %285, !llvm.loop !13

320:                                              ; preds = %285
  %321 = load ptr, ptr %10, align 8
  %322 = getelementptr inbounds %struct.ptree, ptr %321, i32 0, i32 2
  %323 = load i8, ptr %322, align 8
  %324 = add i8 %323, -1
  store i8 %324, ptr %322, align 8
  %325 = load ptr, ptr %10, align 8
  %326 = getelementptr inbounds %struct.ptree, ptr %325, i32 0, i32 1
  %327 = load ptr, ptr %326, align 8
  call void @free(ptr noundef %327)
  %328 = load ptr, ptr %11, align 8
  %329 = load ptr, ptr %10, align 8
  %330 = getelementptr inbounds %struct.ptree, ptr %329, i32 0, i32 1
  store ptr %328, ptr %330, align 8
  store i32 1, ptr %3, align 4
  br label %331

331:                                              ; preds = %320, %274, %237, %94, %81, %68, %24
  %332 = load i32, ptr %3, align 4
  ret i32 %332
}

; Function Attrs: noinline nounwind
define dso_local ptr @pat_search(i64 noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca ptr, align 8
  %8 = alloca i32, align 4
  store i64 %0, ptr %4, align 8
  store ptr %1, ptr %5, align 8
  store ptr null, ptr %6, align 8
  %9 = load ptr, ptr %5, align 8
  store ptr %9, ptr %7, align 8
  %10 = load ptr, ptr %7, align 8
  %11 = icmp ne ptr %10, null
  br i1 %11, label %13, label %12

12:                                               ; preds = %2
  store ptr null, ptr %3, align 8
  br label %75

13:                                               ; preds = %2
  br label %14

14:                                               ; preds = %50, %13
  %15 = load ptr, ptr %7, align 8
  %16 = getelementptr inbounds %struct.ptree, ptr %15, i32 0, i32 0
  %17 = load i64, ptr %16, align 8
  %18 = load i64, ptr %4, align 8
  %19 = load ptr, ptr %7, align 8
  %20 = getelementptr inbounds %struct.ptree, ptr %19, i32 0, i32 1
  %21 = load ptr, ptr %20, align 8
  %22 = getelementptr inbounds %struct.ptree_mask, ptr %21, i32 0, i32 0
  %23 = load i64, ptr %22, align 8
  %24 = and i64 %18, %23
  %25 = icmp eq i64 %17, %24
  br i1 %25, label %26, label %28

26:                                               ; preds = %14
  %27 = load ptr, ptr %7, align 8
  store ptr %27, ptr %6, align 8
  br label %28

28:                                               ; preds = %26, %14
  %29 = load ptr, ptr %7, align 8
  %30 = getelementptr inbounds %struct.ptree, ptr %29, i32 0, i32 3
  %31 = load i8, ptr %30, align 1
  %32 = zext i8 %31 to i32
  store i32 %32, ptr %8, align 4
  %33 = load ptr, ptr %7, align 8
  %34 = getelementptr inbounds %struct.ptree, ptr %33, i32 0, i32 3
  %35 = load i8, ptr %34, align 1
  %36 = zext i8 %35 to i32
  %37 = load i64, ptr %4, align 8
  %38 = call i64 @bit(i32 noundef signext %36, i64 noundef %37)
  %39 = icmp ne i64 %38, 0
  br i1 %39, label %40, label %44

40:                                               ; preds = %28
  %41 = load ptr, ptr %7, align 8
  %42 = getelementptr inbounds %struct.ptree, ptr %41, i32 0, i32 5
  %43 = load ptr, ptr %42, align 8
  br label %48

44:                                               ; preds = %28
  %45 = load ptr, ptr %7, align 8
  %46 = getelementptr inbounds %struct.ptree, ptr %45, i32 0, i32 4
  %47 = load ptr, ptr %46, align 8
  br label %48

48:                                               ; preds = %44, %40
  %49 = phi ptr [ %43, %40 ], [ %47, %44 ]
  store ptr %49, ptr %7, align 8
  br label %50

50:                                               ; preds = %48
  %51 = load i32, ptr %8, align 4
  %52 = load ptr, ptr %7, align 8
  %53 = getelementptr inbounds %struct.ptree, ptr %52, i32 0, i32 3
  %54 = load i8, ptr %53, align 1
  %55 = zext i8 %54 to i32
  %56 = icmp slt i32 %51, %55
  br i1 %56, label %14, label %57, !llvm.loop !14

57:                                               ; preds = %50
  %58 = load ptr, ptr %7, align 8
  %59 = getelementptr inbounds %struct.ptree, ptr %58, i32 0, i32 0
  %60 = load i64, ptr %59, align 8
  %61 = load i64, ptr %4, align 8
  %62 = load ptr, ptr %7, align 8
  %63 = getelementptr inbounds %struct.ptree, ptr %62, i32 0, i32 1
  %64 = load ptr, ptr %63, align 8
  %65 = getelementptr inbounds %struct.ptree_mask, ptr %64, i32 0, i32 0
  %66 = load i64, ptr %65, align 8
  %67 = and i64 %61, %66
  %68 = icmp eq i64 %60, %67
  br i1 %68, label %69, label %71

69:                                               ; preds = %57
  %70 = load ptr, ptr %7, align 8
  br label %73

71:                                               ; preds = %57
  %72 = load ptr, ptr %6, align 8
  br label %73

73:                                               ; preds = %71, %69
  %74 = phi ptr [ %70, %69 ], [ %72, %71 ]
  store ptr %74, ptr %3, align 8
  br label %75

75:                                               ; preds = %73, %12
  %76 = load ptr, ptr %3, align 8
  ret ptr %76
}

attributes #0 = { noinline nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #2 = { allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-features"="+64bit,+a,+c,+d,+f,+m,+relax,-save-restore" }
attributes #3 = { allocsize(0) }

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
!10 = distinct !{!10, !6}
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
