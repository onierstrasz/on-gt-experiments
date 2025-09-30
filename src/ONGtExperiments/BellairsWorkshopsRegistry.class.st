Class {
	#name : #BellairsWorkshopsRegistry,
	#superclass : #Object,
	#instVars : [
		'json',
		'persons'
	],
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #initialization }
BellairsWorkshopsRegistry >> initialize [
	persons := Dictionary new
]

{ #category : #initialization }
BellairsWorkshopsRegistry >> initializeFromJson: aJson [
	json := aJson
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> json [
	^ json
]

{ #category : #accessing }
BellairsWorkshopsRegistry >> persons [
	^ persons
]
