from starkware.cairo.common.math import abs_value
from exercises.programs.ex1 import log_value

// Implement a funcion that returns:
// - 1 when magnitudes of inputs are equal
// - 0 otherwise
func abs_eq{range_check_ptr}(x: felt, y: felt) -> (bit: felt) {
    alloc_locals;
    local abs_x = abs_value(x);
    local abs_y = abs_value(y);
    let diff = abs_x - abs_y;
    // using let does not work here
    // becase let makes a ref
    tempvar r: felt;
    %{ ids.r = 1 if ids.diff == 0 else 0 %}
    return (r,);
}
