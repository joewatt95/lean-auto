import Auto.Tactic

set_option profiler true
set_option trace.auto.buildChecker true
set_option auto.optimizeCheckerProof false

-- Testing whether binders can cause quadratic complexity

partial def chopList (s : List α) (n : Nat) : List (List α) :=
  if n == 0 then
    [s]
  else
    if s.length < n then
      [s]
    else
      s.take n :: chopList (s.drop n) n

def test₁ (n : Nat) : String :=
  let range := List.range n
  let types := "(β : Type)" :: range.map (fun n => s!"(α{n} : Type {Nat.min (n / 10) 25})")
  let fnTy := range.map (fun n => s!"α{n}") ++ ["β"]
  let fnTy := (chopList fnTy 10).map (fun ss => String.intercalate " → " ss)
  let fnTy := String.intercalate " → \n    " fnTy
  let fdecl := s!"(f : {fnTy})"
  let gdecl := s!"(g : {fnTy})"
  let binders := "∀" :: (range.map (fun n => s!"x{n}"))
  let binders := (chopList binders 15).map (fun ss => String.intercalate " " ss)
  let binders := String.intercalate "\n    " binders ++ ",\n"
  let appArgs := range.map (fun n => s!"x{n}")
  let appArgs := (chopList appArgs 10).map (fun ss => String.intercalate " " ss)
  let appArgs := String.intercalate "\n      " appArgs
  let fapp := "  f " ++ appArgs
  let gapp := "  g " ++ appArgs
  let assertion := "(H : " ++ binders ++ " " ++ fapp ++ " =\n" ++ gapp ++ ")"
  let allDecls := types ++ [fdecl, gdecl, assertion]
  let exbody := "  " ++ String.intercalate "\n  " allDecls
  "example\n" ++ exbody ++ " : True := by auto"

#eval IO.println (test₁ 256)

example
  (β : Type)
  (α0 : Type 0)
  (α1 : Type 0)
  (α2 : Type 0)
  (α3 : Type 0)
  (α4 : Type 0)
  (α5 : Type 0)
  (α6 : Type 0)
  (α7 : Type 0)
  (α8 : Type 0)
  (α9 : Type 0)
  (α10 : Type 1)
  (α11 : Type 1)
  (α12 : Type 1)
  (α13 : Type 1)
  (α14 : Type 1)
  (α15 : Type 1)
  (f : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → β)
  (g : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → β)
  (H : ∀ x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13
    x14 x15,
   f x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 =
  g x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15) : True := by auto

example
  (β : Type)
  (α0 : Type 0)
  (α1 : Type 0)
  (α2 : Type 0)
  (α3 : Type 0)
  (α4 : Type 0)
  (α5 : Type 0)
  (α6 : Type 0)
  (α7 : Type 0)
  (α8 : Type 0)
  (α9 : Type 0)
  (α10 : Type 1)
  (α11 : Type 1)
  (α12 : Type 1)
  (α13 : Type 1)
  (α14 : Type 1)
  (α15 : Type 1)
  (α16 : Type 1)
  (α17 : Type 1)
  (α18 : Type 1)
  (α19 : Type 1)
  (α20 : Type 2)
  (α21 : Type 2)
  (α22 : Type 2)
  (α23 : Type 2)
  (α24 : Type 2)
  (α25 : Type 2)
  (α26 : Type 2)
  (α27 : Type 2)
  (α28 : Type 2)
  (α29 : Type 2)
  (α30 : Type 3)
  (α31 : Type 3)
  (f : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → β)
  (g : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → β)
  (H : ∀ x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13
    x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28
    x29 x30 x31,
   f x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 =
  g x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31) : True := by auto

