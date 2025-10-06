--!strict
--!native

export type Instances = "Accessory" | "Accoutrement" | "Actor" | "AdGui" | "AdPortal" | "AdService" | "AdvancedDragger" | "AirController" | "AlignOrientation" | "AlignPosition" | "AnalysticsSettings" | "AnalyticsService" | "AngularVelocity" | "Animation" | "AnimationClip" | "AnimationClipProvider" | "AnimationConstraint" | "AnimationController" | "AnimationFromVideoCreatorService" | "AnimationFromVideoCreatorStudioService" | "AnimationImportData" | "AnimationRigData" | "AnimationStreamTrack" | "AnimationTrack" | "Animator" | "AppStorageService" | "AppUpdateService" | "ArcHandles" | "AssetCounterService" | "AssetDeliveryProxy" | "AssetImportService" | "AssetImportSession" | "AssetManagerService" | "AssetPatchSettings" | "AssetService" | "AssetSoundEffect" | "Atmosphere" | "Attachment" | "AudioPages" | "AudioSearchParams" | "AvatarChatService" | "AvatarEditorService" | "AvatarImportService" | "Backpack" | "BackpackItem" | "BadgeService" | "BallSocketConstraint" | "BaseImportData" | "BasePart" | "BasePlayerGui" | "BaseScript" | "BaseWrap" | "Beam" | "BevelMesh" | "BillboardGui" | "BinaryStringValue" | "BindableEvent" | "BindableFunction" | "BlockMesh" | "BloomEffect" | "BlurEffect" | "BodyAngularVelocity" | "BodyColors" | "BodyForce" | "BodyGyro" | "BodyMover" | "BodyPosition" | "BodyThrust" | "BodyVelocity" | "Bone" | "BoolValue" | "BoxHandleAdornment" | "Breakpoint" | "BrickColorValue" | "BrowserService" | "BubbleChatConfiguration" | "BubbleChatMessageProperties" | "BulkImportService" | "BuoyancySensor" | "CacheableContentProvider" | "CalloutService" | "Camera" | "CanvasGroup" | "CaptureService" | "CatalogPages" | "CFrameValue" | "ChangeHistoryService" | "ChannelSelectorSoundEffect" | "CharacterAppearance" | "CharacterMesh" | "Chat" | "ChatInputBarConfiguration" | "ChatWindowConfiguration" | "ChorusSoundEffect" | "ClickDetector" | "ClientReplicator" | "ClimbController" | "Clothing" | "CloudLocalizationTable" | "Clouds" | "ClusterPacketCache" | "CollectionService" | "Color3Value" | "ColorCorrectionEffect" | "CommandInstance" | "CommandService" | "CompressorSoundEffect" | "ConeHandleAdornment" | "Configuration" | "ConfigureServerService" | "Constraint" | "ContentProvider" | "ContextActionService" | "Controller" | "ControllerBase" | "ControllerManager" | "ControllerPartSensor" | "ControllerSensor" | "ControllerService" | "CookiesService" | "CoreGui" | "CorePackages" | "CoreScript" | "CoreScriptDebuggingManagerHelper" | "CoreScriptSyncService" | "CornerWedgePart" | "CrossDMScriptChangeListener" | "CSGDictionaryService" | "CurveAnimation" | "CustomEvent" | "CustomEventReceiver" | "CustomSoundEffect" | "CylinderHandleAdornment" | "CylinderMesh" | "CylindricalConstraint" | "DataModel" | "DataModelMesh" | "DataModelPatchService" | "DataModelSession" | "DataStore" | "DataStoreIncrementOptions" | "DataStoreInfo" | "DataStoreKey" | "DataStoreKeyInfo" | "DataStoreKeyPages" | "DataStoreListingPages" | "DataStoreObjectVersionInfo" | "DataStoreOptions" | "DataStorePages" | "DataStoreService" | "DataStoreSetOptions" | "DataStoreVersionPages" | "Debris" | "DebuggablePluginWatcher" | "DebuggerBreakpoint" | "DebuggerConnection" | "DebuggerConnectionManager" | "DebuggerLuaResponse" | "DebuggerManager" | "DebuggerUIService" | "DebuggerVariable" | "DebuggerWatch" | "DebugSettings" | "Decal" | "DepthOfFieldEffect" | "DeviceIdService" | "Dialog" | "DialogChoice" | "DistortionSoundEffect" | "DockWidgetPluginGui" | "DoubleConstrainedValue" | "DraftsService" | "DragDetector" | "Dragger" | "DraggerService" | "DynamicMesh" | "DynamicRotate" | "EchoSoundEffect" | "EmotesPages" | "EqualizerSoundEffect" | "EulerRotationCurve" | "EventIngestService" | "ExperienceAuthService" | "ExperienceInviteOptions" | "Explosion" | "FaceAnimatorService" | "FaceControls" | "FaceInstance" | "FacialAnimationRecordingService" | "FacialAnimationStreamingServiceStats" | "FacialAnimationStreamingServiceV2" | "FacialAnimationStreamingSubsessionStats" | "FacsImportData" | "Feature" | "File" | "FileMesh" | "Fire" | "Flag" | "FlagStand" | "FlagStandService" | "FlangeSoundEffect" | "FloatCurve" | "FloorWire" | "FlyweightService" | "Folder" | "ForceField" | "FormFactorPart" | "Frame" | "FriendPages" | "FriendService" | "FunctionalTest" | "GamepadService" | "GamePassService" | "GameSettings" | "GenericSettings" | "Geometry" | "GeometryService" | "GetTextBoundsParams" | "GlobalDataStore" | "GlobalSettings" | "Glue" | "GoogleAnalyticsConfiguration" | "GroundController" | "GroupImportData" | "GroupService" | "GuiBase" | "GuiBase2d" | "GuiBase3d" | "GuiButton" | "GuidRegistryService" | "GuiLabel" | "GuiMain" | "GuiObject" | "GuiService" | "HandleAdornment" | "Handles" | "HandlesBase" | "HapticService" | "Hat" | "HeightmapImporterService" | "HiddenSurfaceRemovalAsset" | "Highlight" | "HingeConstraint" | "Hint" | "Hole" | "Hopper" | "HopperBin" | "HSRDataContentProvider" | "HttpRbxApiService" | "HttpRequest" | "HttpService" | "Humanoid" | "HumanoidController" | "HumanoidDescription" | "IKControl" | "ILegacyStudioBridge" | "ImageButton" | "ImageDataExperimental" | "ImageHandleAdornment" | "ImageLabel" | "IncrementalPatchBuilder" | "InputObject" | "InsertService" | "Instance" | "InstanceAdornment" | "IntConstrainedValue" | "IntersectOperation" | "IntValue" | "InventoryPages" | "IXPService" | "JointImportData" | "JointInstance" | "JointsService" | "KeyboardService" | "Keyframe" | "KeyframeMarker" | "KeyframeSequence" | "KeyframeSequenceProvider" | "LanguageService" | "LayerCollector" | "LegacyStudioBridge" | "Light" | "Lighting" | "LinearVelocity" | "LineForce" | "LineHandleAdornment" | "LiveScriptingService" | "LocalDebuggerConnection" | "LocalizationService" | "LocalizationTable" | "LocalScript" | "LocalStorageService" | "LodDataEntity" | "LodDataService" | "LoginService" | "LogService" | "LSPFileSyncService" | "LuaSettings" | "LuaSourceContainer" | "LuauScriptAnalyzerService" | "LuaWebService" | "ManualGlue" | "ManualSurfaceJointInstance" | "ManualWeld" | "MarkerCurve" | "MarketplaceService" | "MaterialGenerationService" | "MaterialGenerationSession" | "MaterialImportData" | "MaterialService" | "MaterialVariant" | "MemoryStoreQueue" | "MemoryStoreService" | "MemoryStoreSortedMap" | "MemStorageConnection" | "MemStorageService" | "MeshContentProvider" | "MeshDataExperimental" | "MeshImportData" | "MeshPart" | "Message" | "MessageBusConnection" | "MessageBusService" | "MessagingService" | "MetaBreakpoint" | "MetaBreakpointContext" | "MetaBreakpointManager" | "Model" | "ModuleScript" | "Motor" | "Motor6D" | "MotorFeature" | "Mouse" | "MouseService" | "MultipleDocumentInterfaceInstance" | "NegateOperation" | "NetworkClient" | "NetworkMarker" | "NetworkPeer" | "NetworkReplicator" | "NetworkServer" | "NetworkSettings" | "NoCollisionConstraint" | "NonReplicatedCSGDictionaryService" | "NotificationService" | "NumberPose" | "NumberValue" | "ObjectValue" | "OmniRecommendationsService" | "OpenCloudService" | "OrderedDataStore" | "OutfitPages" | "PackageLink" | "PackageService" | "PackageUIService" | "Pages" | "Pants" | "ParabolaAdornment" | "Part" | "PartAdornment" | "ParticleEmitter" | "PartOperation" | "PartOperationAsset" | "PatchBundlerFileWatch" | "PatchMapping" | "Path" | "PathfindingLink" | "PathfindingModifier" | "PathfindingService" | "PausedState" | "PausedStateBreakpoint" | "PausedStateException" | "PermissionsService" | "PhysicsService" | "PhysicsSettings" | "PitchShiftSoundEffect" | "Plane" | "PlaneConstraint" | "Platform" | "Player" | "PlayerEmulatorService" | "PlayerGui" | "PlayerMouse" | "Players" | "PlayerScripts" | "Plugin" | "PluginAction" | "PluginDebugService" | "PluginDragEvent" | "PluginGui" | "PluginGuiService" | "PluginManagementService" | "PluginManager" | "PluginManagerInterface" | "PluginMenu" | "PluginMouse" | "PluginPolicyService" | "PluginToolbar" | "PluginToolbarButton" | "PointLight" | "PointsService" | "PolicyService" | "Pose" | "PoseBase" | "PostEffect" | "PrismaticConstraint" | "ProcessInstancePhysicsService" | "ProximityPrompt" | "ProximityPromptService" | "PublishService" | "PVAdornment" | "PVInstance" | "QWidgetPluginGui" | "RayValue" | "RbxAnalyticsService" | "ReflectionMetadata" | "ReflectionMetadataCallbacks" | "ReflectionMetadataClass" | "ReflectionMetadataClasses" | "ReflectionMetadataEnum" | "ReflectionMetadataEnumItem" | "ReflectionMetadataEnums" | "ReflectionMetadataEvents" | "ReflectionMetadataFunctions" | "ReflectionMetadataItem" | "ReflectionMetadataMember" | "ReflectionMetadataProperties" | "ReflectionMetadataYieldFunctions" | "RemoteCursorService" | "RemoteDebuggerServer" | "RemoteEvent" | "RemoteFunction" | "RenderingTest" | "RenderSettings" | "ReplicatedFirst" | "ReplicatedStorage" | "ReverbSoundEffect" | "RigidConstraint" | "RobloxPluginGuiService" | "RobloxReplicatedStorage" | "RocketPropulsion" | "RodConstraint" | "RomarkService" | "RootImportData" | "RopeConstraint" | "Rotate" | "RotateP" | "RotateV" | "RotationCurve" | "RtMessagingService" | "RunningAverageItemDouble" | "RunningAverageItemInt" | "RunningAverageTimeIntervalItem" | "RunService" | "RuntimeScriptService" | "SafetyService" | "ScreenGui" | "ScreenshotHud" | "Script" | "ScriptBuilder" | "ScriptChangeService" | "ScriptCloneWatcher" | "ScriptCloneWatcherHelper" | "ScriptCommitService" | "ScriptContext" | "ScriptDebugger" | "ScriptDocument" | "ScriptEditorService" | "ScriptRegistrationService" | "ScriptRuntime" | "ScriptService" | "ScrollingFrame" | "Seat" | "Selection" | "SelectionBox" | "SelectionHighlightManager" | "SelectionLasso" | "SelectionPartLasso" | "SelectionPointLasso" | "SelectionSphere" | "SensorBase" | "ServerReplicator" | "ServerScriptService" | "ServerStorage" | "ServiceProvider" | "ServiceVisibilityService" | "SessionService" | "SharedTableRegistry" | "Shirt" | "ShirtGraphic" | "ShorelineUpgraderService" | "SkateboardController" | "SkateboardPlatform" | "Skin" | "Sky" | "SlidingBallConstraint" | "Smoke" | "SmoothVoxelsUpgraderService" | "Snap" | "SnippetService" | "SocialService" | "SolidModelContentProvider" | "Sound" | "SoundEffect" | "SoundGroup" | "SoundService" | "Sparkles" | "SpawnerService" | "SpawnLocation" | "SpecialMesh" | "SphereHandleAdornment" | "SpotLight" | "SpringConstraint" | "StackFrame" | "StandalonePluginScripts" | "StandardPages" | "StarterCharacterScripts" | "StarterGear" | "StarterGui" | "StarterPack" | "StarterPlayer" | "StarterPlayerScripts" | "Stats" | "StatsItem" | "Status" | "StringValue" | "Studio" | "StudioAssetService" | "StudioData" | "StudioDeviceEmulatorService" | "StudioPublishService" | "StudioScriptDebugEventListener" | "StudioSdkService" | "StudioService" | "StudioTheme" | "StyleBase" | "StyleDerive" | "StyleLink" | "StyleRule" | "StyleSheet" | "StylingService" | "SunRaysEffect" | "SurfaceAppearance" | "SurfaceGui" | "SurfaceGuiBase" | "SurfaceLight" | "SurfaceSelection" | "SwimController" | "SyncScriptBuilder" | "TaskScheduler" | "Team" | "TeamCreateData" | "TeamCreatePublishService" | "TeamCreateService" | "Teams" | "TeleportAsyncResult" | "TeleportOptions" | "TeleportService" | "TemporaryCageMeshProvider" | "TemporaryScriptService" | "Terrain" | "TerrainDetail" | "TerrainRegion" | "TestService" | "TextBox" | "TextBoxService" | "TextButton" | "TextChannel" | "TextChatCommand" | "TextChatConfigurations" | "TextChatMessage" | "TextChatMessageProperties" | "TextChatService" | "TextFilterResult" | "TextFilterTranslatedResult" | "TextLabel" | "TextService" | "TextSource" | "Texture" | "TextureGuiExperimental" | "ThirdPartyUserService" | "ThreadState" | "TimerService" | "ToastNotificationService" | "Tool" | "Torque" | "TorsionSpringConstraint" | "TotalCountTimeIntervalItem" | "TouchInputService" | "TouchTransmitter" | "TracerService" | "TrackerLodController" | "TrackerStreamAnimation" | "Trail" | "Translator" | "TremoloSoundEffect" | "TriangleMeshPart" | "TrussPart" | "TutorialService" | "Tween" | "TweenBase" | "TweenService" | "UGCAvatarService" | "UGCValidationService" | "UIAspectRatioConstraint" | "UIBase" | "UIComponent" | "UIConstraint" | "UICorner" | "UIGradient" | "UIGridLayout" | "UIGridStyleLayout" | "UILayout" | "UIListLayout" | "UIPadding" | "UIPageLayout" | "UIScale" | "UISizeConstraint" | "UIStroke" | "UITableLayout" | "UITextSizeConstraint" | "UnionOperation" | "UniversalConstraint" | "UnvalidatedAssetService" | "UserGameSettings" | "UserInputService" | "UserService" | "UserSettings" | "UserStorageService" | "ValueBase" | "Vector3Curve" | "Vector3Value" | "VectorForce" | "VehicleController" | "VehicleSeat" | "VelocityMotor" | "VersionControlService" | "VideoCaptureService" | "VideoFrame" | "ViewportFrame" | "VirtualInputManager" | "VirtualUser" | "VisibilityCheckDispatcher" | "VisibilityService" | "Visit" | "VoiceChatInternal" | "VoiceChatService" | "VRService" | "WedgePart" | "Weld" | "WeldConstraint" | "WireframeHandleAdornment" | "Workspace" | "WorldModel" | "WorldRoot" | "WrapLayer" | "WrapTarget"

