from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from exercises.programs.ex1 import log_value

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    alloc_locals;

    %{
        # Debug
        print(
            f'Begin idx: {ids.idx} run: {ids.run}, len: {ids.arr_len} '
        )
    %}
    if (arr_len == 0) {
        return (sum=0);
    }
    local val = arr[idx];
    let (local xor) = bitwise_xor(val, 1);

    local nidx: felt = idx + 1;

    %{
        # Debug
        print(
            f'nidx: {ids.nidx} xor: {ids.xor}, val: {ids.val} '
        )
    %}
    local nrun: felt;
    if (xor == val + 1) {
        nrun = run + val;
    }
    sum_even(arr_len - 1, arr + 1, nrun, nidx);
    return (nrun,);
}
