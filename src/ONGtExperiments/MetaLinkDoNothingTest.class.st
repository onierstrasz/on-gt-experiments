Class {
	#name : #MetaLinkDoNothingTest,
	#superclass : #TestCase,
	#instVars : [
		'state'
	],
	#category : #'ONGtExperiments-MetaLink'
}

{ #category : #'test method' }
MetaLinkDoNothingTest >> complexUpdateState [
	self state = 0 ifTrue: [ ^ nil ].
	self updateState
]

{ #category : #node }
MetaLinkDoNothingTest >> complexUpdateStateSendNode [
	| sendNode |
	sendNode := (self class lookupSelector: #complexUpdateState) sendNodes first.
	self assert: sendNode selector equals: #ifTrue:.
	"Ensure there are no links installed."
	sendNode links copy do: #uninstall.
	^ sendNode
]

{ #category : #link }
MetaLinkDoNothingTest >> doNothingLink [
	| link |
	link := MetaLink new
			metaObject: [ nil ];
			selector: #value;
			control: #instead.
	self assert: link metaObject value equals: nil.
	self assert: link selector equals: #value.
	^ link
]

{ #category : #initialization }
MetaLinkDoNothingTest >> setUp [
	state := 0.
]

{ #category : #accessing }
MetaLinkDoNothingTest >> state [
	^ state
]

{ #category : #accessing }
MetaLinkDoNothingTest >> state: anObject [
	state := anObject
]

{ #category : #test }
MetaLinkDoNothingTest >> testComplexUpdateStateUpdated [
	self assert: self state equals: 0.
	self complexUpdateState.
	self assert: self state equals: 0.
]

{ #category : #test }
MetaLinkDoNothingTest >> testComplexUpdateStateUpdatedWithMetaLink [
	| link |
	self assert: self state equals: 0.
	link := self doNothingLink.
	self complexUpdateStateSendNode link: link.
	self complexUpdateState.
	link uninstall.
	self assert: self state equals: 42.
]

{ #category : #test }
MetaLinkDoNothingTest >> testStateUpdated [
	self assert: self state equals: 0.
	self updateState.
	self assert: self state equals: 42.
]

{ #category : #test }
MetaLinkDoNothingTest >> testStateUpdatedWithMetaLink [
	| link |
	self assert: self state equals: 0.
	link := self doNothingLink.
	self updateStateSendNode link: link.
	self updateState.
	link uninstall.
	self assert: self state equals: 0.
]

{ #category : #'test method' }
MetaLinkDoNothingTest >> updateState [
	self state: 42
]

{ #category : #'node - accessing' }
MetaLinkDoNothingTest >> updateStateSendNode [
	| sendNode |
	sendNode := (self class lookupSelector: #updateState) sendNodes first.
	self assert: sendNode selector equals: #state:.
	self assert: sendNode arguments first value equals: 42.
	^ sendNode
]
