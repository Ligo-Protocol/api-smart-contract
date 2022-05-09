# Deploy Oracle.sol and fulfill Node request

1. Open [Oracle.sol](https://remix.ethereum.org/#url=https://docs.chain.link/samples/NodeOperators/Oracle.sol) 

2. Compile, In Deploy and Run tab select "Injected Web3"

3. Select Oracle.sol contract in menu and in Deploy copy the Kovan address link:

```
0xa36085F69e2889c224210F603D836748e7dC0088
```
4. Deploy with the kovan link address and confirm the metamask transaction

5. Check Keys tab in Chainklink node and copy the Regular node address. (If chainlink node isn't running yet check [this](https://github.com/Ligo-Protocol/chainlink-node-docker-compose/blob/main/README.md) link.)

6. Paste it in `SetFullfillmentPermission` function with your node address and value as `true`.

7. Recheck your node address in `getAuthorizationStatus` function to see if it is true.

# How to use

1. Open [remix](https://remix.ethereum.org)

2. Compile [APIConsumer.sol](https://github.com/Ligo-Protocol/api-smart-contract/blob/main/APIConsumer.sol) in remix.

3. For deployment:

* Set the Oracle address you mentioned in your Job
* Set the Job ID by checking the 'externalJobID' in JobSpec. Remove the dashes in between and cover it with "". Example "29fa9aa13bf1468788b7cc4a500a45b8"
* Set fee 1000000000000000000
* Set Kovan address link:

```
0xa36085F69e2889c224210F603D836748e7dC0088
```
* Deploy

4. Send around 5 link tokens to the deployed APIConsumer contract. Get link from [faucet](https://faucets.chain.link/kovan)

5. Get your vehicleID and encryptedToken:

* Authorize using the [frontend](https://github.com/Ligo-Protocol/chainlink-hackathon-2022-client)
* Login to moralis and get your vehicleID
* Get your encrypted token using:
```
curl https://ligo-node-4etzx.ondigitalocean.app/api/v0/smartcar/vehicles/<your-vehicle-id-here>/token
```

6. Enter your vehicleID and encryptedToken as string in `requestVolumeData` function and run it

7. Click on `fulfill` function to get your required data.

