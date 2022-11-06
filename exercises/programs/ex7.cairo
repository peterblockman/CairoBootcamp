%lang starknet
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem
from exercises.programs.ex1 import log_value

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// alternating bits of 1 and 0
// - 0 otherwise

// 000000101010101 PASS
// 010101010101011 FAIL

func check_broken_chain{range_check_ptr}(remainder: felt, exp: felt) -> felt {
    if (remainder == exp) {
        return 1;
    }
    return 0;
}
func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {
    if (n == 0) {
        let valid_chain = 1 - broken_chain;
        return (valid_chain,);
    }

    if (broken_chain == 1) {
        let valid_chain = 1 - broken_chain;

        return (valid_chain,);
    }

    if (idx == 0) {
        let (quotient, remainder) = unsigned_div_rem(n, 2);
        let new_idx = idx + 1;
        return pattern(quotient, new_idx, remainder, 0);
    }

    let (quotient, remainder) = unsigned_div_rem(n, 2);
    let new_idx = idx + 1;
    let _broken_chain = check_broken_chain(remainder, exp);

    return pattern(quotient, new_idx, remainder, _broken_chain);
}
