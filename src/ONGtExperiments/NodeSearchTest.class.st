Class {
	#name : #NodeSearchTest,
	#superclass : #TestCase,
	#category : #'ONGtExperiments-MetaLink'
}

{ #category : #accessing }
NodeSearchTest >> methodToTest [
	^ ReflectivityExamples2 >> #methodWithTempVarAccess
]

{ #category : #accessing }
NodeSearchTest >> testFindBlock [
	| nodes |
	nodes := self methodToTest nodesForSource: '[^ temp raisedTo: 2]'.
	self assert: nodes size equals: 1
]

{ #category : #accessing }
NodeSearchTest >> testFindTemp [
	| nodes |
	nodes := self methodToTest nodesForSource: 'temp'.
	self assert: nodes size equals: 5.
	^ nodes
]

{ #category : #accessing }
NodeSearchTest >> testLink [
	| link result node |
	link := MetaLink new
			metaObject: [ 42 ];
			selector: #value;
			control: #instead.
	node := (self methodToTest nodesForSource: '[^ temp raisedTo: 2]') first.
	self assert: node sourceCode equals: '[^ temp raisedTo: 2]'.
	node  link: link.
	result := ReflectivityExamples2 new methodWithTempVarAccess.
	self assert: result equals: 42.
	node  removeLink: link.
]
