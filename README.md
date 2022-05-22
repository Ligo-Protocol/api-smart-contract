# QuickStart(Only Odometer)

1. Get the vehicleID from here:

```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/vehicles
```

2. Get the encToken from here:

```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/token
```

3. Open [remix](https://remix.ethereum.org)

4. Compile [APIConsumer.sol](https://github.com/Ligo-Protocol/api-smart-contract/blob/main/APIConsumer.sol)

5. In `fulfill` function, enter your vehicleID and encToken

6. In like 5-10 seconds, click on _endOdometer to check the values ..

# QuickStart(All)

1. Get the vehicleID from here:

```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/vehicles
```

2. Get the encToken from here:

```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/token
```

3. Open [remix](https://remix.ethereum.org)

4. Compile [APIConsumerAll.sol](https://github.com/Ligo-Protocol/api-smart-contract/blob/main/APIConsumerAll.sol)

5. In `fulfilldistanceAndlatitudeAndlongitude` function, enter your vehicleID and encToken

6. In like 5-10 seconds, click on _endLatitude, _endLongitude and _endOdometer to check the values ..

# How to use from the beginning

1. Open [remix](https://remix.ethereum.org)

2. Compile [APIConsumer.sol](https://github.com/Ligo-Protocol/api-smart-contract/blob/main/APIConsumer.sol) in remix.

3. For deployment:

* Set the Oracle address you mentioned in your Job
* Set the Job ID by checking the 'externalJobID' in JobSpec of your Job. Remove the dashes in between and cover it with "". Example "29fa9aa13bf1468788b7cc4a500a45b8"
* Set fee 0
* Set Kovan address link:

```
0xa36085F69e2889c224210F603D836748e7dC0088
```
* Deploy

4. Get your vehicleID and encryptedToken:

```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/vehicles
```
```
https://ligo-node.oort.codyhatfield.me/api/v0/smartcar/users/wXP24CpYWJGW5lqKCmPB8RTH/token
```

5. Enter your vehicleID and encryptedToken as string in `requestVolumeData` function and run it

7. Click on `fulfill` function to get your required data.

