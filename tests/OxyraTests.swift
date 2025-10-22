import XCTest
@testable import Oxyra

final class OxyraTests: XCTestCase {
    
    func testOxyraInitialization() {
        let config = OxyraConfig(
            dataDir: "/tmp/oxyra_test",
            logLevel: 0,
            testnet: true
        )
        
        let oxyra = Oxyra(config: config)
        XCTAssertNotNil(oxyra)
    }
    
    func testDaemonOptions() {
        let options = OxyraDaemonOptions(
            rpcBindIP: "127.0.0.1",
            rpcBindPort: 18081,
            p2pBindIP: "0.0.0.0",
            p2pBindPort: 18080,
            restrictedRPC: true
        )
        
        XCTAssertEqual(options.rpcBindIP, "127.0.0.1")
        XCTAssertEqual(options.rpcBindPort, 18081)
        XCTAssertEqual(options.p2pBindIP, "0.0.0.0")
        XCTAssertEqual(options.p2pBindPort, 18080)
        XCTAssertTrue(options.restrictedRPC)
    }
    
    func testDaemonStatus() {
        let status = OxyraDaemonStatus(
            isRunning: false,
            isSynchronized: false,
            height: 0,
            targetHeight: 0
        )
        
        XCTAssertFalse(status.isRunning)
        XCTAssertFalse(status.isSynchronized)
        XCTAssertEqual(status.height, 0)
        XCTAssertEqual(status.targetHeight, 0)
    }
}
