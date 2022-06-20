# vexc

Exceptions using setjmp/longjmp in V.


## Why?

This project is essentially done for the Python to V transpilation effort in [py2many](https://github.com/py2many/py2many). You can use it in your projects but using V's error handling is recommended.


## Example

```v
import os
import div72.vexc

fn main() {
    if C.try() {
        if os.args.len < 2 {
            vexc.raise("MissingArgsError", "You need to provide two args.")
        }
        nom := os.args[1].int()
        denom := os.args[2].int()
        println(nom / denom)
        vexc.end_try()
    } else {
        println(vexc.get_curr_exc().str())
    }
}
```

```
$ v run example.v
MissingArgsError: You need to provide two args.
$ v run example.v 10 2
5
```


## Installation

You can either clone to repo or use `v install div72.xyz`.
