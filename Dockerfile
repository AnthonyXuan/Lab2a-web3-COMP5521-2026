# COMP5521 Lab 2 fix: derived from the course image crumblejon/smart-contract-web3.
# Patches deploy/increment/reset scripts to fetch the gas price dynamically
# (Sepolia is an EIP-1559 chain and rejects gasPrice below the block base fee).
FROM crumblejon/smart-contract-web3:latest

COPY deploy.js increment.js reset.js /usr/src/app/src/script/
