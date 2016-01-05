//
//  Copyright © 2015 Tomas Linhart. All rights reserved.
//

import CGtk

enum ConnectFlags {
    case After
    case Swapped
    
    private func toGConnectFlags() -> GConnectFlags {
        switch self {
        case .After:
            return G_CONNECT_AFTER
        case .Swapped:
            return G_CONNECT_SWAPPED
        }
    }
}

func connectSignal<T>(instance: UnsafeMutablePointer<T>, name: String, data: UnsafePointer<Void>, connectFlags: ConnectFlags = .After, handler: @convention(c) (UnsafeMutablePointer<Void>, UnsafeMutablePointer<Void>) -> Void) -> UInt {
    return g_signal_connect_data(instance, name, unsafeBitCast(handler, GCallback.self), UnsafeMutablePointer(data), nil, connectFlags.toGConnectFlags())
}

func connectSignal<T>(instance: UnsafeMutablePointer<T>, name: String, connectFlags: ConnectFlags = .After, handler: @convention(c) (UnsafeMutablePointer<Void>, UnsafeMutablePointer<Void>) -> Void) -> UInt {
    return g_signal_connect_data(instance, name, unsafeBitCast(handler, GCallback.self), nil, nil, connectFlags.toGConnectFlags())
}

func disconnectSignal<T>(instance: UnsafeMutablePointer<T>, handlerId: UInt) {
    g_signal_handler_disconnect(instance, handlerId)
}