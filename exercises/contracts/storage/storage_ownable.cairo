// Task:
// Develop logic of set balance and get balance methods
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from openzeppelin.access.ownable.library import Ownable

// Define a storage variable.
@storage_var
func balance(account: felt) -> (res: felt) {
}

// Define a storage variable.
@constructor
func constructor{syscall_ptr: felt, pedersen_ptr: HashBuiltin, range_check_ptr}() {
    let _owner = get_caller_address();
    Ownable.initializer(_owner);
    return();
}

// Returns the current balance.
@view
func get_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt) -> (res: felt) {
    return balance.read(account);
}

// Sets the balance to amount
@external
func set_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(amount: felt) {
    let account = get_caller_address();
    balance.write(account, amount);

    return ();
}

@view
func get_owner{syscall_ptr: felt, pedersen_ptr: HashBuiltin, range_check_ptr,}() -> (_onwer: felt){
    return Ownable.owner();
}

@external
func transfer_Owner{syscall_ptr: felt, pedersen_ptr: HashBuiltin, range_check_ptr,}(_newOwner: felt) {
    Ownable.assert_only_owner();
    Ownable.transfer_ownership(_newOwner);
    return();
}
