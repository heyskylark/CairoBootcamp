from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    if (arr_len == idx) {
        return (run,);
    }

    let arr_val = arr[idx];
    let new_idx = idx + 1;
    let (x_and_y) = bitwise_and(arr_val, 1);

    if (x_and_y == 0) {
        let new_run = run + arr_val;
        return sum_even(arr_len, arr, new_run, new_idx);
    } else {
        return sum_even(arr_len, arr, run, new_idx);
    }
}
