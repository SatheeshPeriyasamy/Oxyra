#ifndef OXYRA_BRIDGE_H
#define OXYRA_BRIDGE_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>

// Daemon options structure
typedef struct {
    char* rpc_bind_ip;
    uint16_t rpc_bind_port;
    char* p2p_bind_ip;
    uint16_t p2p_bind_port;
    bool restricted_rpc;
} oxyra_daemon_options_t;

// Daemon status structure
typedef struct {
    bool is_running;
    bool is_synchronized;
    uint64_t height;
    uint64_t target_height;
} oxyra_daemon_status_t;

// Core functions
void oxyra_initialize(void);
void oxyra_cleanup(void);

bool oxyra_start_daemon(oxyra_daemon_options_t options);
void oxyra_stop_daemon(void);
bool oxyra_is_daemon_running(void);
oxyra_daemon_status_t oxyra_get_daemon_status(void);

// Wallet functions
void* oxyra_wallet_create(const char* path, const char* password);
void oxyra_wallet_destroy(void* wallet);
bool oxyra_wallet_generate(const char* path, const char* password);
bool oxyra_wallet_restore(const char* path, const char* password, const char* seed);

// Crypto functions
bool oxyra_address_valid(const char* address, bool testnet);
char* oxyra_generate_address(const char* seed, bool testnet);
bool oxyra_key_valid(const char* secret_key, const char* public_key, bool testnet);

// Utility functions
char* oxyra_amount_to_string(uint64_t amount);
uint64_t oxyra_string_to_amount(const char* amount_str);
char* oxyra_bytes_to_words(const char* bytes, size_t length);

#ifdef __cplusplus
}
#endif

#endif // OXYRA_BRIDGE_H


