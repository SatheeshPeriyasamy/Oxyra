#ifndef OXYRA_CONFIG_H
#define OXYRA_CONFIG_H

// Configuration header for Oxyra iOS integration
// This allows different configurations for dev vs prod targets

#ifdef DEBUG
    #define OXYRA_DEBUG 1
    #define OXYRA_LOG_LEVEL 2
    #define OXYRA_TESTNET 1
#else
    #define OXYRA_DEBUG 0
    #define OXYRA_LOG_LEVEL 0
    #define OXYRA_TESTNET 0
#endif

// Network configuration
#ifdef OXYRA_TESTNET
    #define OXYRA_NETWORK_TYPE "testnet"
#else
    #define OXYRA_NETWORK_TYPE "mainnet"
#endif

// Logging configuration
#define OXYRA_LOG_ENABLED OXYRA_DEBUG

#endif // OXYRA_CONFIG_H

