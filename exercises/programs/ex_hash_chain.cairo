// Task:
// Develop a function that is going to calculate Pedersen hash of an array of felts.
// Cairo's built in hash2 can calculate Pedersen hash on two field elements.
// To calculate hash of an array use hash chain algorith where hash of [1, 2, 3, 4] is is H(H(H(1, 2), 3), 4).

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2

func rec_hash_chain{hash_ptr: HashBuiltin*}(arr_ptr: felt*, arr_len: felt, last_result: felt) -> (result: felt) {
    let y = arr_ptr[0];

    if (arr_len == 1) {
        let (z) = hash2(last_result, y);
        return (result = z);
    }

    let (z) = hash2(last_result, y);

    return rec_hash_chain(arr_ptr + 1, arr_len - 1, z);
}

// Computes the Pedersen hash chain on an array of size `arr_len` starting from `arr_ptr`.
func hash_chain{hash_ptr: HashBuiltin*}(arr_ptr: felt*, arr_len: felt) -> (result: felt) {
    let x = arr_ptr[0];
    let y = arr_ptr[1];

    let (z) = hash2(x, y);

    if (arr_len == 2) {
        return (result = z);
    } else {
        return rec_hash_chain(arr_ptr + 2, arr_len - 2, z);
    }
}
