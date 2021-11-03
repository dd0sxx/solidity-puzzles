/// turn this tweet into a toy problem:

/// https://twitter.com/BenDiFrancesco/status/1455944019662589960
/// Ok #solidity friends, if another function is called inside an unchecked block, does that turn off overflow checks inside other functions scope?

/// answer : 
/// "The setting only affects the statements that are syntactically inside the block. Functions called from within an unchecked block do not inherit the property."
/// https://docs.soliditylang.org/en/v0.8.0/control-structures.html#checked-or-unchecked-arithmetic
