// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract MultiVariableRequest is ChainlinkClient, ConfirmedOwner {
  using Chainlink for Chainlink.Request;

  uint256 constant private ORACLE_PAYMENT = 0 * LINK_DIVISIBILITY / 100 * 5;
  uint256 public longitude;
  uint256 public latitude;
  uint256 public distance;

  constructor() ConfirmedOwner(msg.sender){
    setChainlinkToken(0xa36085F69e2889c224210F603D836748e7dC0088);
    setChainlinkOracle(0x89dca850F3C3BF8fB0209190CD45e4a59632C73D);
  }

  function requestdistanceAndlatitude(string memory _vehicleId, string memory _encToken)
    public
    onlyOwner
  {
    bytes32 _jobId = "8355f4ed038940b5a7084ee2dfccf20d";
    Chainlink.Request memory req = buildChainlinkRequest(_jobId, address(this), this.fulfilldistanceAndlatitudeAndlongitude.selector);
    req.add("vehicleId", _vehicleId);
    req.add("encToken", _encToken);
    sendOperatorRequest(req, ORACLE_PAYMENT);
  }

  event RequestFulfilleddistanceAndlatitude(
    bytes32 indexed requestId,
    uint256 indexed longitude,    
    uint256 indexed latitude,
    uint256 distance
  );

  function fulfilldistanceAndlatitudeAndlongitude(
    bytes32 requestId,
    uint256 _longitude,    
    uint256 _latitude,
    uint256 _distance
  )
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilleddistanceAndlatitude(requestId, _longitude, _latitude, _distance);
    distance = _distance;
    latitude = _latitude;
    longitude = _longitude;    
  }

  function stringToBytes32(string memory source) private pure returns (bytes32 result) {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
      return 0x0;
    }

    assembly { // solhint-disable-line no-inline-assembly
      result := mload(add(source, 32))
    }
  }

}