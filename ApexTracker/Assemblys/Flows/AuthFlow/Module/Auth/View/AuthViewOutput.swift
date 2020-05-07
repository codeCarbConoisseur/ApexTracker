//
//  AuthAuthViewOutput.swift
//  ApexTracker
//
//  Created by sofvckinmadguy on 01/05/2020.
//  Copyright © 2020 me. All rights reserved.
//

protocol AuthViewOutput {

    /**
        @author sofvckinmadguy
        Notify presenter that view is ready
    */

    func loginWithSessionInfo(withSessionInfo sessionInfo: SessionInfo)
    func viewIsReady()
}