set_option trace.auto.mono true in
set_option trace.auto.printLemmas true in
example
  (β : Type)
  (α0 : Type 0)
  (α1 : Type 0)
  (α2 : Type 0)
  (α3 : Type 0)
  (α4 : Type 0)
  (α5 : Type 0)
  (α6 : Type 0)
  (α7 : Type 0)
  (α8 : Type 0)
  (α9 : Type 0)
  (α10 : Type 1)
  (α11 : Type 1)
  (α12 : Type 1)
  (α13 : Type 1)
  (α14 : Type 1)
  (α15 : Type 1)
  (α16 : Type 1)
  (α17 : Type 1)
  (α18 : Type 1)
  (α19 : Type 1)
  (α20 : Type 2)
  (α21 : Type 2)
  (α22 : Type 2)
  (α23 : Type 2)
  (α24 : Type 2)
  (α25 : Type 2)
  (α26 : Type 2)
  (α27 : Type 2)
  (α28 : Type 2)
  (α29 : Type 2)
  (α30 : Type 3)
  (α31 : Type 3)
  (α32 : Type 3)
  (α33 : Type 3)
  (α34 : Type 3)
  (α35 : Type 3)
  (α36 : Type 3)
  (α37 : Type 3)
  (α38 : Type 3)
  (α39 : Type 3)
  (α40 : Type 4)
  (α41 : Type 4)
  (α42 : Type 4)
  (α43 : Type 4)
  (α44 : Type 4)
  (α45 : Type 4)
  (α46 : Type 4)
  (α47 : Type 4)
  (α48 : Type 4)
  (α49 : Type 4)
  (α50 : Type 5)
  (α51 : Type 5)
  (α52 : Type 5)
  (α53 : Type 5)
  (α54 : Type 5)
  (α55 : Type 5)
  (α56 : Type 5)
  (α57 : Type 5)
  (α58 : Type 5)
  (α59 : Type 5)
  (α60 : Type 6)
  (α61 : Type 6)
  (α62 : Type 6)
  (α63 : Type 6)
  (f : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → β)
  (g : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → β)
  (H : ∀ x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13
    x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28
    x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43
    x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58
    x59 x60 x61 x62 x63,
   f x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63 =
  g x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63) : True := by auto

