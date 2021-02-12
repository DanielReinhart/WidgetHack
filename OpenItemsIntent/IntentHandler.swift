//
//  IntentHandler.swift
//  OpenItemsIntent
//
//  Created by Daniel Reinhart on 2/12/21.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return OpenItemsIntentHandler()
    }
    
}

class OpenItemsIntentHandler: NSObject, OpenItemsIntentHandling {
    func handle(intent: OpenItemsIntent, completion: @escaping (OpenItemsIntentResponse) -> Swift.Void) {
        let response = OpenItemsIntentResponse(code: .success, userActivity: nil)
        response.openItemCount = 5
        response.projectName = "VDC Sandbox"
        response.toolName = "Punch"

        completion(response)
    }
}
