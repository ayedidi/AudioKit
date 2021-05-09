// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation

/// AudioKit version of Apple's Expander Audio Unit
///
public class Expander: Node {

    fileprivate let effectAU = AVAudioUnitEffect(appleEffect: kAudioUnitSubType_DynamicsProcessor)

    let input: Node
    public var connections: [Node] { [input] }
    public var avAudioNode: AVAudioNode { effectAU }

    /// Specification details for expansionRatio
    public static let expansionRatioDef = NodeParameterDef(
        identifier: "expansionRatio",
        name: "Expansion Ratio",
        address: 2,
        defaultValue: 2,
        range: 1 ... 50.0,
        unit: .rate)

    /// Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    @Parameter(expansionRatioDef) public var expansionRatio: AUValue

    /// Specification details for expansionThreshold
    public static let expansionThresholdDef = NodeParameterDef(
        identifier: "expansionThreshold",
        name: "Expansion Threshold",
        address: 2,
        defaultValue: 2,
        range: 1 ... 50.0,
        unit: .rate)

    /// Expansion Threshold (rate) ranges from 1 to 50.0 (Default: 2)
    @Parameter(expansionThresholdDef) public var expansionThreshold: AUValue

    /// Specification details for attackTime
    public static let attackTimeDef = NodeParameterDef(
        identifier: "attackTime",
        name: "Attack Time",
        address: 4,
        defaultValue: 0.001,
        range: 0.0001 ... 0.2,
        unit: .seconds)

    /// Attack Time (seconds) ranges from 0.0001 to 0.2 (Default: 0.001)
    @Parameter(attackTimeDef) public var attackTime: AUValue

    /// Specification details for releaseTime
    public static let releaseTimeDef = NodeParameterDef(
        identifier: "releaseTime",
        name: "Release Time",
        address: 5,
        defaultValue: 0.05,
        range: 0.01 ... 3,
        unit: .seconds)

    /// Release Time (seconds) ranges from 0.01 to 3 (Default: 0.05)
    @Parameter(releaseTimeDef) public var releaseTime: AUValue

    /// Specification details for masterGain
    public static let masterGainDef = NodeParameterDef(
        identifier: "masterGain",
        name: "Master Gain",
        address: 6,
        defaultValue: 0,
        range: -40 ... 40,
        unit: .decibels)

    /// Master Gain (decibels) ranges from -40 to 40 (Default: 0)
    @Parameter(masterGainDef) public var masterGain: AUValue

    /// Compression Amount (dB) read only
    public var compressionAmount: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[7].value ?? 0
    }

    /// Input Amplitude (dB) read only
    public var inputAmplitude: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[8].value ?? 0
    }

    /// Output Amplitude (dB) read only
    public var outputAmplitude: AUValue {
        return effectAU.auAudioUnit.parameterTree?.allParameters[9].value ?? 0
    }
    /// Tells whether the node is processing (ie. started, playing, or active)
    public var isStarted = true

    /// Initialize the expander node
    ///
    /// - parameter input: Input node to process
    /// - parameter expansionRatio: Expansion Ratio (rate) ranges from 1 to 50.0 (Default: 2)
    /// - parameter expansionThreshold: Expansion Threshold (rate) ranges from 1 to 50.0 (Default: 2)
    /// - parameter attackTime: Attack Time (seconds) ranges from 0.0001 to 0.2 (Default: 0.001)
    /// - parameter releaseTime: Release Time (seconds) ranges from 0.01 to 3 (Default: 0.05)
    /// - parameter masterGain: Master Gain (decibels) ranges from -40 to 40 (Default: 0)
    ///
    public init(
        _ input: Node,
        expansionRatio: AUValue = expansionRatioDef.defaultValue,
        expansionThreshold: AUValue = expansionThresholdDef.defaultValue,
        attackTime: AUValue = attackTimeDef.defaultValue,
        releaseTime: AUValue = releaseTimeDef.defaultValue,
        masterGain: AUValue = masterGainDef.defaultValue) {
        self.input = input

        associateParams(with: effectAU)

        self.expansionRatio = expansionRatio
        self.expansionThreshold = expansionThreshold
        self.attackTime = attackTime
        self.releaseTime = releaseTime
        self.masterGain = masterGain
    }

    /// Function to start, play, or activate the node, all do the same thing
    public func start() {
        effectAU.bypass = false
        isStarted = true
    }

    /// Function to stop or bypass the node, both are equivalent
    public func stop() {
        effectAU.bypass = true
        isStarted = false
    }
}
