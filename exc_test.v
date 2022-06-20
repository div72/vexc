module vexc

fn test_successful_try() {
    if C.try() {
        end_try()
    } else {
        assert false
    }
}

fn test_catch() {
    if C.try() {
        raise("ZeroDivisionError", "division or modulo by zero")
        assert false
        end_try()
    } else {
        return
    }
    assert false
}

fn test_inner() {
    mut flag := false

    if C.try() {
        if C.try() {
            if C.try() {
                raise("RuntimeError", "invalid country NZ")
                assert false
                end_try()
            } else {
                assert true
            }
            end_try()
        } else {
            assert false
        }
        raise("", "")
        end_try()
    } else {
        flag = true
    }
    assert flag
}
