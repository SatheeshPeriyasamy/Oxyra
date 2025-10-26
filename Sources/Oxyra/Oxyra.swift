import Foundation
import OxyraCore

/// Swift wrapper for Oxyra functionality
/// This provides a clean Swift interface to the C++ Oxyra bridge
public class Oxyra {
    
    /// Shared instance for easy access
    public static let shared = Oxyra()
    
    private var isInitialized = false
    
    private init() {
        // Private initializer for singleton
    }
    
    /// Initialize Oxyra
    /// Call this before using any other Oxyra functions
    public func initialize() {
        guard !isInitialized else { return }
        
        oxyra_initialize()
        isInitialized = true
    }
    
    /// Cleanup Oxyra resources
    public func cleanup() {
        guard isInitialized else { return }
        
        oxyra_cleanup()
        isInitialized = false
    }
    
    /// Start the Oxyra daemon
    /// - Parameter options: Configuration options for the daemon
    /// - Returns: True if daemon started successfully
    public func startDaemon(options: DaemonOptions) -> Bool {
        guard isInitialized else { return false }
        
        var cOptions = oxyra_daemon_options_t()
        cOptions.rpc_bind_ip = strdup(options.rpcBindIP)
        cOptions.rpc_bind_port = options.rpcBindPort
        cOptions.p2p_bind_ip = strdup(options.p2pBindIP)
        cOptions.p2p_bind_port = options.p2pBindPort
        cOptions.restricted_rpc = options.restrictedRPC
        
        let result = oxyra_start_daemon(cOptions)
        
        // Clean up allocated strings
        free(cOptions.rpc_bind_ip)
        free(cOptions.p2p_bind_ip)
        
        return result
    }
    
    /// Stop the Oxyra daemon
    public func stopDaemon() {
        oxyra_stop_daemon()
    }
    
    /// Check if daemon is running
    /// - Returns: True if daemon is running
    public func isDaemonRunning() -> Bool {
        return oxyra_is_daemon_running()
    }
    
    /// Get daemon status
    /// - Returns: Current daemon status
    public func getDaemonStatus() -> DaemonStatus {
        let cStatus = oxyra_get_daemon_status()
        return DaemonStatus(
            isRunning: cStatus.is_running,
            isSynchronized: cStatus.is_synchronized,
            height: cStatus.height,
            targetHeight: cStatus.target_height
        )
    }
    
    /// Validate an Oxyra address
    /// - Parameters:
    ///   - address: Address to validate
    ///   - testnet: Whether this is a testnet address
    /// - Returns: True if address is valid
    public func validateAddress(_ address: String, testnet: Bool = false) -> Bool {
        return oxyra_address_valid(address, testnet)
    }
    
    /// Convert amount to string representation
    /// - Parameter amount: Amount in atomic units
    /// - Returns: Formatted amount string
    public func amountToString(_ amount: UInt64) -> String? {
        guard let cString = oxyra_amount_to_string(amount) else { return nil }
        let result = String(cString: cString)
        return result
    }
    
    /// Convert string to amount
    /// - Parameter amountString: String representation of amount
    /// - Returns: Amount in atomic units
    public func stringToAmount(_ amountString: String) -> UInt64 {
        return oxyra_string_to_amount(amountString)
    }
}

/// Configuration options for the Oxyra daemon
public struct DaemonOptions {
    public let rpcBindIP: String
    public let rpcBindPort: UInt16
    public let p2pBindIP: String
    public let p2pBindPort: UInt16
    public let restrictedRPC: Bool
    
    public init(
        rpcBindIP: String = "127.0.0.1",
        rpcBindPort: UInt16 = 18081,
        p2pBindIP: String = "0.0.0.0",
        p2pBindPort: UInt16 = 18080,
        restrictedRPC: Bool = false
    ) {
        self.rpcBindIP = rpcBindIP
        self.rpcBindPort = rpcBindPort
        self.p2pBindIP = p2pBindIP
        self.p2pBindPort = p2pBindPort
        self.restrictedRPC = restrictedRPC
    }
}

/// Status information about the Oxyra daemon
public struct DaemonStatus {
    public let isRunning: Bool
    public let isSynchronized: Bool
    public let height: UInt64
    public let targetHeight: UInt64
}