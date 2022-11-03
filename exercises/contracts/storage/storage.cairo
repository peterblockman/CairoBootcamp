// Task:
// Develop logic of set balance and get balance methods
%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from openzeppelin.access.ownable.library import Ownable

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    Ownable.initializer(owner);
    return ();
}

// Define a storage variable.
@storage_var
func balance() -> (res: felt) {
}

// Returns the current balance.
@view
func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    let (_balance) = balance.read();
    return (_balance,);
}

// Sets the balance to amount
@external
func set_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(amount: felt) {
    Ownable.assert_only_owner();
    balance.write(amount);
    return ();
}
