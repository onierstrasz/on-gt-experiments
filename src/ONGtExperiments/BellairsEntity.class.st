Class {
	#name : #BellairsEntity,
	#superclass : #Object,
	#instVars : [
		'registry',
		'json'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsEntity >> json [
	^ json
]

{ #category : #accessing }
BellairsEntity >> json: anObject [
	json := anObject
]

{ #category : #accessing }
BellairsEntity >> registry [
	^ registry
]

{ #category : #accessing }
BellairsEntity >> registry: anObject [
	registry := anObject
]
