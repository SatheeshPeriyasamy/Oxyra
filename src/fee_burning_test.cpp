#include "cryptonote_core/cryptonote_tx_utils.h"
#include "cryptonote_basic/cryptonote_basic.h"
#include "cryptonote_basic/account.h"
#include "cryptonote_config.h"
#include "common/util.h"
#include "string_tools.h"
#include <iostream>

int main() {
    std::cout << "=== Oxyra X Fee Burning Test ===" << std::endl;
    
    // Test 1: Verify block reward logic
    std::cout << "\n1. Testing Block Reward Logic:" << std::endl;
    
    uint64_t reward;
    bool result;
    
    // Test genesis block (should get full supply)
    result = cryptonote::get_block_reward(0, 0, 0, reward, 1);
    std::cout << "   Genesis block (height 0): reward = " << reward << " (expected: " << MONEY_SUPPLY << ")" << std::endl;
    
    // Test block 1 (should get 0 reward)
    result = cryptonote::get_block_reward(0, 0, MONEY_SUPPLY, reward, 1);
    std::cout << "   Block 1 (after genesis): reward = " << reward << " (expected: 0)" << std::endl;
    
    // Test 2: Verify fee burning in miner transaction
    std::cout << "\n2. Testing Fee Burning in Miner Transaction:" << std::endl;
    
    // Create a test miner address
    cryptonote::account_base miner_account;
    miner_account.generate();
    cryptonote::account_public_address miner_address = miner_account.get_keys().m_account_address;
    
    // Test with fees
    uint64_t test_fee = 1000000000; // 1 OXRX in atomic units
    cryptonote::transaction miner_tx;
    cryptonote::blobdata extra_nonce;
    
    // Construct miner transaction with fees (should burn them)
    result = cryptonote::construct_miner_tx(1, 0, MONEY_SUPPLY, 0, test_fee, miner_address, miner_tx, extra_nonce, 1, 1);
    
    if (result) {
        std::cout << "   Miner transaction constructed successfully" << std::endl;
        std::cout << "   Input fee: " << test_fee << " atomic units" << std::endl;
        
        // Check if miner transaction has any outputs (it shouldn't for non-genesis blocks)
        if (miner_tx.vout.empty()) {
            std::cout << "   ✅ SUCCESS: Miner transaction has no outputs - fees are burned!" << std::endl;
        } else {
            uint64_t total_output = 0;
            for (const auto& out : miner_tx.vout) {
                total_output += out.amount;
            }
            std::cout << "   ❌ FAILED: Miner transaction has outputs totaling " << total_output << " atomic units" << std::endl;
        }
    } else {
        std::cout << "   ❌ FAILED: Could not construct miner transaction" << std::endl;
    }
    
    // Test 3: Verify genesis block gets full supply
    std::cout << "\n3. Testing Genesis Block (Full Supply):" << std::endl;
    
    cryptonote::transaction genesis_tx;
    result = cryptonote::construct_miner_tx(0, 0, 0, 0, 0, miner_address, genesis_tx, extra_nonce, 1, 1);
    
    if (result) {
        uint64_t total_genesis_output = 0;
        for (const auto& out : genesis_tx.vout) {
            total_genesis_output += out.amount;
        }
        std::cout << "   Genesis block total output: " << total_genesis_output << " atomic units" << std::endl;
        std::cout << "   Expected total supply: " << MONEY_SUPPLY << " atomic units" << std::endl;
        
        if (total_genesis_output == MONEY_SUPPLY) {
            std::cout << "   ✅ SUCCESS: Genesis block contains full supply!" << std::endl;
        } else {
            std::cout << "   ❌ FAILED: Genesis block output doesn't match expected supply" << std::endl;
        }
    }
    
    std::cout << "\n=== Test Complete ===" << std::endl;
    return 0;
}
