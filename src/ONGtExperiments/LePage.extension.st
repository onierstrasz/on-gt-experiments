Extension { #name : #LePage }

{ #category : #'*ONGtExperiments' }
LePage >> gtActionNotesFor: anAction [
	"<lePageAction>"
	| icon tooltip |
	self isNamedPage ifFalse: [ ^ anAction empty ].
	(self hasTagNamed: 'Notes') ifTrue: [ ^ anAction empty ].
	self title = 'Notes' ifTrue: [ ^ anAction empty ].
	(self notesPageExistsFor: self)
		ifTrue: [ tooltip := 'Spawn Notes page'.
			icon := BrGlamorousVectorIcons note ]
		ifFalse: [ tooltip := 'Create Notes page'.
			icon := BrGlamorousVectorIcons add ].
	^ anAction button
		priority: 76;
		icon: icon;
		tooltip: tooltip;
		id: GtInspectorInspectButtonId;
		action: [ :aButton | 
			aButton phlow spawnTool: 
				(self notesPageFor: self) asPhlowTool ];
		primaryModifierAction: [ :aButton | 
				BlSpace new
					pageInPager: (self notesPageFor: self);
					withSceneDriller;
					showFrom: aButton ]
			mouseCursor: BlCopyCursor new
]

{ #category : #'*ONGtExperiments' }
LePage >> notesPageExistsFor: aPage [
	^ (aPage database hasPageNamed: 'Notes for: ' , aPage title)
		ifTrue: [ true ]
		ifFalse: [ aPage database pages
				detect: [ :p | (p hasTagNamed: 'Notes') and: [ p allOutgoingTargets includes: aPage ] ]
				ifOne: [ :p | true ]
				ifNone: [ false ] ]
]

{ #category : #'*ONGtExperiments' }
LePage >> notesPageFor: aPage [
	| newTitle notesPage newPage |
	newTitle := 'Notes for: ' , aPage title.
	notesPage := (aPage database hasPageNamed: newTitle)
			ifTrue: [ aPage database pageNamed: newTitle ]
			ifFalse: [ aPage database pages
					detect: [ :p | (p hasTagNamed: 'Notes') and: [ p allOutgoingTargets includes: aPage ] ]
					ifNone: [ newPage := (LePage named: 'Notes for: ' , aPage title)
								addSnippet: (LeTextSnippet new
										string: ' [[Notes]] for [[' , aPage title , ']]';
										yourself);
								yourself.
						aPage database addPage: newPage.
						newPage ] ].
	^ notesPage
]
