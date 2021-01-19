pragma solidity >=0.5.0;

contract PrecompiledContractsUtil {
    event PrecompiledSuccess(address);
    event PrecompiledFailure(address);

    function callPrec(address precAddress, bytes32 input, uint256 inputLen, uint256 outLen) public returns (bool) {
        uint256 retval;

        inputLen = 32;
        outLen = 0x40;

        assembly {
            // allocate output byte array
            let res := mload(0x40)

            // call precompile (STATICCALL returns success or failure)
            retval := staticcall(gas(), precAddress, input, inputLen, res, outLen)
        }

        if(retval == 1) {
            emit PrecompiledSuccess(precAddress);

            return true;
        }

        if(retval == 0) {
            emit PrecompiledFailure(precAddress);

            return false;   
        }
    }
}