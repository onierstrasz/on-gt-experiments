Class {
	#name : #BellairsPerson,
	#superclass : #BellairsEntity,
	#category : #'ONGtExperiments-Bellairs'
}

{ #category : #accessing }
BellairsPerson >> country [
	^ self json at: 'country'
]

{ #category : #views }
BellairsPerson >> gtSummaryFor: aView [
	<gtView>
	"self summary ifEmpty: [ ^ aView empty ]."
	^ aView columnedList
		title: 'Summary';
		priority: 20;
		items: [ self summary ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Key'
			text: #first
			width: 100;
		column: 'Value' text: #second;
		send: #last;
		actionUpdateButton
]

{ #category : #accessing }
BellairsPerson >> institution [
	^ self json at: 'institution'
]

{ #category : #accessing }
BellairsPerson >> name [
	^ self json at: 'name'
]

{ #category : #'printing\t\t' }
BellairsPerson >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #accessing }
BellairsPerson >> role [
	^ self json at: 'role'
]

{ #category : #accessing }
BellairsPerson >> summary [
	"To do: add send fields"

	^ {{'name'.
			self name}.
		{'institution'.
			self institution}.
		{'url'.
			self url}.
		{'country'.
			self country}.
		{'workshop'.
			self workshop}.
		{'role'.
			self role}}
]

{ #category : #accessing }
BellairsPerson >> url [
	^ self json at: 'url' ifAbsent: '-'
]

{ #category : #accessing }
BellairsPerson >> workshop [
	^ self json at: 'workshop'
]
