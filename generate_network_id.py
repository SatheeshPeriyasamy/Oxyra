#!/usr/bin/env python3
import uuid
import secrets

def generate_network_id():
    """Generate a unique Network ID for blockchain"""
    
    # Method 1: Using UUID4 (random)
    print("=== Method 1: UUID4 (Recommended) ===")
    u = uuid.uuid4()
    bytes_array = list(u.bytes)
    
    # Format for C++ (split into 2 lines of 8 bytes each)
    line1 = ", ".join(f"0x{b:02X}" for b in bytes_array[:8])
    line2 = ", ".join(f"0x{b:02X}" for b in bytes_array[8:])
    
    print(f"boost::uuids::uuid const NETWORK_ID = {{ {{")
    print(f"    {line1},")
    print(f"    {line2}")
    print(f"}} }};")
    print()
    
    # Method 2: Using secrets (cryptographically strong)
    print("=== Method 2: Cryptographically Strong Random ===")
    random_bytes = [secrets.randbits(8) for _ in range(16)]
    line1 = ", ".join(f"0x{b:02X}" for b in random_bytes[:8])
    line2 = ", ".join(f"0x{b:02X}" for b in random_bytes[8:])
    
    print(f"boost::uuids::uuid const NETWORK_ID = {{ {{")
    print(f"    {line1},")
    print(f"    {line2}")
    print(f"}} }};")
    print()
    
    # Method 3: Custom branded (optional - includes your project name)
    print("=== Method 3: Custom Branded (Optional) ===")
    # Create a UUID5 based on your project name
    namespace = uuid.NAMESPACE_DNS
    branded_uuid = uuid.uuid5(namespace, "oxyrax.blockchain")
    bytes_array = list(branded_uuid.bytes)
    
    line1 = ", ".join(f"0x{b:02X}" for b in bytes_array[:8])
    line2 = ", ".join(f"0x{b:02X}" for b in bytes_array[8:])
    
    print(f"boost::uuids::uuid const NETWORK_ID = {{ {{")
    print(f"    {line1},")
    print(f"    {line2}")
    print(f"}} }};")
    print()
    print("Note: Branded IDs are deterministic (same input = same output)")
    print("Use Method 1 or 2 for production to ensure uniqueness")

if __name__ == "__main__":
    generate_network_id()