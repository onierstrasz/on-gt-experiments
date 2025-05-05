"
Examples to replace a message send node by a “do nothing” metalink.
"
Class {
	#name : #MetaLinkDoNothingExamples,
	#superclass : #Object,
	#instVars : [
		'state'
	],
	#category : #'ONGtExperiments-MetaLink'
}

{ #category : #'test method' }
MetaLinkDoNothingExamples >> complexUpdateState [
	self state = 0 ifTrue: [ ^ nil ].
	self updateState
]

{ #category : #example }
MetaLinkDoNothingExamples >> complexUpdateStateSendNode [
	<gtExample>
	<return: #RBMessageNode>
	| sendNode |
	sendNode := (self class lookupSelector: #complexUpdateState) sendNodes first.
	self assert: sendNode selector equals: #ifTrue:.	"Ensure there are no links installed."
	sendNode links copy do: #uninstall.
	^ sendNode
]

{ #category : #example }
MetaLinkDoNothingExamples >> complexUpdateStateUpdated [
	<gtExample>
	<return: #MetaLinkDoNothingExamples>
	self assert: self state equals: 0.
	self complexUpdateState.
	self assert: self state equals: 0.
	^ self
]

{ #category : #example }
MetaLinkDoNothingExamples >> complexUpdateStateUpdatedWithMetaLink [
	<gtExample>
	<return: #Error>
	| link |
	self assert: self state equals: 0.
	link := self doNothingLink.
	self complexUpdateStateSendNode link: link.
	self complexUpdateState.
	link uninstall.
	self assert: self state equals: 42.
	^ self
]

{ #category : #example }
MetaLinkDoNothingExamples >> doNothingLink [
	<gtExample>
	<return: #MetaLink>
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
MetaLinkDoNothingExamples >> initialize [
	state := 0.
]

{ #category : #accessing }
MetaLinkDoNothingExamples >> state [
	^ state
]

{ #category : #accessing }
MetaLinkDoNothingExamples >> state: anObject [
	state := anObject
]

{ #category : #example }
MetaLinkDoNothingExamples >> stateUpdated [
	<gtExample>
	<return: #MetaLinkDoNothingExamples>
	self assert: self state equals: 0.
	self updateState.
	self assert: self state equals: 42.
	^ self
]

{ #category : #example }
MetaLinkDoNothingExamples >> stateUpdatedWithMetaLink [
	<gtExample>
	<return: #MetaLinkDoNothingExamples>
	| link |
	self assert: self state equals: 0.
	link := self doNothingLink.
	self updateStateSendNode link: link.
	self updateState.
	link uninstall.
	self assert: self state equals: 0.
	^ self
]

{ #category : #'test method' }
MetaLinkDoNothingExamples >> updateState [
	self state: 42
]

{ #category : #example }
MetaLinkDoNothingExamples >> updateStateSendNode [
	<gtExample>
	<return: #RBMessageNode>
	| sendNode |
	sendNode := (self class lookupSelector: #updateState) sendNodes first.
	self assert: sendNode selector equals: #state:.
	self assert: sendNode arguments first value equals: 42.
	^ sendNode
]
