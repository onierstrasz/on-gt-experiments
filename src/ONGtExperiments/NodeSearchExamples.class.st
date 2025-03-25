"
I provide examples for the nodesForSource: extension to CompiledMethod.
The intent is to make it easier to search for source code expressions to install MetaLinks.
"
Class {
	#name : #NodeSearchExamples,
	#superclass : #TestCase,
	#category : #'ONGtExperiments-MetaLink'
}

{ #category : #accessing }
NodeSearchExamples >> findBlock [
	<gtExample>
	| nodes |
	nodes := self methodToTest nodesForSource: '[^ temp raisedTo: 2]'.
	self assert: nodes size equals: 1.
	self assert: nodes equals: self methodToTest blockNodes.
	^ nodes first
]

{ #category : #accessing }
NodeSearchExamples >> findTemp [
	<gtExample>
	| nodes |
	nodes := self methodToTest nodesForSource: 'temp'.
	self assert: nodes size equals: 5.
	^ nodes
]

{ #category : #accessing }
NodeSearchExamples >> methodToTest [
	<gtExample>
	^ ReflectivityExamples2 >> #methodWithTempVarAccess
]

{ #category : #accessing }
NodeSearchExamples >> replaceBlock [
	<gtExample>
	| link result nodes |
	link := MetaLink new
			metaObject: [ 42 ];
			selector: #value;
			control: #instead.
	nodes := ReflectivityExamples2 >> #methodWithTempVarAccess
			nodesForSource: '[^ temp raisedTo: 2]'.
	nodes first link: link.
	result := ReflectivityExamples2 new methodWithTempVarAccess.
	self assert: result equals: 42.
	nodes first removeLink: link.
	^ result
]
