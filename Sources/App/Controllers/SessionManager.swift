//
//  SessionManager.swift
//  
//
//  Created by Erik Hatfield on 8/5/20.
//

import Foundation

class SessionManager {
    var activeSession: Session?
    
    init() {
        self.activeSession = nil
    }
    
    private func newSession(from sessionData: SessionData) {
        print("Session Manager: New Session")
        self.activeSession = Session(from: sessionData)
    }
    
    func endSession() {
        print("Session Manager: End Session")
        self.activeSession?.createSessionSummary()
        // save session data in db
        // clear active session
        self.activeSession = nil
    }
    
    func newSessionData(data: SessionData) {
        if self.activeSession == nil {
            self.newSession(from: data)
        }
    }
    
    func newLapDataPacket(lapData: LapDataPacket) {
        guard let playerLapData = lapData.lapData.first else { return }
        self.activeSession?.accept(lapData: playerLapData)
    }
}
