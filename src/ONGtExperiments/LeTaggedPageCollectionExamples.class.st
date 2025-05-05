Class {
	#name : #LeTaggedPageCollectionExamples,
	#superclass : #Object,
	#category : #'ONGtExperiments-Lepiter'
}

{ #category : #page }
LeTaggedPageCollectionExamples >> primaryDbPages [
	<gtExample>
	<return: #LeTaggedPageCollection>
	| eg |
	eg := LeTaggedPageCollection forPrimaryDatabase.
	self assert: eg pages notEmpty.
	self assert: eg pages first database equals: LeDatabase primaryDB.
	^ eg
]

{ #category : #page }
LeTaggedPageCollectionExamples >> sampleDatabase [
	<gtExample>
	<return: #DatabaseHolderExamples>
	^ DatabaseHolderExamples new initializedDatabase
]

{ #category : #page }
LeTaggedPageCollectionExamples >> sampleDbPages [
	<gtExample>
	<return: #LeTaggedPageCollection>
	| eg sample |
	sample := self sampleDatabase.
	eg := LeTaggedPageCollection forDatabase: sample database.
	self assert: eg pages size equals: sample dbNamedPagesSize.
	self assert: eg pages first database equals: sample database.
	^ eg
]
