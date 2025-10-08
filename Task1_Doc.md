# Task 1: Feather Wallet & Local Monero Node Setup

## Achievements

- Feather GUI wallet installed and running.
- Local Monero daemon (`monerod`) running on `127.0.0.1:18081`.
- Created a new wallet: `47VoCZPtUgnNF4EeapDxxQNvZPDNDR4qBDpjEf92474PVk7BfH5Dkqv4zFXQ188F4FLtv5wCn8Yuq2dWEmqFbZp14DCFxYR`.
- Wallet successfully connected to the local node.
- Block explorer links configured:
  - https://xmrchain.net/tx/%txid%
  - https://moneroblocks.info/tx/%txid%
  - https://blockchair.com/monero/transaction/%txid%
  - http://blkchairbknpn73cfjhevhla7rkp4ed5gg2knctvv7it4lioy22defid.onion/monero/transaction/%txid%
  - http://127.0.0.1:31312/tx?id=%txid%

## Commands Used

### Run Monero daemon
```bash
cd ~/oxyra/build
./bin/monerod --data-dir ~/oxyra/data \
--p2p-bind-port 18080 \
--rpc-bind-port 18081
```

### Create new wallet
```bash
cd ~/oxyra/build
./bin/monero-wallet-cli --generate-new-wallet ~/oxyra/wallets/testwallet \
--daemon-address 127.0.0.1:18081
```
###  Feather Wallet
- GUI wallet connected to local node at 127.0.0.1:18081
- Wallet address visible in GUI: 47VoCZPtUgnNF4EeapDxxQNvZPDNDR4qBDpjEf92474PVk7BfH5Dkqv4zFXQ188F4FLtv5wCn8Yuq2dWEmqFbZp14DCFxYR