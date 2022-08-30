// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {
    uint256 public _endOdometer;
    uint256 public OdometerDecimal;

    address private link;
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    /**
     * Network: Kovan
     * Kovan link address = 0xa36085F69e2889c224210F603D836748e7dC0088
     */
    constructor() public {
        link = 0xa36085F69e2889c224210F603D836748e7dC0088;
        if (link == address(0)) {
            setPublicChainlinkToken();
        } else {
            setChainlinkToken(link);
        }
        // oracle = 0x7caBbcCAa965F3466387C001c3154BD69cA26AF5;
        // jobId = "b2779045343f4d21879c33d1d95dca36";
        // fee = 0
        oracle = 0x7caBbcCAa965F3466387C001c3154BD69cA26AF5;
        jobId = stringToBytes32("b2779045343f4d21879c33d1d95dca36");
        fee = 0;
    }

    function requestVolumeData(
        string memory _vehicleId,
        string memory _encToken
    ) public returns (bytes32 requestId) {
        Chainlink.Request memory request = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );
        request.add("vehicleId", _vehicleId);
        request.add("encToken", _encToken);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    /**
     * Receive the response in the form of uint256
     */
    function fulfill(bytes32 _requestId, uint256 _distance)
        public
        recordChainlinkFulfillment(_requestId)
    {
        _endOdometer = _distance / 1000;
        OdometerDecimal = _distance % 1000;
    }

    function stringToBytes32(string memory source)
        public
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
}
