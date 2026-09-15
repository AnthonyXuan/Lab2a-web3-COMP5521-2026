# COMP5521 Lab 2 — Web3.js Smart Contract Lab

This project contains the web3.js scripts for compiling, deploying and
interacting with an `Incrementer` smart contract on the **Sepolia** test
network:

| Script | Purpose |
|---|---|
| `deploy.js` | Deploy the `Incrementer` contract and return its address |
| `increment.js` | Increase the counter by a given value |
| `get_counter.js` | Read the current counter (no transaction needed) |
| `reset.js` | Reset the counter to a given value |

The easiest way to use it is via the published Docker image (the image
already contains everything, including the Solidity source and compiler):

```sh
docker run -itd --name web3 anthony2xuan/comp5521-web3:lab2-2026
```

## Getting started

1. **Prepare two things first:**
   - an Infura **API key** (sign up at https://infura.io and create a Sepolia endpoint);
   - your MetaMask **private key** (never share it with anyone).

2. **Configure your credentials inside the container:**

   ```sh
   docker exec web3 npm run secret <your_api_key> <your_private_key>
   ```

3. **Deploy the contract to Sepolia:**

   ```sh
   docker exec web3 npm run deploy
   ```

   The command prints the contract address and a link to view it on
   Sepolia Etherscan.

4. **Interact with the contract:**

   ```sh
   docker exec web3 npm run increment <address> <value>
   docker exec web3 npm run counter <address>
   docker exec web3 npm run reset <address> <value>
   ```

## Build the image yourself (optional)

```sh
docker build -t comp5521-web3 .
```

The Dockerfile derives from `crumblejon/smart-contract-web3` and adds the
three scripts in this repository.
