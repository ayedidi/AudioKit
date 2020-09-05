// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AudioKit
import XCTest

class AKBrownianNoiseTests: XCTestCase {

    func testDefault() {
        let engine = AKEngine()
        let brown = AKBrownianNoise()
        engine.output = brown
        brown.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }

    func testAmplitude() {
        let engine = AKEngine()
        let brown = AKBrownianNoise()
        brown.amplitude = 0.5
        engine.output = brown
        brown.start()
        let audio = engine.startTest(totalDuration: 1.0)
        audio.append(engine.render(duration: 1.0))
        testMD5(audio)
    }
}
