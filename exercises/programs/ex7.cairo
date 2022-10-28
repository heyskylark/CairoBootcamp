%lang starknet
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// - 0 otherwise

// 000000101010101 PASS
// 010101010101011 FAIL

func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {
    if (n == 0) {
        let inverse = 1 - (1 * broken_chain);
        return (inverse,);
    }

    if (broken_chain == 1) {
        let inverse = 1 - (1 * broken_chain);
        return (inverse,);
    }

    if (idx == 0) {
        let (q,r) = unsigned_div_rem(n, 2);
        let new_idx = idx + 1;

        return pattern(q, new_idx, r, 0);
    } else {
        let (q,r) = unsigned_div_rem(n, 2);
        let new_idx = idx + 1;
        let (x_xor_y) = bitwise_xor(r, exp);
        let chain_was_broken = 1 - (1 * x_xor_y);

        return pattern(q, new_idx, r, chain_was_broken);
    }
}
