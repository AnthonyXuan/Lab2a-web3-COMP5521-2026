# COMP5521 Lab 2 — web3 image gas price fix

## Problem

The course image `crumblejon/smart-contract-web3:latest` (last updated 2023-10-06)
hardcodes `gasPrice: 1000000000` (1 gwei) in `deploy.js`, `increment.js` and
`reset.js`. Sepolia is an EIP-1559 chain whose block base fee now exceeds 1 gwei,
so every transaction is rejected by the EVM:

```
err: max fee per gas less than block base fee: maxFeePerGas: 1000000000, baseFee: ...
```

## Fix

Each script now queries the network's suggested gas price (with a 1.5x buffer)
before signing the transaction:

```js
const gas_price = Math.ceil(Number(await instance.eth.getGasPrice()) * 1.5)
// ...
gasPrice: gas_price,
```

Verified on Sepolia (2026-09-15): `deploy`, `increment` and `reset` all succeed.

## Build & publish (once, on the instructor's machine)

```sh
docker build -t <your-dockerhub-account>/comp5521-web3:lab2-2026 .
docker login
docker push <your-dockerhub-account>/comp5521-web3:lab2-2026
```

## Students

```sh
docker pull <your-dockerhub-account>/comp5521-web3:lab2-2026
docker run -itd --name web3 <your-dockerhub-account>/comp5521-web3:lab2-2026
docker exec web3 npm run secret    # set Infura PROJECT_ID + private key
docker exec web3 npm run deploy
```

Notes:

- The original image starts an interactive `node` REPL; use `-itd` to run it
  detached (without `-t` the container exits immediately).
- Docker Hub anonymous pull limit is ~100 pulls / 6 h / IP. If a class shares
  one campus IP, ask students to `docker login` with their own free account first.
- Sepolia is scheduled for sunset around the end of 2026 with a successor
  testnet launched alongside it — plan a network migration for future semesters.
