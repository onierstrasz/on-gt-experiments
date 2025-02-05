Class {
	#name : #BaselineOfONGtExperiments,
	#superclass : #BaselineOf,
	#category : #BaselineOfONGtExperiments
}

{ #category : #loading }
BaselineOfONGtExperiments class >> loadLepiter [
	IceRepository registry  
		detect: [ :aRepository |
			aRepository name = 'on-gt-experiments' ]
		ifFound: [ :aRepository | 
			| defaultDatabase currentProperties |
			defaultDatabase := LeDatabasesRegistry defaultLogicalDatabase.
			currentProperties := defaultDatabase properties.
			currentProperties addRegisteredDirectory: aRepository repositoryDirectory / 'lepiter'.
			defaultDatabase reload ]
		ifNone: [
			self inform: 'Repository not found.' ]
]

{ #category : #baseline }
BaselineOfONGtExperiments >> baseline: spec [
	<baseline>
		^ spec for: #common do: [
			spec package: 'ONGtExperiments'
		]
]
