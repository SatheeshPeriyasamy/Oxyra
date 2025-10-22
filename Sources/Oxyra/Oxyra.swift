import Foundation
import OxyraCore

/// Main Oxyra Swift wrapper for iOS
@objc public class Oxyra: NSObject {
    
    /// Initialize Oxyra with configuration
    /// - Parameter config: Configuration object for Oxyra
    public init(config: OxyraConfig) {
        super.init()
        // Initialize the core C++ library
        oxyra_initialize()
    }
    
    deinit {
        oxyra_cleanup()
    }
    
    /// Start the Oxyra daemon
    /// - Parameter options: Daemon options
    /// - Returns: True if started successfully
    @objc public func startDaemon(options: OxyraDaemonOptions) -> Bool {
        return oxyra_start_daemon(options.toCOptions())
    }
    
    /// Stop the Oxyra daemon
    @objc public func stopDaemon() {
        oxyra_stop_daemon()
    }
    
    /// Check if daemon is running
    /// - Returns: True if daemon is running
    @objc public func isDaemonRunning() -> Bool {
        return oxyra_is_daemon_running()
    }
    
    /// Get daemon status
    /// - Returns: Current daemon status
    @objc public func getDaemonStatus() -> OxyraDaemonStatus {
        let status = oxyra_get_daemon_status()
        return OxyraDaemonStatus.fromCStatus(status)
    }
}

/// Configuration for Oxyra
@objc public class OxyraConfig: NSObject {
    @objc public var dataDir: String
    @objc public var logLevel: Int
    @objc public var testnet: Bool
    
    @objc public init(dataDir: String, logLevel: Int = 0, testnet: Bool = false) {
        self.dataDir = dataDir
        self.logLevel = logLevel
        self.testnet = testnet
        super.init()
    }
}

/// Daemon options for Oxyra
@objc public class OxyraDaemonOptions: NSObject {
    @objc public var rpcBindIP: String
    @objc public var rpcBindPort: UInt16
    @objc public var p2pBindIP: String
    @objc public var p2pBindPort: UInt16
    @objc public var restrictedRPC: Bool
    
    @objc public init(rpcBindIP: String = "127.0.0.1", 
                     rpcBindPort: UInt16 = 18081,
                     p2pBindIP: String = "0.0.0.0",
                     p2pBindPort: UInt16 = 18080,
                     restrictedRPC: Bool = true) {
        self.rpcBindIP = rpcBindIP
        self.rpcBindPort = rpcBindPort
        self.p2pBindIP = p2pBindIP
        self.p2pBindPort = p2pBindPort
        self.restrictedRPC = restrictedRPC
        super.init()
    }
    
    func toCOptions() -> oxyra_daemon_options_t {
        var options = oxyra_daemon_options_t()
        options.rpc_bind_ip = strdup(rpcBindIP)
        options.rpc_bind_port = rpcBindPort
        options.p2p_bind_ip = strdup(p2pBindIP)
        options.p2p_bind_port = p2pBindPort
        options.restricted_rpc = restrictedRPC
        return options
    }
}

/// Daemon status information
@objc public class OxyraDaemonStatus: NSObject {
    @objc public var isRunning: Bool
    @objc public var isSynchronized: Bool
    @objc public var height: UInt64
    @objc public var targetHeight: UInt64
    
    @objc public init(isRunning: Bool, isSynchronized: Bool, height: UInt64, targetHeight: UInt64) {
        self.isRunning = isRunning
        self.isSynchronized = isSynchronized
        self.height = height
        self.targetHeight = targetHeight
        super.init()
    }
    
    static func fromCStatus(_ status: oxyra_daemon_status_t) -> OxyraDaemonStatus {
        return OxyraDaemonStatus(
            isRunning: status.is_running,
            isSynchronized: status.is_synchronized,
            height: status.height,
            targetHeight: status.target_height
        )
    }
}
