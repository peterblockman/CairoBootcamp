from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin
from exercises.programs.ex1 import log_value

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    %{
        # Debug
        print(
            f'Begin idx: {ids.idx} run: {ids.run}, len: {ids.arr_len} '
        )
    %}
    if (arr_len == idx) {
        return (run,);
    }
    let val = arr[idx];
    let (xor) = bitwise_xor(val, 1);
    let nidx: felt = idx + 1;
    %{
        # Debug
        print(
            f'nidx: {ids.nidx}, val: {ids.val},  xor: {ids.xor}'
        )
    %}
    %{
        # Debug
        print(
            f'----------------------'
        )
    %}
    if (xor == val + 1) {
        let nrun = run + val;
        return sum_even(arr_len, arr, nrun, nidx);
    } else {
        return sum_even(arr_len, arr, run, nidx);
    }
}
