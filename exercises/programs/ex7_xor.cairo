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
    // n is the number
    // idx to identify the first remainder
    // exp?
    // broken_chain if 0 return 1, 1 return 0; that is why we need valid_chain

    // when n == 0, we reach the end. Return the result
    if (n == 0) {
        let valid_chain = 1 - broken_chain;
        %{ print(f"n== 0, n: {ids.n}, broken_chain: {ids.broken_chain}, valid_chain: {ids.valid_chain}") %}
        return (valid_chain,);
    }

    // if broken_chain 1, means the chain is broken, return
    if (broken_chain == 1) {
        let valid_chain = 1 - broken_chain;
        %{ print(f"broken_chain == 1, n: {ids.n}, broken_chain: {ids.broken_chain}, valid_chain: {ids.valid_chain}") %}

        return (valid_chain,);
    }

    // if idx = 0 chain is not broken
    if (idx == 0) {
        let (quotient, remainder) = unsigned_div_rem(n, 2);
        let new_idx = idx + 1;
        %{ print(f"idx == 0, n: {ids.n}, quotient: {ids.quotient}, remainder: {ids.remainder}") %}
        return pattern(quotient, new_idx, remainder, 0);
    }
    // convert decimal to binary using modulo
    let (quotient, remainder) = unsigned_div_rem(n, 2);

    let new_idx = idx + 1;
    // the remainder is the binary number 1 or 0
    // xor remainder with previous remainder
    // 0 xor 1 = 1
    // 0 xor 0 = 0
    // 1 xor 0 = 1 => broken_chain = 1 - 1 = 0 => ok
    // 1 xor 1 = 0 => broken_chain = 1 - 0 = 1 => broken
    let (remainder_xor_prev_remainder) = bitwise_xor(remainder, exp);
    let _broken_chain = check_broken_chain(remainder, exp);

    // let _broken_chain = 1 - remainder_xor_prev_remainder;
    %{ print(f"n: {ids.n}, quotient: {ids.quotient}, remainder: {ids.remainder}, remainder_xor_prev_remainder: {ids.remainder_xor_prev_remainder}, _broken_chain: {ids._broken_chain}") %}
    return pattern(quotient, new_idx, remainder, _broken_chain);
}
