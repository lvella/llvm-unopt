(module
  (type (;0;) (func (param i32 i32)))
  (import "env" "__linear_memory" (memory (;0;) 0))
  (import "env" "__stack_pointer" (global (;0;) (mut i32)))
  (func $offset_folding_bug (type 0) (param i32 i32)
    (local i32 i32 i32 i32)
    global.get 0
    i32.const 800
    i32.sub
    local.tee 2
    global.set 0
    local.get 1
    i32.const 1
    local.get 1
    i32.const 1
    i32.gt_u
    select
    local.tee 3
    i32.const 3
    i32.and
    local.set 4
    i32.const 0
    local.set 5
    block  ;; label = @1
      local.get 1
      i32.const 4
      i32.lt_u
      br_if 0 (;@1;)
      local.get 3
      i32.const -4
      i32.and
      local.set 3
      i32.const 0
      local.set 5
      local.get 2
      local.set 1
      loop  ;; label = @2
        local.get 1
        i32.const 2576
        i32.add
        local.get 1
        i32.const 8
        i32.add
        i64.load
        i64.store
        local.get 1
        i32.const 2584
        i32.add
        local.get 1
        i32.const 16
        i32.add
        i64.load
        i64.store
        local.get 1
        i32.const 2592
        i32.add
        local.get 1
        i32.const 24
        i32.add
        i64.load
        i64.store
        local.get 1
        i32.const 2600
        i32.add
        local.get 1
        i32.const 32
        i32.add
        local.tee 1
        i64.load
        i64.store
        local.get 3
        local.get 5
        i32.const 4
        i32.add
        local.tee 5
        i32.ne
        br_if 0 (;@2;)
      end
    end
    block  ;; label = @1
      local.get 4
      i32.eqz
      br_if 0 (;@1;)
      local.get 5
      i32.const 3
      i32.shl
      local.get 2
      i32.add
      i32.const 2576
      i32.add
      local.set 1
      loop  ;; label = @2
        local.get 1
        local.get 1
        i32.const -2568
        i32.add
        i64.load
        i64.store
        local.get 1
        i32.const 8
        i32.add
        local.set 1
        local.get 4
        i32.const -1
        i32.add
        local.tee 4
        br_if 0 (;@2;)
      end
    end
    local.get 2
    i32.const 800
    i32.add
    global.set 0))