--[[@Trove]]
export type Trove = typeof(require(`./BetterAnimate_Helpers/Trove`))

--[[@Utils]]
export type Utils = typeof(require(`./BetterAnimate_Helpers/Utils`))

--[[@Services]]
export type Services = typeof(require(`./BetterAnimate_Helpers/Services`))

--[[@Destroyer]]
export type Destroyer = typeof(require(`./BetterAnimate_Helpers/Destroyer`))

--[[@Unlim]]
local Unlim_Bindable = require(`./BetterAnimate_Helpers/Unlim_Bindable`)
export type Unlim_Bindable_Start = typeof(Unlim_Bindable)
export type Unlim_Bindable = Unlim_Bindable.Unlim_Bindable

--[[@BetterAnimate]]
export type BetterAnimate_AnimationClasses = "Walk" | "Run" | "Swim" | "Swimidle" | "Jump" | "Fall" | "Climb" | "Sit" | "Idle" | "Emote" | "Temp" --| string
export type BetterAnimate_Directions = "ForwardRight" | "ForwardLeft" | "BackwardRight" | "BackwardLeft" | "Right" | "Left" | "Backward" | "Forward" | "Up" | "Down" | "None"
export type BetterAnimate_EventNames = "NewMoveDirection" | "NewState" | "NewAnimation" | "KeyframeReached"

