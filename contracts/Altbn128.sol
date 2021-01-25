// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

contract Altbn128 {
    event ResultOk();
    event Debug(bytes32);

    function callBn256Add(bytes32 ax, bytes32 ay, bytes32 bx, bytes32 by) public returns (bytes32[2] memory result) {
        bytes32[4] memory input;
        input[0] = ax;
        input[1] = ay;
        input[2] = bx;
        input[3] = by;
        assembly {
            let success := call(gas(), 0x06, 0, input, 0x80, result, 0x40)
            switch success
            case 0 {
                revert(0,0)
            }
        }
    }

    function callBn256ScalarMul(bytes32 x, bytes32 y, bytes32 scalar) public returns (bytes32[2] memory result) {
        bytes32[3] memory input;
        input[0] = x;
        input[1] = y;
        input[2] = scalar;
        assembly {
            let success := call(gas(), 0x07, 0, input, 0x60, result, 0x40)
            switch success
            case 0 {
                revert(0,0)
            }
        }
    }

    function callBn256Pairing(bytes memory input) public returns (bytes32 result) {
        // input is a serialized bytes stream of (a1, b1, a2, b2, ..., ak, bk) from (G_1 x G_2)^k
        uint256 len = input.length;
        require(len % 192 == 0);
        assembly {
            let memPtr := mload(0x40)
            let success := call(gas(), 0x08, 0, add(input, 0x20), len, memPtr, 0x20)
            switch success
            case 0 {
                revert(0,0)
            } default {
                result := mload(memPtr)
            }
        }
    }

    function matchExpected(bytes32[2] memory result, bytes32 expectedResult1, bytes32 expectedResult2) internal pure {
        require(result[0] == expectedResult1, "altbn128: result1 didn't match expected value");
        require(result[1] == expectedResult2, "altbn128: result2 didn't match expected value");
    }

    function runAddTest() public {
        bytes32[2] memory addResult = callBn256Add(hex"0000000000000000000000000000000000000000000000000000000000000001", 
        hex"0000000000000000000000000000000000000000000000000000000000000002", 
        hex"0000000000000000000000000000000000000000000000000000000000000001",
        hex"0000000000000000000000000000000000000000000000000000000000000002");

        bytes32 expectedAddResult1 = hex"030644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd3";
        bytes32 expectedAddResult2 = hex"15ed738c0e0a7c92e7845f96b2ae9c0a68a6a449e3538fc7ff3ebf7a5a18a2c4";

        require(addResult[0] == expectedAddResult1, "altbn128: result1 didn't match expected value");
        require(addResult[1] == expectedAddResult2, "altbn128: result2 didn't match expected value");

        emit ResultOk();
    }

    function runScalarMulTest() public {
        bytes32[2] memory scalarMulResult = callBn256ScalarMul(hex"0000000000000000000000000000000000000000000000000000000000000001", 
        hex"0000000000000000000000000000000000000000000000000000000000000002", 
        hex"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");

        bytes32 expectedScalarMulResult1 = hex"2f588cffe99db877a4434b598ab28f81e0522910ea52b45f0adaa772b2d5d352";
        bytes32 expectedScalarMulResult2 = hex"12f42fa8fd34fb1b33d8c6a718b6590198389b26fc9d8808d971f8b009777a97";

        require(scalarMulResult[0] == expectedScalarMulResult1, "altbn128: scalarMulResult1 didn't match expected value");
        require(scalarMulResult[1] == expectedScalarMulResult2, "altbn128: scalarMulResult2 didn't match expected value");

        emit ResultOk();
    }

    function runPairingTest() public {
        bytes32 pairingResult = callBn256Pairing(hex"00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c21800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa000000000000000000000000000000000000000000000000000000000000000130644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd45198e9393920d483a7260bfb731fb5d25f1aa493335a9e71297e485b7aef312c21800deef121f1e76426a00665e5c4479674322d4f75edadd46debd5cd992f6ed090689d0585ff075ec9e99ad690c3395bc4b313370b38ef355acdadcd122975b12c85ea5db8c6deb4aab71808dcb408fe3d1e7690c43d37b4ce6cc0166fa7daa");
        bytes32 expectedPairingResult = hex"0000000000000000000000000000000000000000000000000000000000000001";

        emit Debug(pairingResult);

        require(pairingResult == expectedPairingResult, "altbn128: pairing result didn't match expected");

        emit ResultOk();
    }
}