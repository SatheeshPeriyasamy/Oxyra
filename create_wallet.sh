#!/bin/bash

cd /Users/soloking/monero/build/Darwin/master/release/bin

# Create a new wallet with English language
{
    echo "1"  # English language
    echo "test123"  # Password
    echo "test123"  # Confirm password
    echo "balance"
    echo "address"
    echo "exit"
} | ./monero-wallet-cli --use-english-language-names --daemon-address 127.0.0.1:18081 --generate-new-wallet test_wallet_new
