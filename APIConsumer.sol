// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {


uint256 public _endOdometer;

address private oracle;
bytes32 private jobId;
uint256 private fee;

/**
 * Network: Kovan
 * Oracle: 0xA54651f8d131CD42b225e0b3E5ECc36F5d763946
 * Job ID: "26f8ddbb8d5e4be88f4ee943379a7539"
 * Fee: 0.1 LINK
 */
constructor(address _oracle, string memory _jobId, uint256 _fee, address _link) public {
    if (_link == address(0)) {
        setPublicChainlinkToken();
    } else {
        setChainlinkToken(_link);
    }
    // oracle = 0xA54651f8d131CD42b225e0b3E5ECc36F5d763946;
    // jobId = "26f8ddbb8d5e4be88f4ee943379a7539";
    // fee = 1000000000000000000
    oracle = _oracle;
    jobId = stringToBytes32(_jobId);
    fee = _fee;
}

function requestVolumeData(string memory _vehicleId, string memory _encToken) public returns (bytes32 requestId) 
{
    Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
    request.add("vehicleId", _vehicleId);
    request.add("encToken", _encToken);

    
    // Sends the request
    return sendChainlinkRequestTo(oracle, request, fee);
}

/**
 * Receive the response in the form of uint256
 */ 
function fulfill(bytes32 _requestId, uint256 _distance) public recordChainlinkFulfillment(_requestId)
{
    _endOdometer = _distance;
}

function stringToBytes32(string memory source) public pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
        return 0x0;
    }

    assembly {
        result := mload(add(source, 32))
    }
}
}
