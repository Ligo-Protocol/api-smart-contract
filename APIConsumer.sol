// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {


uint256 public distance;

address private oracle;
bytes32 private jobId;
uint256 private fee;

/**
 * Network: Kovan
 * Oracle: 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e
 * Job ID: 29fa9aa13bf1468788b7cc4a500a45b8
 * Fee: 0.1 LINK
 */
constructor(address _oracle, string memory _jobId, uint256 _fee, address _link) public {
    if (_link == address(0)) {
        setPublicChainlinkToken();
    } else {
        setChainlinkToken(_link);
    }
    // oracle = 0x2f90A6D021db21e1B2A077c5a37B3C7E75D15b7e;
    // jobId = "29fa9aa13bf1468788b7cc4a500a45b8";
    // fee = 0.1 * 10 ** 18; // 0.1 LINK
    oracle = _oracle;
    jobId = stringToBytes32(_jobId);
    fee = _fee;
}

/**
 * Create a Chainlink request to retrieve API response, find the target
 * data, then multiply by 1000000000000000000 (to remove decimal places from data).
 */
function requestVolumeData(string memory _vehicleId, string memory _encToken) public returns (bytes32 requestId) 
{
    Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);
    
    // Set the path to find the desired data in the API response, where the response format is:
    // {"RAW":
    //   {"ETH":
    //    {"USD":
    //     {
    //      "VOLUME24HOUR": xxx.xxx,
    //     }
    //    }
    //   }
    //  }
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
    distance = _distance;
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
