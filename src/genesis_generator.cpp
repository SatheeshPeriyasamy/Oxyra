#include "cryptonote_core/cryptonote_tx_utils.h"
#include "cryptonote_basic/cryptonote_basic.h"
#include "cryptonote_basic/account.h"
#include "cryptonote_config.h"
#include "common/util.h"
#include "string_tools.h"
#include <iostream>

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <wallet_address>" << std::endl;
        return 1;
    }
    
    std::string wallet_address = argv[1];
    
    // Parse the wallet address
    cryptonote::address_parse_info info;
    bool r = cryptonote::get_account_address_from_str(info, cryptonote::MAINNET, wallet_address);
    if (!r) {
        std::cerr << "Failed to parse wallet address: " << wallet_address << std::endl;
        return 1;
    }
    
    // Create genesis transaction
    cryptonote::transaction genesis_tx;
    cryptonote::blobdata extra_nonce;
    
    // Use construct_miner_tx with genesis parameters
    r = cryptonote::construct_miner_tx(0, 0, 0, 0, 0, info.address, genesis_tx, extra_nonce, 1, 1);
    if (!r) {
        std::cerr << "Failed to construct genesis transaction" << std::endl;
        return 1;
    }
    
    // Serialize the transaction to hex
    std::string tx_hex = epee::string_tools::buff_to_hex_nodelimer(cryptonote::tx_to_blob(genesis_tx));
    std::cout << "GENESIS_TX: " << tx_hex << std::endl;
    
    return 0;
}