export type BetterAnimate_AnimationData = {
	ID: number | string?,
	Instance: Animation?,
	Weight: number?,
	Index: string?,
}

export type BetterAnimate_Start = {
	New: (Character: Model)-> BetterAnimate,
	GetMoveDirectionName: (MoveDirection: Vector3)-> BetterAnimate_Directions,
	GetAnimationData: (AnimationData: BetterAnimate_AnimationData | number | string | Instance, DefaultWeight: number?)-> BetterAnimate_AnimationData,
	GetClassesPreset: (Index: string)-> ({ [BetterAnimate_AnimationClasses]: { [any]: BetterAnimate_AnimationData | string | number | Animation } }?),
	FixCenterOfMass: (PhysicalProperties, BasePart)-> (),
	PresetsTag: string,
	LocalUitls: {[any]: any},
}

export type BetterAnimate = {
	
	--[[Public]]
	
	Trove: Trove, -- If you want to attach something
	
	Events: {
		--[[Hiiii]]
		NewMoveDirection: Unlim_Bindable,
		NewState: Unlim_Bindable,
		NewAnimation: Unlim_Bindable,
		
		--[[KeyframeReached == MarkerReached]]
		KeyframeReached: Unlim_Bindable,
		MarkerReached: Unlim_Bindable,
		
		--[BetterAnimate_EventNames]: Unlim_Bindable,
	},
	
	FastConfig: { -- Like FFlag to fix something
		R6ClimbFix: boolean, -- For R6
		EmoteIngnoreEmotable: boolean,
		WaitFallOnJump: number,
		DefaultAnimationLength: number,
		DefaultAnimationWeight: number,	
		AnimationSpeedMultiplier: number,
		AnimationPlayTransition: number,
		AnimationStopTransition: number,
		AnimationPriority: Enum.AnimationPriority,
		ToolAnimationPlayTransition: number,
		ToolAnimationStopTransition: number,
		ToolAnimationPriority: Enum.AnimationPriority,
		MoveDirection: Vector3?,
		SetAnimationOnIdDifference: boolean?,
		AssemblyLinearVelocity: Vector3?, -- Moving speed
	},
	
	SimpleStateWrapper: (Function: (self: BetterAnimate)-> ())-> ((BetterAnimate, string)-> ()),
	
	GetInverse: (self: BetterAnimate)-> number,
	GetMoveDirection: (self: BetterAnimate)-> Vector3,
	GetRandomClassAnimation: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses)-> (any, BetterAnimate_AnimationData),
	
	SetForcedState: (self: BetterAnimate, State: string)-> (BetterAnimate),
	SetEventEnabled: (self: BetterAnimate, Name: BetterAnimate_EventNames, Enabled: boolean?)-> (BetterAnimate),
	SetDebugEnabled: (self: BetterAnimate, Enabled: boolean?)-> (BetterAnimate),
	SetClassesPreset: (self: BetterAnimate, Preset: { [BetterAnimate_AnimationClasses]: { [any]: BetterAnimate_AnimationData | string | number | Animation } })-> (BetterAnimate),
	SetClassPreset: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Preset: { [any]: BetterAnimate_AnimationData | string | number | Animation })-> (BetterAnimate),
	SetInverseEnabled: (self: BetterAnimate, Enabled: boolean?)-> (BetterAnimate),
	SetInverseDirection: (self: BetterAnimate, Direction: string, Inverse: boolean?)-> (BetterAnimate),
	SetClassInverse: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Inverse: boolean?)-> (BetterAnimate),
	SetClassTimer: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Timer: number)-> (BetterAnimate),
	SetClassMaxTimer: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, MaxTimer: number | NumberRange?)-> (BetterAnimate),
	SetClassEmotable: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Emotable: boolean?)-> (BetterAnimate),
	SetClassAnimationSpeedAdjust: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Adjust: number)-> (BetterAnimate),
	SetRunningStateRange: (self: BetterAnimate, Range: NumberRange)-> (BetterAnimate),
	SetStateFunction: (self: BetterAnimate, State: string, Function: (BetterAnimate_AnimationData, string)-> ())-> (BetterAnimate),
	
	AddAnimation: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, Index: any?, AnimationData: BetterAnimate_AnimationData)-> (BetterAnimate),
	StopClassAnimation: (self: BetterAnimate)-> (),
	PlayClassAnimation: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses, TransitionTime: number?)-> (),
	PlayToolAnimation: (self: BetterAnimate, Data: BetterAnimate_AnimationData | string | number | Animation)-> (),
	StopToolAnimation: (self: BetterAnimate, Data: BetterAnimate_AnimationData | string | number | Animation)-> (),
	StopEmote: (self: BetterAnimate)-> (),
	PlayEmote: (self: BetterAnimate, Data: BetterAnimate_AnimationData | string | number | Animation)-> (number),
	Step: (self: BetterAnimate, Dt: number)-> (),
	
	Destroy: (self: BetterAnimate)-> (),
	--

	--[[Private]]
	_Speed: number,
	_AssemblyLinearVelocity: Vector3,
	_MoveDirection: Vector3,
	_PrimaryPart: BasePart,
	_Animator: AnimationController | Humanoid,

	_RigType: "R6" | "R15" | "Custom", --Enum.HumanoidRigType
	
	_Time: {
		Debug: number,
		Jumped: number,
	},
	
	_State: {
		Forced: string?,
		Current: string,
		--Deffered: {
		--	[string]: boolean,
		--},
		
		Functions: {
			[string]: (BetterAnimate, State: string)-> ()
		}
	},

	_Trove: {
		Main: Trove,
		Debug: Trove,
		Animation: Trove,
		Emote: Trove,
		Tool: Trove,
	},

	_Events_Enabled: {
		[BetterAnimate_EventNames]: boolean,
	},
	
	_Class: {
		Current: string?,
		Inverse:  { [BetterAnimate_AnimationClasses]: boolean },
		Emotable: { [BetterAnimate_AnimationClasses]: boolean },
		AnimationSpeedAdjust: { [BetterAnimate_AnimationClasses]: number },
		DirectionAdjust: { [BetterAnimate_AnimationClasses]: CFrame },
		--SwitchIgnore: { [BetterAnimate_AnimationClasses]: boolean },
		TimerMax: { [BetterAnimate_AnimationClasses]: number | NumberRange },
		Timer: { [BetterAnimate_AnimationClasses]: number | NumberRange },
		SpeedRange: NumberRange,
		Animations: { [BetterAnimate_AnimationClasses]: { [any]: BetterAnimate_AnimationData } }
	},

	_Inverse: {
		Enabled: boolean,
		Directions: { [BetterAnimate_Directions]: boolean}
	},

	_Animation: {
		Current: Animation?,
		CurrentTrack: AnimationTrack?,
		CurrentIndex: any?,
		CurrentSpeed: number?,
		DefaultLength: number,
		DefaultWeight: number,
		ToolPriority: Enum.AnimationPriority,
		Priority: Enum.AnimationPriority,
		KeyframeFunction: ()-> (),
		Emoting: boolean?,
	},
	
	_SetAnimation: (self: BetterAnimate, Class: BetterAnimate_AnimationClasses?, TransitionTime: number?, Index: any, AnimationData: BetterAnimate_AnimationData)-> (Animation, AnimationTrack, number),
	_AnimationEvent: (self: BetterAnimate, Keyframe: string?)-> (),
	
	__index: BetterAnimate,
	
	[any]: (self: BetterAnimate, ...any)-> (...any),
	--
}

return true