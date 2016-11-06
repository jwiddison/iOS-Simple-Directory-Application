//
//  AnalyticsHelper.swift
//  Founders Directory
//
//  Created by Steve Liddle on 11/5/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class AnalyticsHelper {

    // MARK: - Properties

    var device: String
    var manufacturer = "apple"
    var model: String
    var product = "ios"
    var release: String
    var sdk: String

    // MARK: - Singleton
    
    static let shared = AnalyticsHelper()

    fileprivate init() {
        if let vendorId = UIDevice.current.identifierForVendor {
            device = vendorId.uuidString
        } else {
            device = "simulator"
        }

        model = AnalyticsHelper.findModel()
        release = UIDevice.current.systemVersion
        sdk = release
    }

    // MARK: - Private helpers

    private static func findModel() -> String {
        // See http://bit.ly/2fPcfQz for ideas on this.

        // Default will be the generic model supplied by UIDevice (usually "iPhone")
        var machineString = UIDevice.current.model

        #if (arch(i386) || arch(x86_64)) && os(iOS)
            // This conditionally compiles code for execution only in the simulator
            if let model = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                return model
            }
        #else
            // This code will compile for execution when running on a device
            var systemInfo = utsname()

            uname(&systemInfo)  // This lets uname() change the systemInfo structure, to fill it in

            // To really understand this thoroughly, I'd need to teach you more Swift functional
            // programming and more about the Swift standard library.  You can read about Mirror
            // at http://apple.co/2eq01IT for example.
            let machineMirror = Mirror(reflecting: systemInfo.machine)

            machineString = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else {
                    return identifier
                }

                return identifier + String(UnicodeScalar(UInt8(value)))
            }
        #endif

        return machineString
    }
}
