import Foundation
import Oxyra
import OxyraCore

/// Unstoppable-branded Oxyra wrapper
/// This re-exports Oxyra functionality with Unstoppable branding
@objc public class Unstoppable: NSObject {
    
    /// Initialize Unstoppable Oxyra with configuration
    /// - Parameter config: Configuration object for Oxyra
    public init(config: OxyraConfig) {
        super.init()
    }
    
    /// Get the underlying Oxyra instance
    private var oxyra: Oxyra?
    
    /// Start the Oxyra daemon
    /// - Parameter options: Daemon options
    /// - Returns: True if started successfully
    @objc public func startDaemon(options: OxyraDaemonOptions) -> Bool {
        if oxyra == nil {
            oxyra = Oxyra(config: OxyraConfig(dataDir: options.rpcBindIP, logLevel: 0, testnet: false))
        }
        return oxyra?.startDaemon(options: options) ?? false
    }
    
    /// Stop the Oxyra daemon
    @objc public func stopDaemon() {
        oxyra?.stopDaemon()
    }
    
    /// Check if daemon is running
    /// - Returns: True if daemon is running
    @objc public func isDaemonRunning() -> Bool {
        return oxyra?.isDaemonRunning() ?? false
    }
    
    /// Get daemon status
    /// - Returns: Current daemon status
    @objc public func getDaemonStatus() -> OxyraDaemonStatus {
        return oxyra?.getDaemonStatus() ?? OxyraDaemonStatus(isRunning: false, isSynchronized: false, height: 0, targetHeight: 0)
    }
}

// Re-export Oxyra types for Unstoppable usage
public typealias UnstoppableConfig = OxyraConfig
public typealias UnstoppableDaemonOptions = OxyraDaemonOptions
public typealias UnstoppableDaemonStatus = OxyraDaemonStatus
