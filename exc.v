[translated]
module vexc

import datatypes
import os

#include <setjmp.h>

[typedef]
struct C.jmp_buf {}

struct JumpBuf {
    buf C.jmp_buf
}

// TODO: Handlers are retained after successful runs.
// TODO: The realloc cause issues with libgc.
#define try() setjmp(*(handler_stack = realloc(handler_stack, ++handler_len))) == 0

fn C.try() bool
fn C.longjmp(env C.jmp_buf, val int)

__global (
    handler_stack = &C.jmp_buf(0)
    handler_len = 0
    curr_exc = &Exception(0)
)

[heap]
struct Exception {
    name string
    msg string
}

pub fn (e &Exception) str() string {
    return "$e.name: $e.msg"
}

[no_return]
pub fn raise(name string, msg string) {
    curr_exc = &Exception{name, msg}
    if handler_len == 0 {
        panic(curr_exc.str())
    }
    handler_len -= 1
    C.longjmp(handler_stack[handler_len], 1)
}

[_constructor]
fn raise_on_signals() {
    os.signal_opt(.fpe, fn (_ os.Signal) { raise("ArithmeticError", "SIGFPE") }) or {}
}