set_option maxRecDepth 1000 in
example
  (β : Type)
  (α0 : Type 0)
  (α1 : Type 0)
  (α2 : Type 0)
  (α3 : Type 0)
  (α4 : Type 0)
  (α5 : Type 0)
  (α6 : Type 0)
  (α7 : Type 0)
  (α8 : Type 0)
  (α9 : Type 0)
  (α10 : Type 1)
  (α11 : Type 1)
  (α12 : Type 1)
  (α13 : Type 1)
  (α14 : Type 1)
  (α15 : Type 1)
  (α16 : Type 1)
  (α17 : Type 1)
  (α18 : Type 1)
  (α19 : Type 1)
  (α20 : Type 2)
  (α21 : Type 2)
  (α22 : Type 2)
  (α23 : Type 2)
  (α24 : Type 2)
  (α25 : Type 2)
  (α26 : Type 2)
  (α27 : Type 2)
  (α28 : Type 2)
  (α29 : Type 2)
  (α30 : Type 3)
  (α31 : Type 3)
  (α32 : Type 3)
  (α33 : Type 3)
  (α34 : Type 3)
  (α35 : Type 3)
  (α36 : Type 3)
  (α37 : Type 3)
  (α38 : Type 3)
  (α39 : Type 3)
  (α40 : Type 4)
  (α41 : Type 4)
  (α42 : Type 4)
  (α43 : Type 4)
  (α44 : Type 4)
  (α45 : Type 4)
  (α46 : Type 4)
  (α47 : Type 4)
  (α48 : Type 4)
  (α49 : Type 4)
  (α50 : Type 5)
  (α51 : Type 5)
  (α52 : Type 5)
  (α53 : Type 5)
  (α54 : Type 5)
  (α55 : Type 5)
  (α56 : Type 5)
  (α57 : Type 5)
  (α58 : Type 5)
  (α59 : Type 5)
  (α60 : Type 6)
  (α61 : Type 6)
  (α62 : Type 6)
  (α63 : Type 6)
  (α64 : Type 6)
  (α65 : Type 6)
  (α66 : Type 6)
  (α67 : Type 6)
  (α68 : Type 6)
  (α69 : Type 6)
  (α70 : Type 7)
  (α71 : Type 7)
  (α72 : Type 7)
  (α73 : Type 7)
  (α74 : Type 7)
  (α75 : Type 7)
  (α76 : Type 7)
  (α77 : Type 7)
  (α78 : Type 7)
  (α79 : Type 7)
  (α80 : Type 8)
  (α81 : Type 8)
  (α82 : Type 8)
  (α83 : Type 8)
  (α84 : Type 8)
  (α85 : Type 8)
  (α86 : Type 8)
  (α87 : Type 8)
  (α88 : Type 8)
  (α89 : Type 8)
  (α90 : Type 9)
  (α91 : Type 9)
  (α92 : Type 9)
  (α93 : Type 9)
  (α94 : Type 9)
  (α95 : Type 9)
  (α96 : Type 9)
  (α97 : Type 9)
  (α98 : Type 9)
  (α99 : Type 9)
  (α100 : Type 10)
  (α101 : Type 10)
  (α102 : Type 10)
  (α103 : Type 10)
  (α104 : Type 10)
  (α105 : Type 10)
  (α106 : Type 10)
  (α107 : Type 10)
  (α108 : Type 10)
  (α109 : Type 10)
  (α110 : Type 11)
  (α111 : Type 11)
  (α112 : Type 11)
  (α113 : Type 11)
  (α114 : Type 11)
  (α115 : Type 11)
  (α116 : Type 11)
  (α117 : Type 11)
  (α118 : Type 11)
  (α119 : Type 11)
  (α120 : Type 12)
  (α121 : Type 12)
  (α122 : Type 12)
  (α123 : Type 12)
  (α124 : Type 12)
  (α125 : Type 12)
  (α126 : Type 12)
  (α127 : Type 12)
  (f : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → α64 → α65 → α66 → α67 → α68 → α69 → 
    α70 → α71 → α72 → α73 → α74 → α75 → α76 → α77 → α78 → α79 → 
    α80 → α81 → α82 → α83 → α84 → α85 → α86 → α87 → α88 → α89 → 
    α90 → α91 → α92 → α93 → α94 → α95 → α96 → α97 → α98 → α99 → 
    α100 → α101 → α102 → α103 → α104 → α105 → α106 → α107 → α108 → α109 → 
    α110 → α111 → α112 → α113 → α114 → α115 → α116 → α117 → α118 → α119 → 
    α120 → α121 → α122 → α123 → α124 → α125 → α126 → α127 → β)
  (g : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → α64 → α65 → α66 → α67 → α68 → α69 → 
    α70 → α71 → α72 → α73 → α74 → α75 → α76 → α77 → α78 → α79 → 
    α80 → α81 → α82 → α83 → α84 → α85 → α86 → α87 → α88 → α89 → 
    α90 → α91 → α92 → α93 → α94 → α95 → α96 → α97 → α98 → α99 → 
    α100 → α101 → α102 → α103 → α104 → α105 → α106 → α107 → α108 → α109 → 
    α110 → α111 → α112 → α113 → α114 → α115 → α116 → α117 → α118 → α119 → 
    α120 → α121 → α122 → α123 → α124 → α125 → α126 → α127 → β)
  (H : ∀ x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13
    x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28
    x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43
    x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58
    x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73
    x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88
    x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103
    x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118
    x119 x120 x121 x122 x123 x124 x125 x126 x127,
   f x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63 x64 x65 x66 x67 x68 x69
      x70 x71 x72 x73 x74 x75 x76 x77 x78 x79
      x80 x81 x82 x83 x84 x85 x86 x87 x88 x89
      x90 x91 x92 x93 x94 x95 x96 x97 x98 x99
      x100 x101 x102 x103 x104 x105 x106 x107 x108 x109
      x110 x111 x112 x113 x114 x115 x116 x117 x118 x119
      x120 x121 x122 x123 x124 x125 x126 x127 =
  g x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63 x64 x65 x66 x67 x68 x69
      x70 x71 x72 x73 x74 x75 x76 x77 x78 x79
      x80 x81 x82 x83 x84 x85 x86 x87 x88 x89
      x90 x91 x92 x93 x94 x95 x96 x97 x98 x99
      x100 x101 x102 x103 x104 x105 x106 x107 x108 x109
      x110 x111 x112 x113 x114 x115 x116 x117 x118 x119
      x120 x121 x122 x123 x124 x125 x126 x127) : True := by auto

