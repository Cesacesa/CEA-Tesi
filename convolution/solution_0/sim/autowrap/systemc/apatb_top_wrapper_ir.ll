; ModuleID = '/home/lorenzor/workspace/convolution/convolution/solution_0/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_int<45>" = type { %"struct.ap_int_base<45, true>" }
%"struct.ap_int_base<45, true>" = type { %"struct.ssdm_int<45, true>" }
%"struct.ssdm_int<45, true>" = type { i45 }

; Function Attrs: noinline
define void @apatb_top_wrapper_ir([9 x [50 x %"struct.ap_int<45>"]]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %memory_in, i32* noalias nocapture nonnull readonly "maxi" %filter_val, [11 x [11 x [2 x %"struct.ap_int<45>"]]]* noalias nocapture nonnull "fpga.decayed.dim.hint"="5" "maxi" %memory) local_unnamed_addr #0 {
entry:
  %0 = bitcast [9 x [50 x %"struct.ap_int<45>"]]* %memory_in to [5 x [9 x [50 x %"struct.ap_int<45>"]]]*
  %1 = call i8* @malloc(i64 18000)
  %memory_in_copy = bitcast i8* %1 to [5 x [9 x [50 x %"struct.ap_int<45>"]]]*
  %2 = bitcast i32* %filter_val to [100 x i32]*
  %filter_val_copy = alloca [100 x i32], align 512
  %3 = bitcast [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %memory to [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]*
  %4 = call i8* @malloc(i64 9680)
  %memory_copy = bitcast i8* %4 to [5 x [11 x [11 x [2 x i64]]]]*
  call fastcc void @copy_in([5 x [9 x [50 x %"struct.ap_int<45>"]]]* nonnull %0, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %memory_in_copy, [100 x i32]* nonnull %2, [100 x i32]* nonnull align 512 %filter_val_copy, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* nonnull %3, [5 x [11 x [11 x [2 x i64]]]]* %memory_copy)
  call void @apatb_top_wrapper_hw([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %memory_in_copy, [100 x i32]* %filter_val_copy, [5 x [11 x [11 x [2 x i64]]]]* %memory_copy)
  call void @copy_back([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %memory_in_copy, [100 x i32]* %2, [100 x i32]* %filter_val_copy, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %3, [5 x [11 x [11 x [2 x i64]]]]* %memory_copy)
  tail call void @free(i8* %1)
  call void @free(i8* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([5 x [9 x [50 x %"struct.ap_int<45>"]]]* readonly, [5 x [9 x [50 x %"struct.ap_int<45>"]]]*, [100 x i32]* readonly, [100 x i32]* align 512, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* readonly, [5 x [11 x [11 x [2 x i64]]]]*) unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a5a9a50struct.ap_int<45>"([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %1, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0)
  call fastcc void @onebyonecpy_hls.p0a100i32([100 x i32]* align 512 %3, [100 x i32]* %2)
  call fastcc void @"onebyonecpy_hls.p0a5a11a11a2struct.ap_int<45>"([5 x [11 x [11 x [2 x i64]]]]* %5, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a5a9a50struct.ap_int<45>"([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %dst, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %dst, null
  %1 = icmp eq [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a5a9a50struct.ap_int<45>"([5 x [9 x [50 x %"struct.ap_int<45>"]]]* nonnull %dst, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a5a9a50struct.ap_int<45>"([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %dst, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %src, null
  %1 = icmp eq [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [9 x [50 x %"struct.ap_int<45>"]]], [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [9 x [50 x %"struct.ap_int<45>"]]], [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a9a50struct.ap_int<45>"([9 x [50 x %"struct.ap_int<45>"]]* %dst.addr, [9 x [50 x %"struct.ap_int<45>"]]* %src.addr, i64 9)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a9a50struct.ap_int<45>"([9 x [50 x %"struct.ap_int<45>"]]* %dst, [9 x [50 x %"struct.ap_int<45>"]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [9 x [50 x %"struct.ap_int<45>"]]* %src, null
  %1 = icmp eq [9 x [50 x %"struct.ap_int<45>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [9 x [50 x %"struct.ap_int<45>"]], [9 x [50 x %"struct.ap_int<45>"]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [9 x [50 x %"struct.ap_int<45>"]], [9 x [50 x %"struct.ap_int<45>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a50struct.ap_int<45>"([50 x %"struct.ap_int<45>"]* %dst.addr, [50 x %"struct.ap_int<45>"]* %src.addr, i64 50)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a50struct.ap_int<45>"([50 x %"struct.ap_int<45>"]* %dst, [50 x %"struct.ap_int<45>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [50 x %"struct.ap_int<45>"]* %src, null
  %1 = icmp eq [50 x %"struct.ap_int<45>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [50 x %"struct.ap_int<45>"], [50 x %"struct.ap_int<45>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [50 x %"struct.ap_int<45>"], [50 x %"struct.ap_int<45>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = bitcast i45* %src.addr.0.0.05 to i48*
  %4 = load i48, i48* %3
  %5 = trunc i48 %4 to i45
  store i45 %5, i45* %dst.addr.0.0.06, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a100i32([100 x i32]* align 512 %dst, [100 x i32]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [100 x i32]* %dst, null
  %1 = icmp eq [100 x i32]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a100i32([100 x i32]* nonnull %dst, [100 x i32]* nonnull %src, i64 100)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a100i32([100 x i32]* %dst, [100 x i32]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [100 x i32]* %src, null
  %1 = icmp eq [100 x i32]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [100 x i32], [100 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [100 x i32], [100 x i32]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i32, i32* %src.addr, align 4
  store i32 %3, i32* %dst.addr, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a5a11a11a2struct.ap_int<45>"([5 x [11 x [11 x [2 x i64]]]]* %dst, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [11 x [11 x [2 x i64]]]]* %dst, null
  %1 = icmp eq [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a5a11a11a2struct.ap_int<45>"([5 x [11 x [11 x [2 x i64]]]]* nonnull %dst, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a5a11a11a2struct.ap_int<45>"([5 x [11 x [11 x [2 x i64]]]]* %dst, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %src, null
  %1 = icmp eq [5 x [11 x [11 x [2 x i64]]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [5 x [11 x [11 x [2 x i64]]]], [5 x [11 x [11 x [2 x i64]]]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]], [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a11a11a2struct.ap_int<45>"([11 x [11 x [2 x i64]]]* %3, [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %src.addr, i64 11)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a11a11a2struct.ap_int<45>"([11 x [11 x [2 x i64]]]* %dst, [11 x [11 x [2 x %"struct.ap_int<45>"]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %src, null
  %1 = icmp eq [11 x [11 x [2 x i64]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [11 x [11 x [2 x i64]]], [11 x [11 x [2 x i64]]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [11 x [11 x [2 x %"struct.ap_int<45>"]]], [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a11a2struct.ap_int<45>"([11 x [2 x i64]]* %3, [11 x [2 x %"struct.ap_int<45>"]]* %src.addr, i64 11)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a11a2struct.ap_int<45>"([11 x [2 x i64]]* %dst, [11 x [2 x %"struct.ap_int<45>"]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [11 x [2 x %"struct.ap_int<45>"]]* %src, null
  %1 = icmp eq [11 x [2 x i64]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [11 x [2 x i64]], [11 x [2 x i64]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [11 x [2 x %"struct.ap_int<45>"]], [11 x [2 x %"struct.ap_int<45>"]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<45>"([2 x i64]* %3, [2 x %"struct.ap_int<45>"]* %src.addr, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<45>"([2 x i64]* %dst, [2 x %"struct.ap_int<45>"]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x %"struct.ap_int<45>"]* %src, null
  %1 = icmp eq [2 x i64]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2 x %"struct.ap_int<45>"], [2 x %"struct.ap_int<45>"]* %src, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %3 = getelementptr [2 x i64], [2 x i64]* %dst, i64 0, i64 %for.loop.idx8
  %4 = bitcast i45* %src.addr.0.0.05 to i48*
  %5 = load i48, i48* %4
  %6 = trunc i48 %5 to i45
  %7 = zext i45 %6 to i64
  store i64 %7, i64* %3, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([5 x [9 x [50 x %"struct.ap_int<45>"]]]*, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* readonly, [100 x i32]*, [100 x i32]* readonly align 512, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]*, [5 x [11 x [11 x [2 x i64]]]]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a5a9a50struct.ap_int<45>"([5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %1)
  call fastcc void @onebyonecpy_hls.p0a100i32([100 x i32]* %2, [100 x i32]* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0a5a11a11a2struct.ap_int<45>.20"([5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4, [5 x [11 x [11 x [2 x i64]]]]* %5)
  ret void
}

declare i8* @malloc(i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a5a11a11a2struct.ap_int<45>.20"([5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %dst, [5 x [11 x [11 x [2 x i64]]]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %dst, null
  %1 = icmp eq [5 x [11 x [11 x [2 x i64]]]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a5a11a11a2struct.ap_int<45>.23"([5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* nonnull %dst, [5 x [11 x [11 x [2 x i64]]]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a5a11a11a2struct.ap_int<45>.23"([5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %dst, [5 x [11 x [11 x [2 x i64]]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [11 x [11 x [2 x i64]]]]* %src, null
  %1 = icmp eq [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]], [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [5 x [11 x [11 x [2 x i64]]]], [5 x [11 x [11 x [2 x i64]]]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a11a11a2struct.ap_int<45>.26"([11 x [11 x [2 x %"struct.ap_int<45>"]]]* %dst.addr, [11 x [11 x [2 x i64]]]* %3, i64 11)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a11a11a2struct.ap_int<45>.26"([11 x [11 x [2 x %"struct.ap_int<45>"]]]* %dst, [11 x [11 x [2 x i64]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [11 x [11 x [2 x i64]]]* %src, null
  %1 = icmp eq [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [11 x [11 x [2 x %"struct.ap_int<45>"]]], [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [11 x [11 x [2 x i64]]], [11 x [11 x [2 x i64]]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a11a2struct.ap_int<45>.29"([11 x [2 x %"struct.ap_int<45>"]]* %dst.addr, [11 x [2 x i64]]* %3, i64 11)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a11a2struct.ap_int<45>.29"([11 x [2 x %"struct.ap_int<45>"]]* %dst, [11 x [2 x i64]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [11 x [2 x i64]]* %src, null
  %1 = icmp eq [11 x [2 x %"struct.ap_int<45>"]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [11 x [2 x %"struct.ap_int<45>"]], [11 x [2 x %"struct.ap_int<45>"]]* %dst, i64 0, i64 %for.loop.idx2
  %3 = getelementptr [11 x [2 x i64]], [11 x [2 x i64]]* %src, i64 0, i64 %for.loop.idx2
  call void @"arraycpy_hls.p0a2struct.ap_int<45>.32"([2 x %"struct.ap_int<45>"]* %dst.addr, [2 x i64]* %3, i64 2)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2struct.ap_int<45>.32"([2 x %"struct.ap_int<45>"]* %dst, [2 x i64]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2 x i64]* %src, null
  %1 = icmp eq [2 x %"struct.ap_int<45>"]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond7 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond7, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx8 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %3 = getelementptr [2 x i64], [2 x i64]* %src, i64 0, i64 %for.loop.idx8
  %dst.addr.0.0.06 = getelementptr [2 x %"struct.ap_int<45>"], [2 x %"struct.ap_int<45>"]* %dst, i64 0, i64 %for.loop.idx8, i32 0, i32 0, i32 0
  %4 = load i64, i64* %3, align 8
  %5 = call i45 @_llvm.fpga.unpack.none.i45.i64(i64 %4)
  store i45 %5, i45* %dst.addr.0.0.06, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx8, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: alwaysinline nounwind readnone willreturn
define internal i45 @_llvm.fpga.unpack.none.i45.i64(i64 %A) #5 {
  %A.cast = trunc i64 %A to i45
  ret i45 %A.cast
}

declare void @apatb_top_wrapper_hw([5 x [9 x [50 x %"struct.ap_int<45>"]]]*, [100 x i32]*, [5 x [11 x [11 x [2 x i64]]]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([5 x [9 x [50 x %"struct.ap_int<45>"]]]*, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* readonly, [100 x i32]*, [100 x i32]* readonly align 512, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]*, [5 x [11 x [11 x [2 x i64]]]]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0a5a11a11a2struct.ap_int<45>.20"([5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4, [5 x [11 x [11 x [2 x i64]]]]* %5)
  ret void
}

declare void @top_wrapper_hw_stub([9 x [50 x %"struct.ap_int<45>"]]* noalias nocapture nonnull readonly, i32* noalias nocapture nonnull readonly, [11 x [11 x [2 x %"struct.ap_int<45>"]]]* noalias nocapture nonnull)

define void @top_wrapper_hw_stub_wrapper([5 x [9 x [50 x %"struct.ap_int<45>"]]]*, [100 x i32]*, [5 x [11 x [11 x [2 x i64]]]]*) #6 {
entry:
  %3 = call i8* @malloc(i64 9680)
  %4 = bitcast i8* %3 to [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]*
  call void @copy_out([5 x [9 x [50 x %"struct.ap_int<45>"]]]* null, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0, [100 x i32]* null, [100 x i32]* %1, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4, [5 x [11 x [11 x [2 x i64]]]]* %2)
  %5 = bitcast [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0 to [9 x [50 x %"struct.ap_int<45>"]]*
  %6 = bitcast [100 x i32]* %1 to i32*
  %7 = bitcast [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4 to [11 x [11 x [2 x %"struct.ap_int<45>"]]]*
  call void @top_wrapper_hw_stub([9 x [50 x %"struct.ap_int<45>"]]* %5, i32* %6, [11 x [11 x [2 x %"struct.ap_int<45>"]]]* %7)
  call void @copy_in([5 x [9 x [50 x %"struct.ap_int<45>"]]]* null, [5 x [9 x [50 x %"struct.ap_int<45>"]]]* %0, [100 x i32]* null, [100 x i32]* %1, [5 x [11 x [11 x [2 x %"struct.ap_int<45>"]]]]* %4, [5 x [11 x [11 x [2 x i64]]]]* %2)
  call void @free(i8* %3)
  ret void
}

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { alwaysinline nounwind readnone willreturn }
attributes #6 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
