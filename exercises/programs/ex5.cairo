from starkware.cairo.common.math import abs_value

// Implement a funcion that returns:
// - 1 when magnitudes of inputs are equal
// - 0 otherwise
func abs_eq{range_check_ptr}(x: felt, y: felt) -> (bit: felt) {
    let absX = abs_value(x);
    let absY = abs_value(y);

    if (absX == absY) {
        return (1,);
    } else {
        return (0,);
    }
}
