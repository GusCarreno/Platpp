//
//  ConnectivityMonitor.swift
//  Platpp
//
//  Created by Gustavo on 26/7/23.
//

import Network

class ConnectivityMonitor {
    static let shared = ConnectivityMonitor()
    
    private var monitor: NWPathMonitor

    static var isOnline: Bool {
        let monitor = shared.monitor
        return monitor.currentPath.status == .satisfied
    }

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            print("Network status changed: \(path.status)")
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}