set_option maxRecDepth 2000 in
example
  (β : Type)
  (α0 : Type 0)
  (α1 : Type 0)
  (α2 : Type 0)
  (α3 : Type 0)
  (α4 : Type 0)
  (α5 : Type 0)
  (α6 : Type 0)
  (α7 : Type 0)
  (α8 : Type 0)
  (α9 : Type 0)
  (α10 : Type 1)
  (α11 : Type 1)
  (α12 : Type 1)
  (α13 : Type 1)
  (α14 : Type 1)
  (α15 : Type 1)
  (α16 : Type 1)
  (α17 : Type 1)
  (α18 : Type 1)
  (α19 : Type 1)
  (α20 : Type 2)
  (α21 : Type 2)
  (α22 : Type 2)
  (α23 : Type 2)
  (α24 : Type 2)
  (α25 : Type 2)
  (α26 : Type 2)
  (α27 : Type 2)
  (α28 : Type 2)
  (α29 : Type 2)
  (α30 : Type 3)
  (α31 : Type 3)
  (α32 : Type 3)
  (α33 : Type 3)
  (α34 : Type 3)
  (α35 : Type 3)
  (α36 : Type 3)
  (α37 : Type 3)
  (α38 : Type 3)
  (α39 : Type 3)
  (α40 : Type 4)
  (α41 : Type 4)
  (α42 : Type 4)
  (α43 : Type 4)
  (α44 : Type 4)
  (α45 : Type 4)
  (α46 : Type 4)
  (α47 : Type 4)
  (α48 : Type 4)
  (α49 : Type 4)
  (α50 : Type 5)
  (α51 : Type 5)
  (α52 : Type 5)
  (α53 : Type 5)
  (α54 : Type 5)
  (α55 : Type 5)
  (α56 : Type 5)
  (α57 : Type 5)
  (α58 : Type 5)
  (α59 : Type 5)
  (α60 : Type 6)
  (α61 : Type 6)
  (α62 : Type 6)
  (α63 : Type 6)
  (α64 : Type 6)
  (α65 : Type 6)
  (α66 : Type 6)
  (α67 : Type 6)
  (α68 : Type 6)
  (α69 : Type 6)
  (α70 : Type 7)
  (α71 : Type 7)
  (α72 : Type 7)
  (α73 : Type 7)
  (α74 : Type 7)
  (α75 : Type 7)
  (α76 : Type 7)
  (α77 : Type 7)
  (α78 : Type 7)
  (α79 : Type 7)
  (α80 : Type 8)
  (α81 : Type 8)
  (α82 : Type 8)
  (α83 : Type 8)
  (α84 : Type 8)
  (α85 : Type 8)
  (α86 : Type 8)
  (α87 : Type 8)
  (α88 : Type 8)
  (α89 : Type 8)
  (α90 : Type 9)
  (α91 : Type 9)
  (α92 : Type 9)
  (α93 : Type 9)
  (α94 : Type 9)
  (α95 : Type 9)
  (α96 : Type 9)
  (α97 : Type 9)
  (α98 : Type 9)
  (α99 : Type 9)
  (α100 : Type 10)
  (α101 : Type 10)
  (α102 : Type 10)
  (α103 : Type 10)
  (α104 : Type 10)
  (α105 : Type 10)
  (α106 : Type 10)
  (α107 : Type 10)
  (α108 : Type 10)
  (α109 : Type 10)
  (α110 : Type 11)
  (α111 : Type 11)
  (α112 : Type 11)
  (α113 : Type 11)
  (α114 : Type 11)
  (α115 : Type 11)
  (α116 : Type 11)
  (α117 : Type 11)
  (α118 : Type 11)
  (α119 : Type 11)
  (α120 : Type 12)
  (α121 : Type 12)
  (α122 : Type 12)
  (α123 : Type 12)
  (α124 : Type 12)
  (α125 : Type 12)
  (α126 : Type 12)
  (α127 : Type 12)
  (α128 : Type 12)
  (α129 : Type 12)
  (α130 : Type 13)
  (α131 : Type 13)
  (α132 : Type 13)
  (α133 : Type 13)
  (α134 : Type 13)
  (α135 : Type 13)
  (α136 : Type 13)
  (α137 : Type 13)
  (α138 : Type 13)
  (α139 : Type 13)
  (α140 : Type 14)
  (α141 : Type 14)
  (α142 : Type 14)
  (α143 : Type 14)
  (α144 : Type 14)
  (α145 : Type 14)
  (α146 : Type 14)
  (α147 : Type 14)
  (α148 : Type 14)
  (α149 : Type 14)
  (α150 : Type 15)
  (α151 : Type 15)
  (α152 : Type 15)
  (α153 : Type 15)
  (α154 : Type 15)
  (α155 : Type 15)
  (α156 : Type 15)
  (α157 : Type 15)
  (α158 : Type 15)
  (α159 : Type 15)
  (α160 : Type 16)
  (α161 : Type 16)
  (α162 : Type 16)
  (α163 : Type 16)
  (α164 : Type 16)
  (α165 : Type 16)
  (α166 : Type 16)
  (α167 : Type 16)
  (α168 : Type 16)
  (α169 : Type 16)
  (α170 : Type 17)
  (α171 : Type 17)
  (α172 : Type 17)
  (α173 : Type 17)
  (α174 : Type 17)
  (α175 : Type 17)
  (α176 : Type 17)
  (α177 : Type 17)
  (α178 : Type 17)
  (α179 : Type 17)
  (α180 : Type 18)
  (α181 : Type 18)
  (α182 : Type 18)
  (α183 : Type 18)
  (α184 : Type 18)
  (α185 : Type 18)
  (α186 : Type 18)
  (α187 : Type 18)
  (α188 : Type 18)
  (α189 : Type 18)
  (α190 : Type 19)
  (α191 : Type 19)
  (α192 : Type 19)
  (α193 : Type 19)
  (α194 : Type 19)
  (α195 : Type 19)
  (α196 : Type 19)
  (α197 : Type 19)
  (α198 : Type 19)
  (α199 : Type 19)
  (α200 : Type 20)
  (α201 : Type 20)
  (α202 : Type 20)
  (α203 : Type 20)
  (α204 : Type 20)
  (α205 : Type 20)
  (α206 : Type 20)
  (α207 : Type 20)
  (α208 : Type 20)
  (α209 : Type 20)
  (α210 : Type 21)
  (α211 : Type 21)
  (α212 : Type 21)
  (α213 : Type 21)
  (α214 : Type 21)
  (α215 : Type 21)
  (α216 : Type 21)
  (α217 : Type 21)
  (α218 : Type 21)
  (α219 : Type 21)
  (α220 : Type 22)
  (α221 : Type 22)
  (α222 : Type 22)
  (α223 : Type 22)
  (α224 : Type 22)
  (α225 : Type 22)
  (α226 : Type 22)
  (α227 : Type 22)
  (α228 : Type 22)
  (α229 : Type 22)
  (α230 : Type 23)
  (α231 : Type 23)
  (α232 : Type 23)
  (α233 : Type 23)
  (α234 : Type 23)
  (α235 : Type 23)
  (α236 : Type 23)
  (α237 : Type 23)
  (α238 : Type 23)
  (α239 : Type 23)
  (α240 : Type 24)
  (α241 : Type 24)
  (α242 : Type 24)
  (α243 : Type 24)
  (α244 : Type 24)
  (α245 : Type 24)
  (α246 : Type 24)
  (α247 : Type 24)
  (α248 : Type 24)
  (α249 : Type 24)
  (α250 : Type 25)
  (α251 : Type 25)
  (α252 : Type 25)
  (α253 : Type 25)
  (α254 : Type 25)
  (α255 : Type 25)
  (f : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → α64 → α65 → α66 → α67 → α68 → α69 → 
    α70 → α71 → α72 → α73 → α74 → α75 → α76 → α77 → α78 → α79 → 
    α80 → α81 → α82 → α83 → α84 → α85 → α86 → α87 → α88 → α89 → 
    α90 → α91 → α92 → α93 → α94 → α95 → α96 → α97 → α98 → α99 → 
    α100 → α101 → α102 → α103 → α104 → α105 → α106 → α107 → α108 → α109 → 
    α110 → α111 → α112 → α113 → α114 → α115 → α116 → α117 → α118 → α119 → 
    α120 → α121 → α122 → α123 → α124 → α125 → α126 → α127 → α128 → α129 → 
    α130 → α131 → α132 → α133 → α134 → α135 → α136 → α137 → α138 → α139 → 
    α140 → α141 → α142 → α143 → α144 → α145 → α146 → α147 → α148 → α149 → 
    α150 → α151 → α152 → α153 → α154 → α155 → α156 → α157 → α158 → α159 → 
    α160 → α161 → α162 → α163 → α164 → α165 → α166 → α167 → α168 → α169 → 
    α170 → α171 → α172 → α173 → α174 → α175 → α176 → α177 → α178 → α179 → 
    α180 → α181 → α182 → α183 → α184 → α185 → α186 → α187 → α188 → α189 → 
    α190 → α191 → α192 → α193 → α194 → α195 → α196 → α197 → α198 → α199 → 
    α200 → α201 → α202 → α203 → α204 → α205 → α206 → α207 → α208 → α209 → 
    α210 → α211 → α212 → α213 → α214 → α215 → α216 → α217 → α218 → α219 → 
    α220 → α221 → α222 → α223 → α224 → α225 → α226 → α227 → α228 → α229 → 
    α230 → α231 → α232 → α233 → α234 → α235 → α236 → α237 → α238 → α239 → 
    α240 → α241 → α242 → α243 → α244 → α245 → α246 → α247 → α248 → α249 → 
    α250 → α251 → α252 → α253 → α254 → α255 → β)
  (g : α0 → α1 → α2 → α3 → α4 → α5 → α6 → α7 → α8 → α9 → 
    α10 → α11 → α12 → α13 → α14 → α15 → α16 → α17 → α18 → α19 → 
    α20 → α21 → α22 → α23 → α24 → α25 → α26 → α27 → α28 → α29 → 
    α30 → α31 → α32 → α33 → α34 → α35 → α36 → α37 → α38 → α39 → 
    α40 → α41 → α42 → α43 → α44 → α45 → α46 → α47 → α48 → α49 → 
    α50 → α51 → α52 → α53 → α54 → α55 → α56 → α57 → α58 → α59 → 
    α60 → α61 → α62 → α63 → α64 → α65 → α66 → α67 → α68 → α69 → 
    α70 → α71 → α72 → α73 → α74 → α75 → α76 → α77 → α78 → α79 → 
    α80 → α81 → α82 → α83 → α84 → α85 → α86 → α87 → α88 → α89 → 
    α90 → α91 → α92 → α93 → α94 → α95 → α96 → α97 → α98 → α99 → 
    α100 → α101 → α102 → α103 → α104 → α105 → α106 → α107 → α108 → α109 → 
    α110 → α111 → α112 → α113 → α114 → α115 → α116 → α117 → α118 → α119 → 
    α120 → α121 → α122 → α123 → α124 → α125 → α126 → α127 → α128 → α129 → 
    α130 → α131 → α132 → α133 → α134 → α135 → α136 → α137 → α138 → α139 → 
    α140 → α141 → α142 → α143 → α144 → α145 → α146 → α147 → α148 → α149 → 
    α150 → α151 → α152 → α153 → α154 → α155 → α156 → α157 → α158 → α159 → 
    α160 → α161 → α162 → α163 → α164 → α165 → α166 → α167 → α168 → α169 → 
    α170 → α171 → α172 → α173 → α174 → α175 → α176 → α177 → α178 → α179 → 
    α180 → α181 → α182 → α183 → α184 → α185 → α186 → α187 → α188 → α189 → 
    α190 → α191 → α192 → α193 → α194 → α195 → α196 → α197 → α198 → α199 → 
    α200 → α201 → α202 → α203 → α204 → α205 → α206 → α207 → α208 → α209 → 
    α210 → α211 → α212 → α213 → α214 → α215 → α216 → α217 → α218 → α219 → 
    α220 → α221 → α222 → α223 → α224 → α225 → α226 → α227 → α228 → α229 → 
    α230 → α231 → α232 → α233 → α234 → α235 → α236 → α237 → α238 → α239 → 
    α240 → α241 → α242 → α243 → α244 → α245 → α246 → α247 → α248 → α249 → 
    α250 → α251 → α252 → α253 → α254 → α255 → β)
  (H : ∀ x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13
    x14 x15 x16 x17 x18 x19 x20 x21 x22 x23 x24 x25 x26 x27 x28
    x29 x30 x31 x32 x33 x34 x35 x36 x37 x38 x39 x40 x41 x42 x43
    x44 x45 x46 x47 x48 x49 x50 x51 x52 x53 x54 x55 x56 x57 x58
    x59 x60 x61 x62 x63 x64 x65 x66 x67 x68 x69 x70 x71 x72 x73
    x74 x75 x76 x77 x78 x79 x80 x81 x82 x83 x84 x85 x86 x87 x88
    x89 x90 x91 x92 x93 x94 x95 x96 x97 x98 x99 x100 x101 x102 x103
    x104 x105 x106 x107 x108 x109 x110 x111 x112 x113 x114 x115 x116 x117 x118
    x119 x120 x121 x122 x123 x124 x125 x126 x127 x128 x129 x130 x131 x132 x133
    x134 x135 x136 x137 x138 x139 x140 x141 x142 x143 x144 x145 x146 x147 x148
    x149 x150 x151 x152 x153 x154 x155 x156 x157 x158 x159 x160 x161 x162 x163
    x164 x165 x166 x167 x168 x169 x170 x171 x172 x173 x174 x175 x176 x177 x178
    x179 x180 x181 x182 x183 x184 x185 x186 x187 x188 x189 x190 x191 x192 x193
    x194 x195 x196 x197 x198 x199 x200 x201 x202 x203 x204 x205 x206 x207 x208
    x209 x210 x211 x212 x213 x214 x215 x216 x217 x218 x219 x220 x221 x222 x223
    x224 x225 x226 x227 x228 x229 x230 x231 x232 x233 x234 x235 x236 x237 x238
    x239 x240 x241 x242 x243 x244 x245 x246 x247 x248 x249 x250 x251 x252 x253
    x254 x255,
   f x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63 x64 x65 x66 x67 x68 x69
      x70 x71 x72 x73 x74 x75 x76 x77 x78 x79
      x80 x81 x82 x83 x84 x85 x86 x87 x88 x89
      x90 x91 x92 x93 x94 x95 x96 x97 x98 x99
      x100 x101 x102 x103 x104 x105 x106 x107 x108 x109
      x110 x111 x112 x113 x114 x115 x116 x117 x118 x119
      x120 x121 x122 x123 x124 x125 x126 x127 x128 x129
      x130 x131 x132 x133 x134 x135 x136 x137 x138 x139
      x140 x141 x142 x143 x144 x145 x146 x147 x148 x149
      x150 x151 x152 x153 x154 x155 x156 x157 x158 x159
      x160 x161 x162 x163 x164 x165 x166 x167 x168 x169
      x170 x171 x172 x173 x174 x175 x176 x177 x178 x179
      x180 x181 x182 x183 x184 x185 x186 x187 x188 x189
      x190 x191 x192 x193 x194 x195 x196 x197 x198 x199
      x200 x201 x202 x203 x204 x205 x206 x207 x208 x209
      x210 x211 x212 x213 x214 x215 x216 x217 x218 x219
      x220 x221 x222 x223 x224 x225 x226 x227 x228 x229
      x230 x231 x232 x233 x234 x235 x236 x237 x238 x239
      x240 x241 x242 x243 x244 x245 x246 x247 x248 x249
      x250 x251 x252 x253 x254 x255 =
  g x0 x1 x2 x3 x4 x5 x6 x7 x8 x9
      x10 x11 x12 x13 x14 x15 x16 x17 x18 x19
      x20 x21 x22 x23 x24 x25 x26 x27 x28 x29
      x30 x31 x32 x33 x34 x35 x36 x37 x38 x39
      x40 x41 x42 x43 x44 x45 x46 x47 x48 x49
      x50 x51 x52 x53 x54 x55 x56 x57 x58 x59
      x60 x61 x62 x63 x64 x65 x66 x67 x68 x69
      x70 x71 x72 x73 x74 x75 x76 x77 x78 x79
      x80 x81 x82 x83 x84 x85 x86 x87 x88 x89
      x90 x91 x92 x93 x94 x95 x96 x97 x98 x99
      x100 x101 x102 x103 x104 x105 x106 x107 x108 x109
      x110 x111 x112 x113 x114 x115 x116 x117 x118 x119
      x120 x121 x122 x123 x124 x125 x126 x127 x128 x129
      x130 x131 x132 x133 x134 x135 x136 x137 x138 x139
      x140 x141 x142 x143 x144 x145 x146 x147 x148 x149
      x150 x151 x152 x153 x154 x155 x156 x157 x158 x159
      x160 x161 x162 x163 x164 x165 x166 x167 x168 x169
      x170 x171 x172 x173 x174 x175 x176 x177 x178 x179
      x180 x181 x182 x183 x184 x185 x186 x187 x188 x189
      x190 x191 x192 x193 x194 x195 x196 x197 x198 x199
      x200 x201 x202 x203 x204 x205 x206 x207 x208 x209
      x210 x211 x212 x213 x214 x215 x216 x217 x218 x219
      x220 x221 x222 x223 x224 x225 x226 x227 x228 x229
      x230 x231 x232 x233 x234 x235 x236 x237 x238 x239
      x240 x241 x242 x243 x244 x245 x246 x247 x248 x249
      x250 x251 x252 x253 x254 x255) : True := by auto