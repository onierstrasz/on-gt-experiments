"
Playing with lazy lists — not working
"
Class {
	#name : #LazyList,
	#superclass : #OrderedCollection,
	#instVars : [
		'block'
	],
	#category : #'ONGtExperiments-Lazy'
}

{ #category : #accessing }
LazyList class >> for: aTwoArgumentBlock [
	^ self new
		block: aTwoArgumentBlock;
		yourself
]

{ #category : #accessing }
LazyList >> at: n [
	^ n > self size ifTrue: [ self at: n ] ifFalse: [ self cacheUpTo: n ]
]

{ #category : #accessing }
LazyList >> block [
	^ block
]

{ #category : #accessing }
LazyList >> block: anObject [
	block := anObject
]

{ #category : #accessing }
LazyList >> cacheUpTo: n [
	self assert: n > self size.
	self halt.
	^ self size + 1
		to: n
		do: [ :i | self at: i put: (self block value: i value: self) ]
]
