// Return summation of every number below and up to including n
func recursive_sum(n: felt, curr_sum: felt) -> (sum: felt) {
    if (n == 1) {
        return (sum = curr_sum + n);
    }

    let (sum) = recursive_sum(n - 1, curr_sum + n);
    return (sum = sum);
}

func calculate_sum(n: felt) -> (sum: felt) {
    let (sum) = recursive_sum(n, 0);
    return (sum = sum);
}
